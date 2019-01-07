/* Check if the browser has WebP support and load the smaller WebP images
 * instead. Elements with the "webp_q" class will have that class removed
 * and have the class "webp" or "no-webp" applied depending on browser support.
*/
let webp_support = false;
(() => {
  const img = new Image();

  /* Set classes to determine which pics to load */
  const webp_elements = document.getElementsByClassName("webp_q");

  /* Helper function to keep it DRY */
  function webp_class(elements: HTMLCollectionOf<Element>) {
    for (let i = 0; i < elements.length; i++) {
      const ele = elements.item(i);
      ele.classList.remove("webp_q");
      if (webp_support) {
        ele.classList.add("webp");
      } else {
        ele.classList.add("no-webp");
      }
    }
  }

  img.onload = () => {
    webp_support = !!(img.height > 0 && img.width > 0);
    webp_class(webp_elements);
  };

  img.onerror = () => {
    webp_support = false;
    webp_class(webp_elements);
  };

  img.src = "img/logo.webp";
})();
