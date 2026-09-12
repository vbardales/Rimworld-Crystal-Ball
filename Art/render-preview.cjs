const fs=require('fs'),path=require('path'),http=require('http');
const {chromium}=require('playwright'),sharp=require('sharp');
const root=path.resolve(__dirname,'..');
const lum=c=>c.map(v=>v/255).map(v=>v<=.04045?v/12.92:((v+.055)/1.055)**2.4).reduce((s,v,i)=>s+v*[.2126,.7152,.0722][i],0);
const rgb=h=>h.match(/[a-f\d]{2}/gi).map(x=>parseInt(x,16));
const contrast=(a,b)=>(Math.max(a,b)+.05)/(Math.min(a,b)+.05);
(async()=>{
 const server=http.createServer((req,res)=>{const p=path.resolve(root,'.'+decodeURIComponent(req.url.split('?')[0]));if(!p.startsWith(root+path.sep)){res.writeHead(403).end();return;}fs.readFile(p,(e,b)=>{if(e){res.writeHead(404).end();return;}res.setHeader('Content-Type',p.endsWith('.html')?'text/html':p.endsWith('.json')?'application/json':p.endsWith('.png')?'image/png':'text/xml');res.end(b)});});
 await new Promise(r=>server.listen(0,'127.0.0.1',r));
 let browser;
 try{
 browser=await chromium.launch({channel:'chrome',headless:true});
 const page=await browser.newPage({viewport:{width:896,height:504},deviceScaleFactor:1});
 await page.goto(`http://127.0.0.1:${server.address().port}/Art/Preview.html`);await page.evaluate(()=>window.ready);
 const cdp=await page.context().newCDPSession(page);await cdp.send('DOM.enable');await cdp.send('CSS.enable');
 const {root:doc}=await cdp.send('DOM.getDocument');const fonts={};
 for(const sel of ['h1','.summary','.version']){const {nodeId}=await cdp.send('DOM.querySelector',{nodeId:doc.nodeId,selector:sel});fonts[sel]=(await cdp.send('CSS.getPlatformFontsForNode',{nodeId})).fonts;}
 const rects=await page.evaluate(()=>Object.fromEntries(['h1','.summary','.version'].map(s=>{const r=document.querySelector(s).getBoundingClientRect();return [s,{x:r.x,y:r.y,width:r.width,height:r.height}]})));
 const output=path.join(root,'Mod/About/Preview.png');await page.screenshot({path:output});
 await sharp(output).resize({width:268}).toFile(path.join(__dirname,'Preview-268.png'));
 await page.addStyleTag({content:'.plate,.version{visibility:hidden}'});
 const bg=await page.screenshot({path:path.join(__dirname,'preview-background.png')});
 const {data,info}=await sharp(bg).removeAlpha().raw().toBuffer({resolveWithObject:true});
 const pal=JSON.parse(fs.readFileSync(path.join(__dirname,'preview-palette.json'),'utf8').replace(/^\uFEFF/,''));
 const ratios={};for(const sel of ['h1','.summary']){const r=rects[sel];let min=100;for(let y=Math.floor(r.y);y<Math.ceil(r.y+r.height);y++)for(let x=Math.floor(r.x);x<Math.ceil(r.x+r.width);x++){const i=(y*info.width+x)*3;min=Math.min(min,contrast(lum(rgb(pal.inkPrimary)),lum([...data.subarray(i,i+3)])));}ratios[sel]=min;}
 ratios.badge=contrast(lum(rgb(pal.badgeInk)),lum(rgb(pal.accent)));
 const report={fonts,rects,contrastMinimumAcrossEntireTextRectangles:ratios,tag:'Not applicable: public original mod, no tag',dimensions:[896,504],bytes:fs.statSync(output).size,source:'Art/Preview.png',version:await page.locator('.version').textContent()};
 fs.writeFileSync(path.join(__dirname,'preview-qa.json'),JSON.stringify(report,null,2));console.log(JSON.stringify(report,null,2));
 if(Object.values(ratios).some(v=>v<4.5))throw Error('Contrast below 4.5');
 if(report.bytes>=900*1024)throw Error('PNG too large');
 if(Object.values(fonts).flat().some(f=>!['Segoe UI','Segoe UI Semibold'].includes(f.familyName)))throw Error('Unexpected font');
 }finally{if(browser)await browser.close();server.close();}
})().catch(e=>{console.error(e);process.exitCode=1});

