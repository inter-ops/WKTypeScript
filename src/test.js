function returnBool() {
  return true;
}
function returnString() {
  return "Hello";
}
function returnNumber() {
  return 14;
}
function returnBoolArray() {
  return [true, false, false, true];
}
function returnStringArray() {
  return ["John", "Male", "35"];
}
function returnNumberArray() {
  return [1, 2, 3, 4, 5, 6, 7, 8, 9];
}
function postMessageTest() {
  window.webkit.messageHandlers.eventListeners.postMessage("returnBool: " + returnBool());
  window.webkit.messageHandlers.eventListeners.postMessage("returnString: " + returnString());
  window.webkit.messageHandlers.eventListeners.postMessage("returnNumber: " + returnNumber());
}
function postMessageTestArray() {
  window.webkit.messageHandlers.eventListeners.postMessage("returnBoolArray: " + returnBool());
  window.webkit.messageHandlers.eventListeners.postMessage(
    "returnStringArray: " + returnStringArray()
  );
  window.webkit.messageHandlers.eventListeners.postMessage(
    "returnNumberArray: " + returnNumberArray()
  );
}
