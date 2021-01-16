/**
 * @name FloodRunner landing page
 *
 * @desc Navigates to FloodRunner (floodrunner.dev) landing page and takes a screenshot
 */

const page = await browser.newPage();
await page.setViewport({
  width: 1280,
  height: 800,
});
console.log("Navigating to FloodRunner...");
await page.goto("https://www.floodrunner.dev/");
console.log("Taking landing page screenshot...");
await page.screenshot({
  path: path.join(screenshotPath, "landingpage.png"),
  fullPage: true,
});
console.log("Completed Puppeteer script...");
