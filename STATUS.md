---
mod:        Crystal Ball
packageId:  nelim.crystalball
depot:      Rimworld-Crystal-Ball
visibilite: public
detache:    oui
etape:      done
licence:    original
licence_ou: creation originale, MIT
vitrine:    complete
teste_le:
workshop:   
reste:
  - non_verifie: les quinze scenarios de TESTING.md, aucun joue
  - non_verifie: un colon se sert-il de la boule dans une piece sans la moindre chaise (scenario 5)
  - non_verifie: l'alerte vanilla des batiments de loisir sans chaise nomme-t-elle la boule (scenario 6)
  - non_verifie: jamais televerse sur le Workshop, la vitrine n'a donc jamais ete vue en place
session:    local_f3be24f6-fe14-4195-bd8c-b3dc8946784c
maj:        2026-09-12, session du mod
---

# Crystal Ball — etat

Fiche d'etat, lue par une passe sur tous les mods plutot qu'en interrogeant les fils un a un.
Elle vit a la racine, jamais dans `Mod/`, donc Steam ne la recoit pas.

Les champs ci-dessus ont ete deduits du disque le 2026-09-12. Ceux que la passe ne pouvait pas
deduire ont ete renseignes le meme jour :

- **`etape`** — `done` confirme. Sorti en 1.0.0 le 2026-09-04, public, depot autonome depuis le
  2026-09-11, couvert par 35 tests hors jeu qui passent. Ce qui reste n'est pas du developpement.
- **`licence`** — `original`, la ou la passe avait laisse `?` faute d'`ATTRIBUTION.md`. Il n'y en
  a pas parce qu'il n'y a rien a attribuer : quatre defs, une texture dessinee pour lui, MIT. Le
  comportement est celui de la table d'echecs de Core, ce qui est un usage du jeu et non un
  emprunt a un mod.
- **`teste_le`** — laisse vide, et c'est exact : personne n'a jamais vu cette boule tourner.
  Aucune colonie ne l'a chargee, le `packageId` n'est dans aucun `ModsConfig.xml`. La jonction
  vers `RimWorld/Mods`, elle, est en place.
- **`workshop`** — vide, et exact : pas de `PublishedFileId.txt` dans `Mod/`, donc rien n'a jamais
  ete televerse. La vitrine est prete pour autant, image de presentation comprise.
- **`reste`** — la ligne posee d'office est remplacee par quatre. Les deux du milieu sont les
  seules vraies inconnues du mod. Le scenario 5 est le reglage qui casse en silence : `requireChair`
  n'a qu'un lecteur dans tout le jeu, et quand il ne mord pas, le symptome est un colon qui ne
  vient jamais. Le scenario 6 est l'inverse, une alerte qui pourrait nommer a tort un batiment
  qui n'a besoin d'aucune chaise ; elle inspecte les batiments d'un donneur de loisir et cherche
  une assise dans les quatre cases cardinales, et savoir si la boule entre dans son champ demande
  de la voir tourner.

Le premier essai en jeu videra donc l'essentiel de `reste` d'un coup.

Rappel des categories de `reste` : `feature` pour une fonctionnalite manquante au premier jet,
`defaut` pour un defaut connu non corrige, `non_verifie` pour ce qui n'a pas pu etre verifie.

Le champ `session` n'a pas ete touche : il vient du releve.

Vocabulaire de `licence` : `open` licence explicite, `silent` aucune licence et source morte,
`alive` aucune licence mais source vivante, `forbidden` refus ecrit, `original` rien de repris.
