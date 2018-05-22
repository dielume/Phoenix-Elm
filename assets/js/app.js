// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".


import "phoenix_html"
import Order from "./order"
import "toastr"
global.toastr = require("toastr")


Order.init()
var elmDiv = document.getElementById("elm-main");
if(elmDiv != null){
  var portOrder = Elm.Main.embed(elmDiv, {
          data: elmDiv.getAttribute("data")
      });
  portOrder.ports.orderToJs.subscribe(function (str) {
    console.log("got from Elm:", str);
    toastr["success"]("My name is Inigo Montoya. You killed my father. Prepare to die!");
  });
}

var elmChef = document.getElementById("elm-chef");
if(elmChef != null){
  Elm.Chef.embed(elmChef, {
          data: elmChef.getAttribute("data")
      });
}

toastr.options = {
  "closeButton": true,
  "debug": false,
  "newestOnTop": true,
  "progressBar": false,
  "positionClass": "toast-top-right",
  "preventDuplicates": false,
  // "onclick": null,
  "showDuration": "300",
  "hideDuration": "1000",
  "timeOut": "5000",
  "extendedTimeOut": "1000",
  "showEasing": "swing",
  "hideEasing": "linear",
  "showMethod": "fadeIn",
  "hideMethod": "fadeOut"
}

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
