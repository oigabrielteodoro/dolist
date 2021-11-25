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

  let confirmButton = css({
    "color": Theme.Colors.white->colorToString,
    "background": Theme.Colors.primary->colorToString,
    "borderRadius": "0.4rem",
    "padding": "1.6rem",
    "width": "100%",
    "border": "0",
    "fontSize": "1.6rem",
    "fontWeight": "500",
    "marginTop": "2.0rem",
    "transition": "300ms",
    "&:hover": {
      "opacity": "0.8",
    },
  })

  let cancelButton = css({
    "background": "transparent",
    "border": "0",
    "fontWeight": "bold",
    "color": Theme.Colors.grayLight->colorToString,
    "margin": "1.6rem auto 0",
    "transition": "300ms",
    "&:hover": {
      "opacity": "0.8",
    },
  })
}

@react.component
let make = (~name, ~createdAt, ~completed, ~onToggle) => {
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
    | true =>
      <Modal title="Excluir tarefa" onClose={toggleConfirm}>
        <Box
          display=[xs(#flex)]
          alignItems=[xs(#center)]
          justifyContent=[xs(#center)]
          flexDirection=[xs(#column)]
          textAlign=[xs(#center)]>
          <Typography
            color=[xs(Theme.Colors.grayLight)] fontSize=[xs(1.6->#rem)] fontWeight=[xs(#500)]>
            {"Deseja excluir esta tarefa?"->s}
          </Typography>
          <Typography color=[xs(Theme.Colors.grayLight)] fontSize=[xs(1.4->#rem)] mt=[xs(1)]>
            {"Caso voce exclua a tarefa, nao sera possivel restaura-la!"->s}
          </Typography>
        </Box>
        <button className=Styles.confirmButton> {"Excluir!"->s} </button>
        <button className=Styles.cancelButton onClick={_ => toggleConfirm()}>
          {"Cancelar"->s}
        </button>
      </Modal>
    | false => React.null
    }}
  </>
}
