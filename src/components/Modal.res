open Render
open Ancestor.Default

module Styles = {
  open Emotion

  let {toString: colorToString} = module(Theme.Colors)

  let overlay = css({
    "background": "#00000050",
    "position": "fixed",
    "top": "0",
    "bottom": "0",
    "right": "0",
    "left": "0",
    "display": "flex",
    "alignItems": "center",
    "justifyContent": "center",
    "zIndex": "2",
    "backdropFilter": "blur(1px)",
  })

  let dialog = css({
    "position": "relative",
    "maxWidth": "23vw",
    "background": Theme.Colors.grayDark->colorToString,
    "borderRadius": "0.6rem",
    "padding": "2.8rem",
  })

  let closeButton = css({
    "position": "absolute",
    "borderRadius": "0.4rem",
    "border": "0",
    "paddingTop": "0.5rem",
    "top": "1rem",
    "right": "1rem",
    "transition": "300ms",
    "background": "transparent",
    "&:hover": {
      "background": Theme.Colors.gray->colorToString,
    },
  })
}

@react.component
let make = (~onClose, ~children, ~title) => {
  <div className=Styles.overlay>
    <Box className=Styles.dialog>
      <Box display=[xs(#flex)] alignItems=[xs(#center)] justifyContent=[xs(#center)]>
        <Typography
          color=[xs(Theme.Colors.white)]
          fontSize=[xs(2.4->#rem)]
          fontWeight=[xs(#bold)]
          textAlign=[xs(#center)]>
          {title->s}
        </Typography>
        <button className=Styles.closeButton onClick={_ => onClose()}>
          <Base tag=#img src=Assets.xIcon alt="X Icon" width=[xs(20->#px)] />
        </button>
      </Box>
      <Box display=[xs(#flex)] flexDirection=[xs(#column)] mt=[xs(2)]> {children} </Box>
    </Box>
  </div>
}
