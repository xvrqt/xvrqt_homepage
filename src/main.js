/* Check if the browser has WebP support and load the smaller WebP images
 * instead. Elements with the "webp_q" class will have that class removed
 * and have the class "webp" or "no-webp" applied depending on browser support.
*/

async function supportsWebp() {
  if (!self.createImageBitmap) { return false; }
  const data = 'data:image/webp;base64,UklGRh4AAABXRUJQVlA4TBEAAAAvAAAAAAfQ//73v/+BiOh/AAA=';
  const blob = await fetch(data).then(r => r.blob());
  return createImageBitmap(blob).then(() => true, () => false);
}

(async () => {
  /* Set classes to determine which pics to load */
  const elements = document.getElementsByClassName("webp_q");
  const webp_support = await supportsWebp();

  /* Helper function to keep it DRY */
  for (let i = 0; i < elements.length; i++) {
    const ele = elements.item(i);
    ele.classList.remove("webp_q");
    if (webp_support) {
      ele.classList.add("webp");
    } else {
      ele.classList.add("no-webp");
    }
  }
})();
