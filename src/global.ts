/*
 * WebKit Event Listeners: Post Message
 * Sends commands, as a string, to the Swift console.
 * @param msg The message to send to the console
 * @returns A message in the Swift console, ie. "[WKTS] toggled!"
 */
function postMessage(msg: string) {
  window.webkit.messageHandlers.eventListeners.postMessage(`[WKTS] ${msg}`);
}
