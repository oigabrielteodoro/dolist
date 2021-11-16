Emotion.injectGlobal({
  "html": {
    "fontSize": "10px"
  },
  "html, body, #root": {
    "width": "100%",
    "height": "100%",
    "margin": "0",
    "padding": "0"
  },
  "body": {
    "overflow": "hidden"
  },
  "#root": {
    "backgroundColor": Theme.Colors.black->Theme.Colors.toString,
  },
  "*": {
    "boxSizing": "border-box",
    "fontFamily": Theme.Constants.fontFamily
  }
})

@react.component
let make = () => {
  <h1> {`Hello from ReScript and Vite 😄`->React.string} </h1>
}
