open Render
open Ancestor.Default

module Styles = {
  open Emotion

  let {toString: colorToString} = module(Theme.Colors)

  let container = css({
    "&:hover": {
      "section": {
        "opacity": "0.8",
        "transform": "translateX(-6.8rem)",
      },
    },
  })

  let taskItem = css({
    "flex": "1",
    "transition": "300ms",
    "zIndex": "1",
  })

  let button = css({
    "position": "absolute",
    "background": Theme.Colors.primary->colorToString,
    "border": "0",
    "zIndex": "0",
    "right": "0",
    "padding": "0.8rem",
    "borderRadius": "0.4rem",
    "marginBottom": "1.5rem",
    "transition": "300ms",
    "&:hover": {
      "opacity": "0.8",
    },
  })
}

@react.component
let make = (~id, ~name, ~createdAt, ~completed, ~onToggle) => {
  let (isOpen, setIsOpen) = React.useState(_ => false)

  let toggleConfirm = _ => {
    setIsOpen(prevState => !prevState)
  }

  <>
    <Box
      tag=#li
      position=[xs(#relative)]
      display=[xs(#flex)]
      alignItems=[xs(#center)]
      width=[xs(100.0->#pct)]
      className=Styles.container>
      <Box
        tag=#section
        mb=[xs(2)]
        px=[xs(2)]
        py=[xs(3)]
        bgColor=[xs(Theme.Colors.grayDark)]
        borderRadius=[xs(1)]
        display=[xs(#flex)]
        alignItems=[xs(#center)]
        justifyContent=[xs(#"space-between")]
        className=Styles.taskItem>
        <Box>
          <Typography
            tag=#p
            m=[xs(0)]
            mb=[xs(1)]
            fontSize=[xs(1.8->#rem)]
            color=[xs(Theme.Colors.white)]
            letterSpacing=[xs(-0.035->#em)]>
            {name->s}
          </Typography>
          <Typography
            tag=#p
            m=[xs(0)]
            fontSize=[xs(1.4->#rem)]
            color=[xs(Theme.Colors.grayLight)]
            letterSpacing=[xs(-0.035->#em)]>
            {createdAt->s}
          </Typography>
        </Box>
        <Checkbox checked=completed onChange={_ => onToggle()} />
      </Box>
      <button className=Styles.button onClick=toggleConfirm>
        <Base
          tag=#img src=Assets.trashIcon alt="Trash Icon" width=[xs(32->#px)] height=[xs(26->#px)]
        />
      </button>
    </Box>
    {switch isOpen {
    | true => <DeleteTask taskId=id onClose=toggleConfirm />
    | false => React.null
    }}
  </>
}
