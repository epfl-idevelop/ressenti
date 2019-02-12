// docker run --user 1000:1000 -v $PWD/out:/tmp webcapture capture.js /tmp http://www.epfl.ch/ http://www.kandou.com/
// docker run --user 1000:1000 -v $PWD/out:/tmp webcapture capture.js /tmp epfl::http://www.epfl.ch/ kandou::http://www.kandou.com/
const puppeteer = require('puppeteer');
var fs = require('fs');

(async () => {
  // const browser = await puppeteer.launch();
  const outdir = process.argv[2];
  const browser = await puppeteer.launch({headless: true, args: ["--no-sandbox", "--disk-cache-size=0"]});
  for (let i = 3; i < process.argv.length; ++i) {
    var url=process.argv[i];
    var hn;
    // if (url.match(/^[a-zA-Z_-\.]+::/)) {
    if (url.match(/^[^:]+::/)) {
      // split function in js is soo stupid!
      var a=url.split("::");
      hn=a.shift();
      url=a.join("::");
    } else {
      hn=new URL(url).hostname;
    }

    const context = await browser.createIncognitoBrowserContext();

    // Create a new page in a pristine context.
    const page = await context.newPage();
    await page.setCacheEnabled(false);

    // TODO: see if we can just  fix the width and still get the full page
    // await page.setViewport({
    //   width: 1280,
    //   height: 2048,
    //   deviceScaleFactor: 2,
    //   hasTouch: false,
    //   isLandscape: false
    // });
    console.log("  Getting " + url);
    try 
      await page.goto(url);
    catch(error) {
      console.log("Error while getting " + url + ": " + error);
      context.close();
      continue;
    }
    var logpath = outdir + "/" + hn + ".log";
    var pngpath = outdir + "/" + hn + ".png";

    const entries = await page.evaluate( () => JSON.stringify(performance.getEntries(), null, " ") );
    const performance = await page.evaluate( () => JSON.stringify(performance.toJSON(), null, " ") ); 
    const perf = await page.metrics(); 


    var stream = fs.createWriteStream(logpath);
    stream.once('open', function(fd) {
      stream.write("{\"entries\": "); 
      stream.write( entries + ",\n");
      stream.write("\"performance\" :");
      stream.write( performance + ",\n"); 
      stream.write("\"metrics\": ");
      stream.write( JSON.stringify(perf, null, " "));
      stream.write("}");
      stream.end();
    });

    await page.screenshot({path: pngpath, fullPage: true});
    await context.close();
  }
  await browser.close();
})();