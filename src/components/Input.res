module Styles = {
  open Emotion

  let {toString: colorToString} = module(Theme.Colors)

  let input = css({
    "color": Theme.Colors.white->colorToString,
    "backgroundColor": Theme.Colors.grayDark->colorToString,
    "fontSize": "1.8rem",
    "border": "none",
    "padding": "1.6rem 1.6rem",
    "borderRadius": "0.6rem",
    "outline": "none",
    "width": "100%",
    "transition": "300ms",
    "&:placeholder": {
      "color": Theme.Colors.grayLight->colorToString,
    },
    "&:focus": {
      "transition": "300ms",
      "boxShadow": `0 0 0 0.2rem ${Theme.Colors.primary->colorToString}`,
    },
  })
}

@react.component
let make = (~onChange=?, ~name=?, ~value=?, ~placeholder=?) => {
  <input ?onChange ?name ?placeholder ?value className=Styles.input />
}
