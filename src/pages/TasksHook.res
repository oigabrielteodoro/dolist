module Array = Js.Array2

let {queryOptions, mutationOptions, useQuery, useMutation} = module(ReactQuery)

let apiUrl = "http://localhost:3001"
let apiCodec = Jzon.array(TaskTypes.codec)

type requestResult =
  | Data(array<TaskTypes.t>)
  | Loading
  | Error

type hookResult = {
  isCreating: bool,
  result: requestResult,
  taskName: string,
  toggleTaskStatus: TaskTypes.t => unit,
  handleChange: ReactEvent.Form.t => unit,
  handleCreateTask: ReactEvent.Mouse.t => unit,
}

let handleFetch = _ => {
  open Promise

  Fetch.fetch(`${apiUrl}/tasks`, {"method": "GET"})
  ->then(response => response->Fetch.json)
  ->thenResolve(json => Jzon.decodeWith(json, apiCodec))
}

let handleCreateTask = (taskName: string) => {
  let newTask = {
    "name": taskName,
    "completed": false,
    "createdAt": Js.Date.make(),
  }

  Fetch.fetch(
    `${apiUrl}/tasks`,
    {
      "method": "POST",
      "body": Js.Json.stringifyAny(newTask),
      "headers": {
        "Content-Type": "application/json",
      },
    },
  )
}

let handleUpdateTask = task => {
  open Promise

  let json = task->Jzon.encodeStringWith(TaskTypes.codec)

  Fetch.fetch(
    `${apiUrl}/tasks/${task.id->Js.Int.toString}`,
    {
      "method": "PUT",
      "body": json,
      "headers": {
        "Content-Type": "application/json",
      },
    },
  )->thenResolve(response => Js.log(response))
}

let useTasks = () => {
  let (taskName, setTaskName) = React.useState(_ => "")

  let result = useQuery(
    queryOptions(
      ~queryKey="tasks",
      ~queryFn=handleFetch,
      ~refetchOnWindowFocus=ReactQuery.refetchOnWindowFocus(#bool(false)),
      (),
    ),
  )

  let refetchTasks = () => {
    result.refetch({
      throwOnError: false,
      cancelRefetch: false,
    })
  }

  let handleSuccess = (_, _, _) => {
    setTaskName(_ => "")
    refetchTasks()
  }

  let {mutate: createTaskMutation, isLoading: isCreating} = useMutation(
    mutationOptions(
      ~onSuccess=handleSuccess,
      ~mutationFn=handleCreateTask,
      ~mutationKey="new-task",
      (),
    ),
  )

  let {mutate: updateTaskMutation} = useMutation(
    mutationOptions(
      ~onSuccess=(_, _, _) => refetchTasks(),
      ~mutationFn=handleUpdateTask,
      ~mutationKey="update-task",
      (),
    ),
  )

  let handleChange = event => {
    let target = ReactEvent.Form.target(event)

    setTaskName(_ => target["value"])
  }

  let handleCreateTask = _ => {
    createTaskMutation(. taskName, None)
  }

  let toggleTaskStatus = task => {
    open TaskTypes

    let updatedTask = {
      ...task,
      completed: !task.completed,
    }

    updateTaskMutation(. updatedTask, None)
  }

  {
    isCreating: isCreating,
    taskName: taskName,
    handleChange: handleChange,
    handleCreateTask: handleCreateTask,
    toggleTaskStatus: toggleTaskStatus,
    result: switch result {
    | {isLoading: true} => Loading
    | {isError: true}
    | {data: Some(Error(_))} =>
      Error
    | {data: Some(Ok(tasks)), isLoading: false, isError: false} =>
      Data(
        tasks->Js.Array2.sortInPlaceWith((a, b) =>
          DateFns.compareDesc(a.createdAt->Js.Date.fromString, b.createdAt->Js.Date.fromString)
        ),
      )
    | _ => Error
    },
  }
}
