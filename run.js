const puppeteer = require("puppeteer");

const args = process.argv;
const url = args[2];

(async () => {
  const browser = await puppeteer.launch({ headless: true });
  const context = browser.defaultBrowserContext();

  await context.overridePermissions(url, ["notifications"]);

  const page = await browser.newPage();

  await page.goto(url, {
    waitUntil: "networkidle2"
  });

  await page.waitFor(10000);
  await page.screenshot({ path: "org.png" });

  await browser.close();
})();
