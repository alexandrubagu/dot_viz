// We import the CSS which is extracted to its own file by esbuild.
// Remove this line if you add a your own CSS build pipeline (e.g postcss).
import "../css/app.css"

// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
// import {Socket} from "phoenix"
// import {LiveSocket} from "phoenix_live_view"
// import topbar from "../vendor/topbar"

// let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
// let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

// Show progress bar on live navigation and form submits
// topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
// window.addEventListener("phx:page-loading-start", info => topbar.show())
// window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
// liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
// window.liveSocket = liveSocket



// // create an array with nodes
// var nodes = new vis.DataSet([{
//     id: 1,
//     label: "Node 1"
//   },
//   {
//     id: 2,
//     label: "Node 2"
//   },
//   {
//     id: 3,
//     label: "Node 3"
//   },
//   {
//     id: 4,
//     label: "Node 4"
//   },
//   {
//     id: 5,
//     label: "Node 5"
//   }
// ]);

// // create an array with edges
// var edges = new vis.DataSet([{
//     from: 1,
//     to: 3,
//     arrows: {
//       to: {
//         enabled: true,
//         type: "arrow",
//       },
//     },
//   },
//   {
//     from: 1,
//     to: 2,
//     arrows: "to",
//   },
//   {
//     from: 2,
//     to: 4
//   },
//   {
//     from: 2,
//     to: 5
//   },
//   {
//     from: 3,
//     to: 3
//   }
// ]);

// // create a network
// var container = document.getElementById("dot-viz");
// var data = {
//   nodes: nodes,
//   edges: edges
// };
// var options = {
//   edges: {
//     smooth: {
//       type: "cubicBezier",
//       forceDirection: "horizontal",
//       roundness: 0.2,
//     },
//   },
//   layout: {
//     hierarchical: {
//       direction: "UD",
//     },
//   },
//   physics: true,
// };
// var network = new vis.Network(container, data, options);

// network.on("doubleClick", function (params) {

//   console.log(params)
//   console.log(
//     "click event, getNodeAt returns: " +
//     this.getNodeAt(params.pointer.DOM)
//   );
// });



$(document).ready(() => {
  $('.selectpicker').selectpicker();


})


document.getElementById('filenames').addEventListener('change', function () {
  console.log('You selected: ', this.value);

  fetch(`/nodes/${this.value}`)
    .then(response => response.json())
    .then(data => data.nodes.map(node => {
      let option = document.createElement("option");
      option.text = node;
      option.value = node;
      var select = document.getElementById("nodes");
      select.appendChild(option);
      $('#nodes').selectpicker('refresh');
    }))
});

document.getElementById('nodes').addEventListener('change', function () {
  let dot_filename = $('#filenames').find(":selected").text()

  fetch(`/edges/${dot_filename}/${encodeURIComponent(this.value)}`)
    .then(response => response.json())
    .then(data => {
      console.log(data)
    })
});