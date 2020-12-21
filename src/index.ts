async function toggleMode() {
  const body = document.querySelector("body");

  if (!body?.hasAttribute("mode")) {
    body?.setAttribute("mode", "light");
  }

  const mode = body?.getAttribute("mode");

  if (mode == "light") {
    body?.style.setProperty("color", "#fff");
    body?.style.setProperty("background", "#000");
    body?.setAttribute("mode", "dark");
  } else {
    body?.style.setProperty("color", "#000");
    body?.style.setProperty("background", "#fff");
    body?.setAttribute("mode", "light");
  }

  await new Promise((r) => setTimeout(r, 1000));

  const result = "Mode: " + body?.getAttribute("mode")?.toString();
  /*
  // @ts--ignore
  window.webkit.messageHandlers.eventListeners.postMessage(result);
  */
  console.log(result);
}
