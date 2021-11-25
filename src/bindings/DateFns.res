@module("date-fns") external format: (Js.Date.t, string) => string = "format"
@module("date-fns") external compareDesc: (Js.Date.t, Js.Date.t) => int = "compareDesc"