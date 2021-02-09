/*
 * WebKit Event Listeners: Post Message
 * Sends commands, as a string, to the Swift console.
 * @param msg The message to send to the console
 * @returns A message in the Swift console, ie. "[WKTS] toggled!"
 */
function postMessage(msg: string) {
  window.webkit.messageHandlers.eventListeners.postMessage(`[WKTS] ${msg}`);
}

const anchorDelay = 500;
const actionDelay = 400;

/****************/
/* DEMO HELPERS */
/****************/
/* DO NOT TOUCH */
/****************/
enum Anchor {
  Toggle = "#Toggle",
  SetLabel = "#SetLabel",
  HideObject = "#HideObject",
  AddNumbers = "#AddNumbers",
  SelectDevice = "#SelectDevice",
  SetMode = "#SetMode"
}

function goTo(anchor: Anchor) {
  location.hash = anchor.toString();
}

/*
 * FUNCTIONS
 * WKTS extracts the functions and parameters from these and generates the Functions.swift file.
 */
async function toggle() {
  goTo(Anchor.Toggle);
  await new Promise((r) => setTimeout(r, anchorDelay));

  const toggleObject = <HTMLElement>document.getElementsByClassName("slider round")[0];
  toggleObject.click();
  postMessage(`Toggle`);
}

async function setLabel(text: string) {
  goTo(Anchor.SetLabel);
  await new Promise((r) => setTimeout(r, anchorDelay));

  const labelTextField = <HTMLInputElement>document.getElementById("LabelTextField");
  labelTextField.value = text;

  postMessage(`setLabel.text: ${text}`);
  return ""; //text
}

async function hideObject(hidden = false) {
  goTo(Anchor.HideObject);
  await new Promise((r) => setTimeout(r, anchorDelay));

  const objectToHide = <HTMLElement>document.querySelector(".objectToHide");
  let displayValue = "inherit";
  if (hidden) {
    displayValue = "none";
  }
  objectToHide.style.setProperty("display", displayValue);

  postMessage(`hideObject: ${hidden}`);
}

async function addNumbers(a: number, b: number) {
  goTo(Anchor.AddNumbers);
  await new Promise((r) => setTimeout(r, anchorDelay));

  const fieldA = <HTMLInputElement>document.getElementById("NumberA");
  const fieldB = <HTMLInputElement>document.getElementById("NumberB");
  fieldA.value = a.toString();
  await new Promise((r) => setTimeout(r, actionDelay));
  fieldB.value = b.toString();
  await new Promise((r) => setTimeout(r, actionDelay));

  const calculateButton = <HTMLElement>document.getElementById("CalculateButton");
  calculateButton.click();

  const sum = a + b;
  postMessage(`addNumbers: ${a} + ${b} = ${sum}`);
}

/*
 * Generates in Constants.swift, enum Constants:
 * enum Device
 *   case phone
 *   case pad
 *   case mac
 *
 * Note: Lowercase variables for Swifty switch naming scheme
 */
enum Device {
  Phone = "iPhone",
  Pad = "iPad",
  Mac = "macOS"
}

async function selectDevice(device: Device) {
  goTo(Anchor.SelectDevice);
  await new Promise((r) => setTimeout(r, anchorDelay));

  const deviceString = device.toString();

  const deviceDropdown = <HTMLSelectElement>document.getElementById("DeviceSelect");
  deviceDropdown.value = deviceString;

  postMessage(`selectDevice ${deviceString}`);
}

enum Mode {
  Light = "light",
  Dark = "dark"
}

let currentMode = Mode.Light;
async function setMode(mode = Mode.Light) {
  const printMode = currentMode;

  //goTo(Anchor.SetMode)
  //await new Promise((r) => setTimeout(r, anchorDelay))

  if (mode === currentMode) {
    // Mode already set
  } else {
    toggleTo(mode);
  }

  await new Promise((r) => setTimeout(r, actionDelay));
  postMessage(`setMode from: .${printMode.toString()}, to: .${mode.toString()}`);
}

/*
 * TODO: Some flag that specifies that this function is NOT to be generated for Functions.swift, nor Constants.swift.
 * This function manipulates the CSS of the page to reflect a light or dark mode.
 */
async function toggleTo(mode = Mode.Light) {
  currentMode = mode;

  /* Body */
  const body = document.querySelector("body");
  let textColor = "#000";
  let bgColor = "#FFF";
  //var linkColor = "#007AFF"

  /* Collapsible */
  const menuDropdown = document.querySelectorAll<HTMLElement>(".collapsible");
  let menuHeader = "#444";
  let menuBG = "#EEE";

  /* Collapsible: Content */
  const content = document.querySelectorAll<HTMLElement>(".content");
  let contentColor = "#000";
  let contentBG = "#F1F1F1";

  const toc = <HTMLElement>document.querySelector(".content.toc");
  let tocBG = "#FFF";

  /* Separator (hr) */
  const separator = document.querySelectorAll<HTMLElement>(".separator");
  let separatorStyle = "1px dashed #D0D0D0;";

  /* Input Fields */
  const inputFields = document.querySelectorAll<HTMLElement>("input[type='text']");
  let inputColor = "#000";
  let inputBG = "#E7E7E7";

  if (mode === Mode.Dark) {
    textColor = "#FFF";
    bgColor = "#000";

    menuHeader = "#FFF";
    menuBG = "#222";

    contentColor = "#FFF";
    contentBG = "#111";
    tocBG = "#111";

    separatorStyle = "1px dashed #343434;";

    inputColor = "#FFF";
    inputBG = "#39383D";
  }

  body?.style.setProperty("color", textColor);
  body?.style.setProperty("background", bgColor);

  menuDropdown.forEach(function (elem) {
    elem.style.setProperty("color", menuHeader);
    elem.style.setProperty("background-color", menuBG);
  });

  content.forEach(function (elem) {
    elem.style.setProperty("color", contentColor);
    elem.style.setProperty("background-color", contentBG);
  });

  toc.style.setProperty("background-color", tocBG);

  separator.forEach(function (elem) {
    elem.style.setProperty("border-top", separatorStyle);
  });

  inputFields.forEach(function (elem) {
    elem.style.setProperty("color", inputColor);
    elem.style.setProperty("background-color", inputBG);
  });
}

function toggleMode() {
  const printMode = currentMode;
  let mode = Mode.Light;

  if (Mode.Light === currentMode) {
    mode = Mode.Dark;
  }
  toggleTo(mode);

  postMessage(`toggleMode from: .${printMode.toString()}, to: .${mode.toString()}`);
}

/*
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

function hideObject(hidden = false) {
  postMessage(`[hideObject] ${hidden}`);
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
*/
