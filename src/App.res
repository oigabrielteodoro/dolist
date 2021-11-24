open Ancestor.Default

Emotion.injectGlobal({
  "html": {
    "fontSize": "10px"
  },
  "html, body, #root": {
    "height": "100%",
    "width": "100%",
    "margin": "0",
    "padding": "0"
  },
  "body": {
    "overflow": "hidden"
  },
  "*": {
    "boxSizing": "border-box",
    "fontFamily": Theme.Constants.fontFamily
  },
  "button": {
    "cursor": "pointer",
  },
  "ul": {
    "listStyle": "none",
  }
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
      bgColor=[xs(Theme.Colors.black)]
    >
      <Tasks />
    </Box>
  </ReactQuery.Provider>
}
