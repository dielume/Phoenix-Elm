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
import Example from "./example"
import socket from "./socket"


Order.init()
var elmDiv = document.getElementById("elm-main");
if(elmDiv != null){
  Elm.Main.embed(elmDiv, {
          data: elmDiv.getAttribute("data")
      });
}

var elmChef = document.getElementById("elm-chef");
if(elmChef != null){
  Elm.Chef.embed(elmChef, {
          data: elmChef.getAttribute("data")
      });
}



// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
