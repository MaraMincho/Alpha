const DomParser = require('dom-parser');

console.log("hello world")
const text =
    '<language>' +
    '<name>HTML</name>' +
    '<category>web</category>' +
    '<priority>high<h1>asdf</h1></priority>' +
    "<standard version='5.1'>W3C</standard>" +
    '</language>';

let xmlParser = new DomParser(); //DOM파서 객체를 생성
let xmlDoc = xmlParser.parseFromString(text, "text/xml"); // parseFromString() 메소드를 이용해 문자열을 파싱함.
let value = xmlDoc.getElementsByTagName("priority")[0].textContent;
console.log(value); // HTML
console.log(value)