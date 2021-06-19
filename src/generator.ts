// TODO: this file should not be here, it should be placed in an npm package that users
// can install into a TS project

import fs from "fs";
import path from "path";
import { Project, Node, SyntaxKind } from "ts-morph";

type SwiftTypes = "String" | "Double" | "Bool";
type TsTypes = "string" | "number" | "boolean";

const tsToSwiftMap: { [key in TsTypes]: SwiftTypes } = {
  string: "String",
  number: "Double",
  boolean: "Bool"
};

interface ParsedParam {
  label: string;
  // swift type
  type: string;
  default?: string;
}
interface ParsedFile {
  [funcName: string]: {
    parameters: ParsedParam[];
    returnType?: string;
  };
}
// output from ts-morph parser
interface ParsedTypes {
  [fileName: string]: ParsedFile;
}

const readFile = (fileName: string): ParsedFile => {
  const project = new Project({
    tsConfigFilePath: "tsconfig.json"
  });

  const filePath = path.join(__dirname, fileName);
  console.log(filePath);

  // project.addSourceFilesAtPaths([filePath]);

  const parsedTyped: ParsedFile = {};
  const sourceFile = project.getSourceFileOrThrow(filePath);

  for (const statement of sourceFile.getStatements()) {
    if (!Node.isVariableStatement(statement)) continue;

    if (statement.hasExportKeyword()) {
      console.log("Has export keyword: ", statement.getKindName());
    }
    const varDeclList = statement.getFirstChildByKind(SyntaxKind.VariableDeclarationList);
    if (!varDeclList) {
      continue;
    }

    const varDecl = varDeclList.getFirstChildByKind(SyntaxKind.VariableDeclaration);
    if (!varDecl) {
      continue;
    }

    const identifier = varDecl.getFirstChildByKind(SyntaxKind.Identifier);
    if (!identifier) {
      continue;
    }

    const arrowFunc = varDecl.getFirstChildByKind(SyntaxKind.ArrowFunction);
    if (!arrowFunc) {
      continue;
    }

    // const isAsync = arrowFunc.isAsync();
    // const arrowFuncType = arrowFunc.getType();

    const parameters = arrowFunc.getChildrenOfKind(SyntaxKind.Parameter)?.map((param) => {
      const paramIdentifier = param.getFirstChildByKind(SyntaxKind.Identifier);
      const label = paramIdentifier?.getText() ?? "";

      const typeNode = param.getChildAtIndex(1);
      const defaultValueNode = param.getChildAtIndex(2);

      const type = tsToSwiftMap[typeNode.getText() as TsTypes];

      const parsedParam: ParsedParam = {
        label,
        type
      };

      if (defaultValueNode) parsedParam.default = defaultValueNode?.getText();

      return parsedParam;
    });

    const name = identifier.getText();
    parsedTyped[name] = {
      ...(parsedTyped[name] ?? {}),
      parameters
    };
  }

  return parsedTyped;
};

// TODO: remove file segmentation, user will provide an "entry point" TS file that exports all funcs

const generateFile = (fileName: string, fileTypes: ParsedTypes["fileName"]) => {
  let swiftStr = "";
  swiftStr += "import Foundation\n\n";
  swiftStr += "extension TypeSwift {\n";
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

// const testParsedTypes: ParsedTypes = {
//   index: {
//     toggle: {
//       parameters: []
//     },
//     setLabel: {
//       parameters: [
//         {
//           label: "text",
//           type: "String"
//         }
//       ]
//     },
//     hideObject: {
//       parameters: [
//         {
//           label: "hidden",
//           type: "Bool",
//           default: "false"
//         }
//       ]
//     },
//     addNumbers: {
//       parameters: [
//         {
//           label: "a",
//           type: "Double"
//         },
//         {
//           label: "b",
//           type: "Double"
//         }
//       ]
//     }
//   }
// };

const fileName = "player";
const parsedTypes = readFile(`${fileName}.ts`);
console.log(parsedTypes);

const swiftStr = generateFile(fileName, parsedTypes);
fs.writeFileSync(`${fileName}.swift`, swiftStr);

// TODO: run  swiftformat
