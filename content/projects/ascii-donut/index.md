---
title: "ASCII Donut"
description: "A simple ASCII renderer for a spinning torus"
---

<div id="console"></div>

<br><br><br>

## The Rotating Torus 
See the [original blog post](/rotating-torus) for more information.

[This](https://github.com/nicbk/donut-html) program was originally written in C,
and then compiled to WebAssembly using Emscripten.

This program projects a parameterized 3D torus onto a 2D screen.
Furthermore, all mathematical functions needed to render the torus are numerically appromixated
with custom functions.
This program was primarily written to utilize mathematical concepts learned from school.

<script type="text/javascript">
var Module = {
preRun: [],
postRun: [],
print: (function() {
  var element = document.getElementById('console');
  if (element) element.innerHTML = ''; // clear browser cache
  return function(text) {
    //if (arguments.length > 1) text = Array.prototype.slice.call(arguments).join(' ');
    // These replacements are necessary if you render to raw HTML
    text = text.replace(/&/g, "&amp;");
    text = text.replace(/</g, "&lt;");
    text = text.replace(/>/g, "&gt;");
    text = text.replace('\n', '<br>', 'g');
    text = text.replace(/\s/g, '&nbsp;');
    if (element) {
      if (text.includes("reset")) {
        element.innerHTML = "";
      } else
        {
            element.innerHTML += text;
            element.innerHTML += "<br>";
        }
      //element.scrollTop = element.scrollHeight; // focus on bottom
    }
  };
})(),
printErr: function(text) {
  if (arguments.length > 1) text = Array.prototype.slice.call(arguments).join(' ');
  console.error(text);
},
canvas: (function() {
})(),
setStatus: function(text) {
  if (!Module.setStatus.last) Module.setStatus.last = { time: Date.now(), text: '' };
  if (text === Module.setStatus.last.text) return;
  var m = text.match(/([^(]+)\((\d+(\.\d+)?)\/(\d+)\)/);
  var now = Date.now();
  if (m && now - Module.setStatus.last.time < 30) return; // if this is a progress update, skip it if too soon
  Module.setStatus.last.time = now;
  Module.setStatus.last.text = text;
},
totalDependencies: 0,
monitorRunDependencies: function(left) {
  this.totalDependencies = Math.max(this.totalDependencies, left);
  Module.setStatus(left ? 'Preparing... (' + (this.totalDependencies-left) + '/' + this.totalDependencies + ')' : 'All downloads complete.');
}
};
Module.setStatus('Downloading...');
window.onerror = function(event) {
// TODO: do not warn on ok events like simulating an infinite loop or exitStatus
Module.setStatus('Exception thrown, see JavaScript console');
Module.setStatus = function(text) {
  if (text) Module.printErr('[post-exception status] ' + text);
};
};
</script>

<script async type="text/javascript" src="donut.js"></script>

<style>
#console {
    white-space: nowrap;
    width: 55em;
    height: 47em;
    margin: auto;
    margin-top: 3%;
    margin-bottom: 1%;
    display: block;
    background-color: black;
    color: white;
    font-family: 'Lucida Console', Monaco, monospace;
    outline: none;
}
</style>
