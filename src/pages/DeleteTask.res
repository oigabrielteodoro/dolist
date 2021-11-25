open Render
open ReactToastify
open Ancestor.Default

module Styles = {
  open Emotion 

  let { toString: colorToString } = module(Theme.Colors)

  let buttonConfirm = css({
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

  let buttonCancel = css({
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
let make = (~taskId, ~onClose) => {
  let { deleteTask } = TaskContext.useTasks()

  let handleDeleteTask = _ => {
    deleteTask(taskId)
    onClose()

    toast->success("Tarefa excluida com sucesso", ReactToastify.options(
        ~autoClose=3000,
        ~hideProgressBar=false,
        ~closeOnClick=false,
        (),
      ))
  }

  <Modal title="Excluir tarefa" onClose>
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
    <button className=Styles.buttonConfirm onClick={_ => handleDeleteTask()}> {"Excluir!"->s} </button>
    <button className=Styles.buttonCancel onClick={_ => onClose()}>
      {"Cancelar"->s}
    </button>
  </Modal>
}