open Render
open Ancestor.Default

let {useTasks} = module(TasksHook)

let formatDate = value => value->Js.Date.fromString->DateFns.format("dd/MM/yy hh:mm")

module ErrorMessage = {
  @react.component
  let make = () => {
    <Box
      minH=[xs(40.0->#rem)]
      display=[xs(#flex)]
      flexDirection=[xs(#column)]
      alignItems=[xs(#center)]
      justifyContent=[xs(#center)]>
      <Typography
        tag=#h1
        m=[xs(0)]
        mb=[xs(1)]
        fontSize=[xs(2.4->#rem)]
        fontWeight=[xs(#bold)]
        letterSpacing=[xs(-0.055->#em)]
        color=[xs(Theme.Colors.white)]>
        {"Ocorreu algo inesperado"->s}
      </Typography>
      <Typography
        tag=#p
        m=[xs(0)]
        fontSize=[xs(1.8->#rem)]
        letterSpacing=[xs(-0.03->#em)]
        textAlign=[xs(#center)]
        color=[xs(Theme.Colors.grayLight)]>
        {"Ocorreu um erro por favor tente novamente."->s}
      </Typography>
    </Box>
  }
}

module EmptyState = {
  @react.component
  let make = () => {
    <Box
      minH=[xs(40.0->#rem)]
      display=[xs(#flex)]
      flexDirection=[xs(#column)]
      alignItems=[xs(#center)]
      justifyContent=[xs(#center)]>
      <Base tag=#img mb=[xs(3)] src=Assets.emptyState alt="Empty state" width=[xs(200->#px)] />
      <Typography
        tag=#h1
        m=[xs(0)]
        mb=[xs(1)]
        fontSize=[xs(2.4->#rem)]
        fontWeight=[xs(#bold)]
        letterSpacing=[xs(-0.055->#em)]
        color=[xs(Theme.Colors.white)]>
        {"Nao ha tarefas pendentes"->s}
      </Typography>
      <Typography
        tag=#p
        m=[xs(0)]
        fontSize=[xs(1.8->#rem)]
        letterSpacing=[xs(-0.03->#em)]
        textAlign=[xs(#center)]
        color=[xs(Theme.Colors.grayLight)]>
        {"Adicione sua primeira tarefa utilizando o campo acima"->s}
      </Typography>
    </Box>
  }
}

module Spinner = {
  @react.component
  let make = () => {
    <Box
      minH=[xs(40.0->#rem)]
      width=[xs(100.0->#pct)]
      display=[xs(#flex)]
      justifyContent=[xs(#center)]
      alignItems=[xs(#center)]>
      <Base tag=#img src=Assets.spinner width=[xs(5.6->#rem)] />
    </Box>
  }
}

module NewTaskInput = {
  @react.component
  let make = (~taskName, ~isLoading, ~onChange, ~onSubmit) => {
    <Box>
      <Typography
        tag=#label
        m=[xs(0)]
        fontWeight=[xs(#bold)]
        fontSize=[xs(2.4->#rem)]
        lineHeight=[xs(3.1->#rem)]
        color={[xs(Theme.Colors.white)]}>
        {"Nova tarefa"->s}
      </Typography>
      <Box mt=[xs(2)] position=[xs(#relative)]>
        <Input value=taskName onChange placeholder="Compras da semana" />
        <Box position=[xs(#absolute)] right=[xs(9->#px)] top=[xs(9->#px)]>
          <Button loading=isLoading disabled={taskName === "" || isLoading} onClick=onSubmit>
            "Adicionar"
          </Button>
        </Box>
      </Box>
    </Box>
  }
}

@react.component
let make = () => {
  let {result, isCreating, taskName, toggleTaskStatus, handleChange, handleCreateTask} = useTasks()

  <Box
    display=[xs(#flex)]
    flexDirection=[xs(#column)]
    justifyContent=[xs(#center)]
    alignItems=[xs(#center)]>
    <Box display=[xs(#flex)] justifyContent=[xs(#center)] tag=#header>
      <img src={Assets.logo} alt="Dolist" />
    </Box>
    <Box mt=[xs(10)] width=[xs(100.0->#pct)] maxW=[xs(63.4->#rem)]>
      <NewTaskInput isLoading=isCreating taskName onChange=handleChange onSubmit=handleCreateTask />
      {switch result {
      | Loading => <Spinner />
      | Error => <ErrorMessage />
      | Data([]) => <EmptyState />
      | Data(tasks) =>
        <Box mt=[xs(4)]>
          {tasks->map((task, key) => {
            let {id, name, completed, createdAt} = task

            <TaskItem
              key
              id
              name
              completed
              createdAt={createdAt->formatDate}
              onToggle={_ => toggleTaskStatus(task)}
            />
          })}
        </Box>
      }}
    </Box>
  </Box>
}
