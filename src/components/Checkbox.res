module Styles = {
  open Emotion

  let {toString: colorToString} = module(Theme.Colors)

  let fillAnimation = keyframes({
    "0%": {
      "transform": "scale(0)",
    },
    "50%": {
      "transform": "scale(1.25)",
    },
    "100%": {
      "transform": "scale(1)",
    },
  })

  let checkboxWrapper = css({
    "cursor": "pointer",
    "> input": {
      "display": "none",
    },
    "> div": {
      "position": "relative",
      "width": "2.4rem",
      "height": "2.4rem",
      "border": `solid 0.2rem ${Theme.Colors.primary->colorToString}`,
      "borderRadius": "0.6rem",
      "> img": {
        "position": "absolute",
        "top": "0.5rem",
        "left": "0.3rem",
        "transform": "scale(0)",
      },
      "&:after": {
        "borderRadius": "0.3rem",
        "content": "' '",
        "position": "absolute",
        "width": "100%",
        "height": "100%",
        "top": 0,
        "left": 0,
        "background": Theme.Colors.primary->colorToString,
        "transform": "scale(0)",
      },
    },
    "> input:checked + div": {
      "> img": {
        "zIndex": 10,
        "animation": `${fillAnimation} 300ms forwards`,
        "animationDelay": "100ms",
      },
      "&:after": {
        "animation": `${fillAnimation} 300ms forwards`,
      },
    },
  })
}

@react.component
let make = (~checked=?, ~onChange=?) => {
  <label className=Styles.checkboxWrapper>
    <input ?checked ?onChange type_="checkbox" /> <div> <img src={Assets.checkIcon} /> </div>
  </label>
}
