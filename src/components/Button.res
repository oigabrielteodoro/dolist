open Render
open Ancestor.Default

module Styles = {
  open Emotion

  let { toString: colorToString } = module(Theme.Colors)

  let button = (~disabled) => css({
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
    "cursor": disabled ? "not-allowed" : "pointer",
    "opacity": disabled ? "0.5" : "1",
    "&:hover": {
      "backgroundColor": Theme.Colors.primaryDark->colorToString,
    }
  })
}

@react.component
let make = (~children, ~onClick=?, ~loading=false, ~disabled=false) => {
  <button disabled ?onClick className=Styles.button(~disabled)>
    {switch loading {
    | false => children->s
    | true => <Base tag=#img width=[xs(2.4->#rem)] src=Assets.spinner />
    }}
  </button>
}