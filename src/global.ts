/*
 * WebKit Event Listeners, Post Message:
 * Takes some message, as a `String`, and sends it to the Xcode console.
 * @param msg The message to be sent to the Xcode console
 * @returns A message, of type `String`, to be printed in the Xcode console, ie. "[WKTS] toggle() success"
 */
function postMessage(msg: string) {
  window.webkit.messageHandlers.eventListeners.postMessage(`[WKTS] ${msg}`);
}
