// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"
import NProgress from "nprogress"
import {LiveSocket} from "phoenix_live_view"

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")

let Hooks = {}
Hooks.Date = {
    mounted() {
        this.el.innerHTML = `${new Date()}`;
    }
}
Hooks.ChatSend = {
    mounted() {
        let viewHook = this
        this.el.addEventListener("click", function() {
            let uni = document.getElementById("usernameinput")
            let ci = document.getElementById("chatinput")
            let username = uni.value
            let msg = ci.value
            if (msg == "" || username == "") {
                return
            }
            viewHook.pushEvent("send-chat", {msg, username})
            ci.value = ""
            ci.focus()
        })
    }
}
Hooks.ChatInput = {
    mounted() {
        this.el.addEventListener("keyup", function(e) {
            if (e.keyCode == 13) {
                e.preventDefault()
                document.getElementById("chatsendbutton").click()
            }
        })
    }
}

let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})

// Show progress bar on live navigation and form submits
window.addEventListener("phx:page-loading-start", info => NProgress.start())
window.addEventListener("phx:page-loading-stop", info => NProgress.done())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

