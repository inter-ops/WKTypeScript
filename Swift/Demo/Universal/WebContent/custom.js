var coll = document.getElementsByClassName("collapsible");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function () {
    this.classList.toggle("active");
    var content = this.nextElementSibling;
    var tocHeader = document.querySelector("body > div.toc > button > h2");
    if (content.style.display === "block") {
      content.style.display = "none";
      tocHeader.innerHTML = "Table of Contents &nbsp; &#43;";
    } else {
      content.style.display = "block";
      tocHeader.innerHTML = "Table of Contents &nbsp; &#8722;";
    }
  });
}

function clearLabelText() {
  document.getElementById("LabelTextField").value = "";
}

function getSum() {
  var a = document.getElementById("NumberA").value;
  var b = document.getElementById("NumberB").value;
  var sum = Number(a) + Number(b);

  var resultField = document.getElementById("ResultField");
  resultField.value = String(a) + " + " + String(b) + " = " + String(sum);
}
