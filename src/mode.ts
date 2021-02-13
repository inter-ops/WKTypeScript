/* Xcode documentation for TypeScript object: Mode */
enum Mode {
  Light = "light",
  Dark = "dark"
}

/* @ignore this variable */
let currentMode = Mode.Light;

/* DONT @ignore this function */
async function setMode(mode = Mode.Light) {
  const printMode = currentMode;
  if (mode !== currentMode) {
    toggleTo(mode);
  }

  await new Promise((r) => setTimeout(r, actionDelay));
  postMessage(`setMode from: .${printMode.toString()}, to: .${mode.toString()}`);
}

/*
 * TODO: Some flag that specifies that this function is NOT to be generated for Functions.swift, nor Constants.swift.
 * This function manipulates the CSS of the page to reflect a light or dark mode.
 */

// @ignore
async function toggleTo(mode = Mode.Light) {
  currentMode = mode;

  /* Body */
  const body = document.querySelector("body");
  let textColor = "#000";
  let bgColor = "#FFF";

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
  let separatorStyle = "1px dashed #D0D0D0";

  /* Input Fields */
  const inputFields = document.querySelectorAll<HTMLElement>("input[type='text']");
  let inputColor = "#000";
  let inputBG = "#E7E7E7";

  const hideMeText = <HTMLElement>document.querySelector(".objectToHide > p > code");
  let hideMeTextColor = "#000";

  const codeBlocks = document.querySelectorAll<HTMLElement>("code");
  let codeBlockColor = "#000";

  if (mode === Mode.Dark) {
    textColor = "#FFF";
    bgColor = "#000";

    menuHeader = "#FFF";
    menuBG = "#222";

    contentColor = "#FFF";
    contentBG = "#111";
    tocBG = "#111";

    separatorStyle = "1px dashed #343434";

    inputColor = "#FFF";
    inputBG = "#39383D";

    hideMeTextColor = "#FFF";

    codeBlockColor = "#FFF";
  }

  body?.style.setProperty("color", textColor);
  body?.style.setProperty("background", bgColor);

  hideMeText.style.setProperty("color", hideMeTextColor);

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

  codeBlocks.forEach(function (elem) {
    elem.style.setProperty("color", codeBlockColor);
  });
}

// @ignore
function toggleMode() {
  const printMode = currentMode;
  let mode = Mode.Light;

  if (Mode.Light === currentMode) {
    mode = Mode.Dark;
  }
  toggleTo(mode);

  postMessage(`toggleMode from: .${printMode.toString()}, to: .${mode.toString()}`);
}
