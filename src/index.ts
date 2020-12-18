async function helloWorld2() {
  console.log("Hello world");
  console.log("Waiting 1 sec");

  await new Promise((r) => setTimeout(r, 1000));
  console.log("Done waiting");
}

helloWorld2();
