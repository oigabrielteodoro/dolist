module Colors = {
  let primary = #hex("#743af0")
  let primaryDark = #hex("#5820cf")
  let primaryLight = #hex("#6f5a9a")

  let gray = #hex("#3a3939")
  let grayDark = #hex("#242424")
  let grayLight = #hex("#a7a7a7")

  let red = #hex("#ff1b51")
  let black = #hex("#070707")
  let white = #hex("#ffffff")

  let toString = color => switch color {
  | #hex(color) => color
  }
}

module Constants = {
  let fontFamily = "'DM Sans', sans-serif"
}