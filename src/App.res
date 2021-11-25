open ReactToastify
open Ancestor.Default

%%raw("import 'react-toastify/dist/ReactToastify.css'")

Emotion.injectGlobal({
  "html": { 
    "fontSize": "10px",
  },
  "html, body, #root": {
    "height": "100%",
    "width": "100%",
    "margin": "0",
    "padding": "0",
  },
  "body": {
    "overflow": "hidden",
  },
  "*": {
    "boxSizing": "border-box",
    "fontFamily": Theme.Constants.fontFamily,
  },
  "button": {
    "cursor": "pointer",
  },
  "ul": {
    "listStyle": "none",
  },
})

let client = ReactQuery.Provider.createClient()

@react.component
let make = () => {
  <ReactQuery.Provider client>
    <Box
      overflow=[xs(#auto)]
      p=[xs(4), md(9)]
      width=[xs(100.0->#pct)]
      height=[xs(100.0->#pct)]
      bgColor=[xs(Theme.Colors.black)]>
      <TaskContext.Provider>
        <Tasks />
      </TaskContext.Provider>
    </Box>

    <ToastContainer autoClose=3000 position=#topRight />
  </ReactQuery.Provider>
}
