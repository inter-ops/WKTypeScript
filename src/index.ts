function postMessage(msg: string) {
  window.webkit.messageHandlers.eventListeners.postMessage(`${msg}`);
}

function toggle() {
  postMessage(`Toggle`);
}

function setLabel(text: string) {
  postMessage(`[setLabel] ${text}`);
  return text;
}

function hideLabel(hidden = false) {
  postMessage(`[hideLabel] ${hidden}`);
  return hidden;
}

function addNumbers(a: number, b: number) {
  const sum = a + b;
  postMessage(`[addNumbers] ${sum}`);
}

enum Device {
  Phone = "iPhone",
  Pad = "iPad",
  Mac = "macOS"
}
function selectDevice(device: Device) {
  const deviceString = device.toString();
  postMessage(`[selectDevice] ${deviceString}`);
  return deviceString;
}

enum Mode {
  Light = "light",
  Dark = "dark"
}
function setMode(mode = Mode.Light) {
  let modeCase = "";
  if (mode === Mode.Light) {
    modeCase = "Mode.Light";
  } else {
    modeCase = `Mode.Dark`;
  }
  postMessage(`[setMode] mode: ${modeCase}, setting to ${mode.toString()} mode.`);
  return mode;
}

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
  window.webkit.messageHandlers.eventListeners.postMessage(result);
}
