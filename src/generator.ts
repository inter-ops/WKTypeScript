// TODO: this file should not be here, it should be placed in an npm package that users
// can install into a TS project

import fs from "fs";

// output from ts-morph parser
interface ParsedTypes {
  [fileName: string]: {
    [funcName: string]: {
      parameters: {
        label: string;
        // swift type
        type: string;
        default?: string;
      }[];
      returnType?: string;
    };
  };
}

// TODO: remove file segmentation, user will provide an "entry point" TS file that exports all funcs

const generateFile = (fileName: string, fileTypes: ParsedTypes["fileName"]) => {
  let swiftStr = "";
  swiftStr += "import Foundation\n\n";
  swiftStr += "extension TypeScript {\n";
  swiftStr += `enum ${fileName} {\n`;

  // loop through each function and add it to swiftStr
  for (const [funcName, funcDetails] of Object.entries(fileTypes)) {
    let funcStr = "";
    funcStr += `case ${funcName}(`;

    if (funcDetails.parameters.length > 0) {
      // function params
      for (const param of funcDetails.parameters) {
        funcStr += `_ ${param.label}: ${param.type}`;
        if (param.default !== undefined) funcStr += ` = ${param.default}`;

        funcStr += ",";
      }

      // remove trailing comma
      funcStr = funcStr.slice(0, -1);
    } else {
      funcStr += "Void = ()";
    }

    // closes `case ${funcName}(`
    funcStr += ")";

    // add response type if exists
    if (funcDetails.returnType) funcStr += ` -> ${funcDetails.returnType}`;

    swiftStr += funcStr + "\n";
  }

  swiftStr += "\n";
  swiftStr += "var js: String {\n";
  swiftStr += "switch self {\n";

  // do the same thing as above but add support for `evaluate` in older WKWebView
  for (const [funcName, funcDetails] of Object.entries(fileTypes)) {
    let funcStr = "";
    funcStr += `case .${funcName}(`;

    // function params
    for (const param of funcDetails.parameters) {
      funcStr += `let ${param.label}`;
      funcStr += ",";
    }

    // remove trailing comma if it was added from the param loop above
    if (funcStr[funcStr.length - 1] === ",") funcStr = funcStr.slice(0, -1);

    // closes `case .${funcName}(`
    funcStr += ")";

    funcStr += `: return JS.function("${funcName}(`;

    for (const param of funcDetails.parameters) {
      funcStr += `\\(${param.label})`;
      funcStr += ",";
    }

    // remove trailing comma if it was added from the param loop above
    if (funcStr[funcStr.length - 1] === ",") funcStr = funcStr.slice(0, -1);

    // closes `: return JS.function("${funcName}(`
    funcStr += `)")`;

    swiftStr += funcStr + "\n";
  }

  // closes `var js: String {`
  swiftStr += "}\n";
  // closes `switch self {`
  swiftStr += "}\n";

  // closes `enum ${fileName} {`
  swiftStr += "}\n";
  // closes `extension TypeScript {`
  swiftStr += "}";

  return swiftStr;
};

const testParsedTypes: ParsedTypes = {
  index: {
    toggle: {
      parameters: []
    },
    setLabel: {
      parameters: [
        {
          label: "text",
          type: "String"
        }
      ]
    },
    hideObject: {
      parameters: [
        {
          label: "hidden",
          type: "Bool",
          default: "false"
        }
      ]
    },
    addNumbers: {
      parameters: [
        {
          label: "a",
          type: "Double"
        },
        {
          label: "b",
          type: "Double"
        }
      ]
    }
  }
};

const fileName = "index";
const swiftStr = generateFile(fileName, testParsedTypes[fileName]);
fs.writeFileSync(`${fileName}.swift`, swiftStr);
