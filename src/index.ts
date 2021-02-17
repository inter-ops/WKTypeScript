/*
 * FUNCTIONS
 * WKTS extracts the functions and parameters from these and generates the Functions.swift file.
 */
const anchorDelay = 500;
const actionDelay = 400;

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

/****************/
/* DEMO HELPERS */
/****************/
/* DO NOT TOUCH */
/****************/

/* @ignore */
enum Anchor {
  Toggle = "#Toggle",
  SetLabel = "#SetLabel",
  HideObject = "#HideObject",
  AddNumbers = "#AddNumbers",
  SelectDevice = "#SelectDevice",
  SetMode = "#SetMode"
}
/* @ignore */
function goTo(anchor: Anchor) {
  location.hash = anchor.toString();
}
