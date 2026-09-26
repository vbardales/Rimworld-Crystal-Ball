using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using System.Xml.Linq;
using RimWorks.Pickle;
using RimWorld;
using UnityEngine;
using Verse;
using Verse.AI;

namespace CrystalBall.PickleSteps
{
    /// <summary>
    /// The steps of the Crystal Ball suite. The mod ships no assembly: a crystal ball is a plain <c>Building</c> that
    /// the game's own chess-table joy giver and sit-facing driver put to use, so every step here reaches it through
    /// the game's types and the mod's defNames, never through a class of the mod's own.
    ///
    /// Every step text starts with "Crystal Ball:". Pickle loads the steps of every active suite into one namespace,
    /// and two suites declaring the same text produce "Ambiguous step" on scenarios that are perfectly healthy.
    /// No step spells an English label: a quality is a word of the enum, a text is compared with what the pass's
    /// own language file says, so the assertions hold in whichever language the pass was staged with.
    ///
    /// What is deliberately NOT here is anything the offline suites already prove (the defs, the fields, who reads
    /// them) and anything that is the game's reaction to a flag the mod merely declares (the prison room, the
    /// minified thing, the pathing): see TESTING.md.
    /// </summary>
    [PickleSteps]
    public class CrystalBallSteps
    {
        private const string BallDefName = "CB_CrystalBall";
        private const string GiverDefName = "CB_GazeIntoCrystalBall";
        private const string JobDefName = "CB_GazeIntoCrystalBall";
        private const string KindDefName = "CB_Divination";
        private const string ModPackageId = "nelim.crystalball";

        // A patch of open ground the Pickle suite itself builds on: its construction and map features place walls,
        // stockpiles and stones between x 140..152 and z 150..165 of test-colony. The search for a spot starts here.
        private static readonly IntVec3 Anchor = new IntVec3(146, 0, 156);

        // ------------------------------------------------------------------ what a scenario remembers

        /// <summary>
        /// A ball is remembered by NAME, its cell and its quality, never by reference: a save and a reload replace
        /// every object of the map, so a Thing held across one is stale. It is found again by its cell.
        /// </summary>
        private sealed class Placed
        {
            public IntVec3 Cell;
            public QualityCategory Quality;
        }

        private sealed class Ledger
        {
            public readonly Dictionary<string, Placed> Balls = new Dictionary<string, Placed>();
            public readonly Dictionary<string, float> JoyAtOffer = new Dictionary<string, float>();
        }

        private static Ledger LedgerOf(PickleContext ctx)
        {
            Ledger ledger = null;
            try
            {
                ledger = ctx.Get<Ledger>();
            }
            catch (Exception)
            {
                // nothing remembered yet in this scenario
            }

            if (ledger == null)
            {
                ledger = new Ledger();
                ctx.Set(ledger);
            }

            return ledger;
        }

        // ------------------------------------------------------------------ finding things

        internal static Map CurrentMap(PickleContext ctx)
        {
            ctx.Require(Current.Game != null && Find.CurrentMap != null, "load a save first");
            return Find.CurrentMap;
        }

        internal static Pawn Colonist(PickleContext ctx, string nickname)
        {
            Pawn pawn = CurrentMap(ctx).mapPawns.FreeColonists.FirstOrDefault(p =>
                p.Name is NameTriple triple && triple.Nick == nickname)
                ?? CurrentMap(ctx).mapPawns.FreeColonists.FirstOrDefault(p => p.LabelShort == nickname);
            ctx.Assert(pawn != null, $"no colonist nicknamed \"{nickname}\"");
            return pawn;
        }

        private static Placed Record(PickleContext ctx, string name)
        {
            Placed placed;
            ctx.Assert(LedgerOf(ctx).Balls.TryGetValue(name, out placed),
                $"no ball was placed under the name \"{name}\"; the scenario placed: " +
                string.Join(", ", LedgerOf(ctx).Balls.Keys.Select(k => "\"" + k + "\"")));
            return placed;
        }

        /// <summary>The ball as the map holds it NOW, found by the cell it was placed on.</summary>
        internal static Thing BallNamed(PickleContext ctx, string name)
        {
            Placed placed = Record(ctx, name);
            Map map = CurrentMap(ctx);
            Thing ball = placed.Cell.GetThingList(map).FirstOrDefault(t => t.def.defName == BallDefName);
            ctx.Assert(ball != null,
                $"no {BallDefName} at ({placed.Cell.x}, {placed.Cell.z}) for the ball \"{name}\"; the cell holds: " +
                string.Join(", ", placed.Cell.GetThingList(map).Select(t => t.def.defName)));
            return ball;
        }

        private static JoyGiverDef Giver()
        {
            return DefDatabase<JoyGiverDef>.GetNamed(GiverDefName);
        }

        private static bool Uses(Pawn pawn, Thing ball)
        {
            Job job = pawn.CurJob;
            return job != null && job.def.defName == JobDefName && job.targetA.Thing == ball;
        }

        private static int Chebyshev(IntVec3 a, IntVec3 b)
        {
            return Math.Max(Math.Abs(a.x - b.x), Math.Abs(a.z - b.z));
        }

        /// <summary>
        /// Waits for a condition and, when it never comes true, fails with what the world looks like NOW.
        /// <c>PickleContext.WaitUntil</c> throws <see cref="TimeoutException"/> when it times out, so an Assert written
        /// after a bare await would be reached only when the wait already succeeded: a stuck colonist would read as
        /// "Step ... timed out" and nothing else.
        /// </summary>
        internal static async Task WaitOrExplain(PickleContext ctx, Func<bool> condition, float seconds, Func<string> explain)
        {
            try
            {
                await ctx.WaitUntil(condition, seconds);
            }
            catch (TimeoutException)
            {
                ctx.Assert(false, $"after {seconds:0} s: {explain()}");
            }
        }

        // ------------------------------------------------------------------ placing a ball

        /// <summary>
        /// Looks for a cell the ball can stand on, in radial order from the anchor. Three things make a cell fit:
        /// the game agrees a ball may be placed there, enough of its eight neighbours are open ground for a colonist
        /// to sit on, and no seat of any kind (a chair, a stool, a bench: anything the game calls sittable) lies within
        /// the radius asked for. The last is the whole point of the chairless scenario, so it is a condition of the
        /// spot rather than an assertion made afterwards about whatever spot happened to come up.
        /// </summary>
        private static IntVec3 FindSpot(PickleContext ctx, Map map, ThingDef def, int seatFreeRadius, IEnumerable<IntVec3> taken, IntVec3 anchor)
        {
            List<IntVec3> others = taken.ToList();
            foreach (IntVec3 cell in GenRadial.RadialCellsAround(anchor, 40f, true))
            {
                if (!cell.InBounds(map) || cell.Fogged(map) || cell.Roofed(map))
                {
                    continue;
                }

                // Balls stay apart, so that a scenario with two of them never has a colonist choose by accident.
                if (others.Any(o => (o - cell).LengthHorizontalSquared < 36))
                {
                    continue;
                }

                if (!GenConstruct.CanPlaceBlueprintAt(def, cell, Rot4.North, map).Accepted)
                {
                    continue;
                }

                int open = 0;
                for (int dx = -1; dx <= 1; dx++)
                {
                    for (int dz = -1; dz <= 1; dz++)
                    {
                        if (dx == 0 && dz == 0)
                        {
                            continue;
                        }

                        IntVec3 n = cell + new IntVec3(dx, 0, dz);
                        if (n.InBounds(map) && n.Standable(map) && n.GetEdifice(map) == null)
                        {
                            open++;
                        }
                    }
                }

                if (open < 4)
                {
                    continue;
                }

                bool seat = false;
                foreach (IntVec3 near in GenRadial.RadialCellsAround(cell, seatFreeRadius, true))
                {
                    if (!near.InBounds(map))
                    {
                        continue;
                    }

                    if (near.GetThingList(map).Any(t => t.def.building != null && t.def.building.isSittable))
                    {
                        seat = true;
                        break;
                    }
                }

                if (seat)
                {
                    continue;
                }

                return cell;
            }

            ctx.Assert(false,
                $"no cell within 40 of ({anchor.x}, {anchor.z}) fits a crystal ball with {seatFreeRadius} cells free of seats");
            return IntVec3.Invalid;
        }

        private static void Place(PickleContext ctx, string name, QualityCategory quality, int seatFreeRadius, IntVec3 anchor)
        {
            Map map = CurrentMap(ctx);
            Ledger ledger = LedgerOf(ctx);
            ctx.Assert(!ledger.Balls.ContainsKey(name), $"a ball named \"{name}\" was already placed");

            ThingDef def = DefDatabase<ThingDef>.GetNamed(BallDefName);
            IntVec3 cell = FindSpot(ctx, map, def, seatFreeRadius, ledger.Balls.Values.Select(b => b.Cell), anchor);

            Thing ball = ThingMaker.MakeThing(def);
            ball.SetFaction(Faction.OfPlayer);
            CompQuality comp = ball.TryGetComp<CompQuality>();
            ctx.Assert(comp != null, "the crystal ball carries no CompQuality");
            comp.SetQuality(quality, ArtGenerationContext.Outsider);
            GenSpawn.Spawn(ball, cell, map, Rot4.North);

            ledger.Balls[name] = new Placed { Cell = cell, Quality = quality };
            ctx.Attach("ball " + name, $"({cell.x}, {cell.z}), {quality}");
        }

        [Given("Crystal Ball: a crystal ball {string} stands on open ground with no seat within {int} cells")]
        public void PlaceBall(PickleContext ctx, string name, int seatFreeRadius)
        {
            Place(ctx, name, QualityCategory.Normal, seatFreeRadius, Anchor);
        }

        /// <summary>
        /// For a presentation picture on another fixture than the test colony: the same kind of spot, found from a cell
        /// the scenario names instead of from the test colony's own. It asks for no seat-free radius, since a picture
        /// is not a claim about chairs.
        /// </summary>
        [Given("Crystal Ball: a crystal ball {string} stands on open ground near \\({int}, {int}\\)")]
        public void PlaceBallNear(PickleContext ctx, string name, int x, int z)
        {
            Place(ctx, name, QualityCategory.Normal, 0, new IntVec3(x, 0, z));
        }

        [Given("Crystal Ball: a {word} crystal ball {string} stands on open ground with no seat within {int} cells")]
        public void PlaceBallOfQuality(PickleContext ctx, string quality, string name, int seatFreeRadius)
        {
            QualityCategory parsed;
            ctx.Require(Enum.TryParse(quality, true, out parsed),
                $"\"{quality}\" is not a quality: it is one of " + string.Join(", ", Enum.GetNames(typeof(QualityCategory))));
            Place(ctx, name, parsed, seatFreeRadius, Anchor);
        }

        // ------------------------------------------------------------------ the joy giver, asked as the game asks it

        /// <summary>
        /// The chain <c>JobGiver_GetJoy</c> runs for each giver: <c>CanBeGivenTo</c> first, then <c>TryGiveJob</c>.
        /// Asked directly instead of waiting for recreation time to pick the giver, because how often it picks it is
        /// <c>baseChance</c>, a die roll the base game owns and this mod only sets. Everything the giver decides
        /// after it has been picked is decided here.
        /// </summary>
        private static Job Offer(Pawn pawn, out string why)
        {
            JoyGiver giver = Giver().Worker;
            if (!giver.CanBeGivenTo(pawn))
            {
                PawnCapacityDef missing = giver.MissingRequiredCapacity(pawn);
                why = missing != null
                    ? $"CanBeGivenTo is false: {pawn.LabelShort} lacks the capacity {missing.defName}"
                    : "CanBeGivenTo is false";
                return null;
            }

            Job job = giver.TryGiveJob(pawn);
            why = job == null ? "CanBeGivenTo holds but TryGiveJob returned no job" : null;
            return job;
        }

        [When("Crystal Ball: the joy giver sends {string} to the ball {string}")]
        public void SendTo(PickleContext ctx, string nickname, string ballName)
        {
            Pawn pawn = Colonist(ctx, nickname);
            Thing ball = BallNamed(ctx, ballName);
            string why;
            Job job = Offer(pawn, out why);
            ctx.Assert(job != null, $"the joy giver offered {nickname} nothing: {why}");
            ctx.Assert(job.def.defName == JobDefName, $"the giver gave a {job.def.defName} job, not {JobDefName}");
            ctx.Assert(job.targetA.Thing == ball,
                $"the giver sent {nickname} to {job.targetA.Thing?.def.defName} at {job.targetA.Cell}, " +
                $"not to the ball \"{ballName}\" at {ball.Position}");

            LedgerOf(ctx).JoyAtOffer[nickname] = pawn.needs.joy.CurLevel;
            pawn.jobs.StartJob(job, JobCondition.InterruptForced);
        }

        [Then("Crystal Ball: the joy giver offers {string} nothing")]
        public void OffersNothing(PickleContext ctx, string nickname)
        {
            Pawn pawn = Colonist(ctx, nickname);
            string why;
            Job job = Offer(pawn, out why);
            ctx.Assert(job == null,
                $"the joy giver offered {nickname} a {job?.def.defName} job aimed at {job?.targetA.Thing?.def.defName} " +
                $"at {job?.targetA.Cell}, and it should have offered nothing");
        }

        [Then("Crystal Ball: the joy giver offers {string} a gaze")]
        public void OffersAGaze(PickleContext ctx, string nickname)
        {
            Pawn pawn = Colonist(ctx, nickname);
            string why;
            Job job = Offer(pawn, out why);
            ctx.Assert(job != null && job.def.defName == JobDefName,
                $"the joy giver offered {nickname} " + (job == null ? "nothing: " + why : "a " + job.def.defName + " job"));
        }

        // ------------------------------------------------------------------ what the colonist does

        [Then("Crystal Ball: {string} sits beside the ball {string}", TimeoutSeconds = 100f)]
        public async Task SitsBeside(PickleContext ctx, string nickname, string ballName)
        {
            Pawn pawn = Colonist(ctx, nickname);
            Thing ball = BallNamed(ctx, ballName);

            await WaitOrExplain(ctx,
                () => Uses(pawn, ball) && Chebyshev(pawn.Position, ball.Position) == 1 && !pawn.pather.Moving,
                90f,
                () => $"{nickname} is at {pawn.Position}, the ball at {ball.Position}; job " +
                      (pawn.CurJob == null ? "none" : pawn.CurJob.def.defName) + ", moving " + pawn.pather.Moving);

            // The driver the game runs for its own chess table is what sits the colonist down, which is the claim
            // the mod rests on: it must be that one, on the cell beside the ball and not on the ball itself.
            ctx.Assert(pawn.jobs.curDriver is JobDriver_SitFacingBuilding,
                $"{nickname} is gazing with a {pawn.jobs.curDriver?.GetType().Name}, not a JobDriver_SitFacingBuilding");
            ctx.Assert(pawn.Position != ball.Position, $"{nickname} stands on the ball's own cell {ball.Position}");
        }

        [Then("Crystal Ball: {string}'s joy has risen since the giver sent them")]
        public void JoyRose(PickleContext ctx, string nickname)
        {
            Pawn pawn = Colonist(ctx, nickname);
            float before;
            ctx.Assert(LedgerOf(ctx).JoyAtOffer.TryGetValue(nickname, out before),
                $"{nickname} was never sent to a ball by this scenario");
            float now = pawn.needs.joy.CurLevel;
            ctx.Assert(now > before + 0.005f, $"{nickname}'s joy was {before:0.000} when the giver sent them and is {now:0.000}");
        }

        [Then("Crystal Ball: nobody is using the ball {string}")]
        public void NobodyUses(PickleContext ctx, string ballName)
        {
            Thing ball = BallNamed(ctx, ballName);
            List<Pawn> users = CurrentMap(ctx).mapPawns.AllPawnsSpawned.Where(p => Uses(p, ball)).ToList();
            ctx.Assert(users.Count == 0,
                "these pawns are gazing into the ball: " + string.Join(", ", users.Select(p => p.LabelShort)));
        }

        // ------------------------------------------------------------------ the recreation type

        [Then("Crystal Ball: {string} has built up tolerance for divination")]
        public void HasTolerance(PickleContext ctx, string nickname)
        {
            Pawn pawn = Colonist(ctx, nickname);
            JoyKindDef kind = DefDatabase<JoyKindDef>.GetNamed(KindDefName);
            float tolerance = pawn.needs.joy.tolerances[kind];
            ctx.Assert(tolerance > 0f,
                $"{nickname}'s tolerance for {KindDefName} is {tolerance}: gazing did not credit the kind the mod added");
        }

        [Then("Crystal Ball: {string} has no tolerance for divination")]
        public void HasNoTolerance(PickleContext ctx, string nickname)
        {
            Pawn pawn = Colonist(ctx, nickname);
            JoyKindDef kind = DefDatabase<JoyKindDef>.GetNamed(KindDefName);
            float tolerance = pawn.needs.joy.tolerances[kind];
            ctx.Assert(tolerance <= 0f, $"{nickname} already has a tolerance for {KindDefName}: {tolerance}");
        }

        [Then("Crystal Ball: the recreation on the map lists divination")]
        public void MapListsDivination(PickleContext ctx)
        {
            JoyKindDef kind = DefDatabase<JoyKindDef>.GetNamed(KindDefName);
            string listed = JoyUtility.JoyKindsOnMapString(CurrentMap(ctx));
            ctx.Assert(listed != null && listed.IndexOf(kind.label, StringComparison.OrdinalIgnoreCase) >= 0,
                $"the recreation available on the map reads \"{listed}\" and does not name \"{kind.label}\"");
        }

        [Then("Crystal Ball: the recreation on the map does not list divination")]
        public void MapDoesNotListDivination(PickleContext ctx)
        {
            JoyKindDef kind = DefDatabase<JoyKindDef>.GetNamed(KindDefName);
            string listed = JoyUtility.JoyKindsOnMapString(CurrentMap(ctx));
            ctx.Assert(listed == null || listed.IndexOf(kind.label, StringComparison.OrdinalIgnoreCase) < 0,
                $"the recreation available on the map already names \"{kind.label}\": \"{listed}\"");
        }

        // ------------------------------------------------------------------ eyes and ears

        /// <summary>
        /// Takes every body part of a defName from a colonist and asserts the capacity that rests on it is gone.
        /// Blindness and deafness are the same removal with two names, and a scenario should not have to spell a hediff.
        /// </summary>
        private static void LoseEveryPart(PickleContext ctx, string nickname, string partDefName, PawnCapacityDef lost)
        {
            Pawn pawn = Colonist(ctx, nickname);
            List<BodyPartRecord> parts = pawn.RaceProps.body.AllParts.Where(p => p.def.defName == partDefName).ToList();
            ctx.Require(parts.Count > 0, $"{nickname}'s body has no part named {partDefName}");
            foreach (BodyPartRecord part in parts)
            {
                pawn.health.AddHediff(HediffDefOf.MissingBodyPart, part);
            }

            ctx.Assert(!pawn.health.capacities.CapableOf(lost),
                $"{nickname} still has {lost.defName} after losing {parts.Count} x {partDefName}");
        }

        [Given("Crystal Ball: {string} is made blind")]
        public void MakeBlind(PickleContext ctx, string nickname)
        {
            LoseEveryPart(ctx, nickname, "Eye", PawnCapacityDefOf.Sight);
            ctx.Assert(Colonist(ctx, nickname).health.capacities.CapableOf(PawnCapacityDefOf.Hearing),
                $"{nickname} lost hearing along with sight: the scenario would prove nothing");
        }

        [Given("Crystal Ball: {string} is made deaf")]
        public void MakeDeaf(PickleContext ctx, string nickname)
        {
            LoseEveryPart(ctx, nickname, "Ear", PawnCapacityDefOf.Hearing);
            ctx.Assert(Colonist(ctx, nickname).health.capacities.CapableOf(PawnCapacityDefOf.Sight),
                $"{nickname} lost sight along with hearing: the scenario would prove nothing");
        }

        // ------------------------------------------------------------------ the ball itself

        [Then("Crystal Ball: the beauty of the ball {string} is above that of the ball {string}")]
        public void BeautyAbove(PickleContext ctx, string better, string worse)
        {
            float a = BallNamed(ctx, better).GetStatValue(StatDefOf.Beauty);
            float b = BallNamed(ctx, worse).GetStatValue(StatDefOf.Beauty);
            ctx.Assert(a > b, $"the beauty of \"{better}\" is {a}, not above the {b} of \"{worse}\"");
        }

        [Then("Crystal Ball: the ball {string} is named for its quality")]
        public void NamedForQuality(PickleContext ctx, string name)
        {
            Thing ball = BallNamed(ctx, name);
            QualityCategory quality = ball.TryGetComp<CompQuality>().Quality;
            string word = quality.GetLabel();
            ctx.Assert(ball.LabelCap.ToString().IndexOf(word, StringComparison.OrdinalIgnoreCase) >= 0,
                $"the ball \"{name}\" is {quality} and its name reads \"{ball.LabelCap}\", without \"{word}\"");
        }

        [Then("Crystal Ball: the ball {string} glows with a radius of {int}")]
        public void Glows(PickleContext ctx, string name, int radius)
        {
            Thing ball = BallNamed(ctx, name);
            CompGlower glow = ball.TryGetComp<CompGlower>();
            ctx.Assert(glow != null, "the crystal ball carries no CompGlower");
            ctx.Assert(glow.Glows, "the crystal ball's glower is not lit");
            ctx.Assert(Math.Abs(glow.GlowRadius - radius) < 0.01f,
                $"the glow radius is {glow.GlowRadius}, not {radius}");
        }

        /// <summary>
        /// At night the sky gives nothing, so what lights the ground on the ball's own cell is the ball. Sky light is
        /// left out of the reading, and the scenario checks beforehand that nobody is gazing, since the claim is that
        /// the glow is there by itself and not while somebody uses it.
        /// </summary>
        [Then("Crystal Ball: the ground at the ball {string} is lit by the ball alone")]
        public void GroundLit(PickleContext ctx, string name)
        {
            Thing ball = BallNamed(ctx, name);
            float lit = CurrentMap(ctx).glowGrid.GroundGlowAt(ball.Position, false, true);
            ctx.Assert(lit > 0.3f, $"the ground under the ball glows at {lit:0.00} without the sky: the ball does not light it");
        }

        [Then("Crystal Ball: the ball {string} stands where it was, with the quality it had")]
        public void StandsAsBefore(PickleContext ctx, string name)
        {
            Placed placed = Record(ctx, name);
            Thing ball = BallNamed(ctx, name);
            CompQuality comp = ball.TryGetComp<CompQuality>();
            ctx.Assert(comp != null, "the reloaded ball carries no CompQuality");
            ctx.Assert(comp.Quality == placed.Quality,
                $"the ball \"{name}\" was {placed.Quality} and comes back {comp.Quality}");
        }

        // ------------------------------------------------------------------ looking at it

        [When("Crystal Ball: I select the ball {string}")]
        public void Select(PickleContext ctx, string name)
        {
            Thing ball = BallNamed(ctx, name);
            Find.Selector.ClearSelection();
            Find.Selector.Select(ball, false, false);
        }

        /// <summary>
        /// The "i" card of the ball, the window that carries the def's description. The inspect pane shows the name and
        /// the quality only, so this is the one place the description is seen laid out in the game.
        /// </summary>
        [When("Crystal Ball: I open the info card of the ball {string}")]
        public void OpenInfoCard(PickleContext ctx, string name)
        {
            Thing ball = BallNamed(ctx, name);
            Find.WindowStack.Add(new Dialog_InfoCard(ball, null));
            ctx.Assert(Find.WindowStack.WindowOfType<Dialog_InfoCard>() != null, "the info card did not open");
        }

        [When("Crystal Ball: I put the camera on the ball {string}")]
        public void CameraOn(PickleContext ctx, string name)
        {
            Find.CameraDriver.JumpToCurrentMapLoc(BallNamed(ctx, name).Position);
        }

        // ------------------------------------------------------------------ the language of the pass

        /// <summary>
        /// The four texts the mod owns, compared with what its own resources say for the language this pass was
        /// staged with: English is the value written in the def itself, French the DefInjected file. The language is
        /// fixed when the game starts and never switched inside a run, since <c>SelectLanguage</c> reloads every def
        /// under the runner, so this says something only in the language it runs in and the suite is played once per
        /// language.
        /// </summary>
        [Then("Crystal Ball: the four owned texts read in the language of the pass")]
        public void TextsInLanguage(PickleContext ctx)
        {
            // The game names a language folder after the language itself, "French (Français)", while the launcher's
            // -Language takes a prefix, "French". The first run of this step compared the whole name with "French"
            // and refused the pass it had been staged for, so the language is recognised by its prefix.
            string folderName = LanguageDatabase.activeLanguage.folderName;
            string language = folderName.StartsWith("English", StringComparison.OrdinalIgnoreCase) ? "English"
                : folderName.StartsWith("French", StringComparison.OrdinalIgnoreCase) ? "French"
                : folderName;
            // A green would not otherwise say which language it was staged in, since both branches below can pass.
            ctx.Attach("language", folderName);
            ModContentPack pack = LoadedModManager.RunningModsListForReading.FirstOrDefault(m =>
                string.Equals(m.PackageIdPlayerFacing, ModPackageId, StringComparison.OrdinalIgnoreCase));
            ctx.Require(pack != null, $"the mod {ModPackageId} is not among the running mods");

            var expected = new Dictionary<string, string>();
            if (language == "English")
            {
                XElement defs = XDocument.Load(Path.Combine(pack.RootDir, "Defs", "CrystalBall.xml")).Root;
                foreach (XElement def in defs.Elements())
                {
                    string defName = (string)def.Element("defName");
                    foreach (string field in new[] { "label", "description", "reportString" })
                    {
                        XElement e = def.Element(field);
                        if (e != null)
                        {
                            expected[defName + "." + field] = Normalise(e.Value);
                        }
                    }
                }
            }
            else if (language == "French")
            {
                string root = Path.Combine(pack.RootDir, "Languages", "French", "DefInjected");
                foreach (string file in Directory.GetFiles(root, "*.xml", SearchOption.AllDirectories))
                {
                    foreach (XElement e in XDocument.Load(file).Root.Elements())
                    {
                        expected[e.Name.LocalName] = Normalise(e.Value);
                    }
                }
            }
            else
            {
                ctx.Assert(false, $"this pass runs in \"{folderName}\"; the suite knows English and French");
            }

            var actual = new Dictionary<string, string>
            {
                [BallDefName + ".label"] = DefDatabase<ThingDef>.GetNamed(BallDefName).label,
                [BallDefName + ".description"] = DefDatabase<ThingDef>.GetNamed(BallDefName).description,
                [KindDefName + ".label"] = DefDatabase<JoyKindDef>.GetNamed(KindDefName).label,
                [JobDefName + ".reportString"] = DefDatabase<JobDef>.GetNamed(JobDefName).reportString,
            };

            ctx.Assert(actual.Count == 4, "expected four owned texts");
            foreach (KeyValuePair<string, string> pair in actual)
            {
                string want;
                ctx.Assert(expected.TryGetValue(pair.Key, out want), $"the {language} resources hold no entry for {pair.Key}");
                ctx.Assert(Normalise(pair.Value) == want,
                    $"in {language}, {pair.Key} reads \"{Normalise(pair.Value)}\" where the mod's own resources say \"{want}\"");
            }
        }

        /// <summary>A "\n" written in a resource file and the newline the game turns it into are the same text.</summary>
        private static string Normalise(string text)
        {
            return (text ?? string.Empty).Replace("\\n", "\n").Replace("\r\n", "\n").Trim();
        }
    }
}
