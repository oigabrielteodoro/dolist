open Render

module Styles = {
  open Emotion

  let { toString: colorToString } = module(Theme.Colors)

  let button = css({
    "border": "0",
    "outline": "none",
    "height": "3.8rem",
    "minWidth": "10.5rem",
    "borderRadius": "0.6rem",
    "color": Theme.Colors.white->colorToString,
    "backgroundColor": Theme.Colors.primary->colorToString,
    "fontSize": "1.6rem",
    "lineHeight": "2.1rem",
    "letterSpacing": "-0.035rem",
    "transition": "300ms",
    "&:hover": {
      "backgroundColor": Theme.Colors.primaryDark->colorToString,
    }
  })
}

@react.component
let make = (~children, ~onClick=?) => {
  <button ?onClick className=Styles.button> {children->s} </button>
}