open Render
open Ancestor.Default

@react.component
let make = (~name, ~createdAt, ~completed, ~onToggle) => {
  <Box
    mb=[xs(2)]
    px=[xs(2)]
    py=[xs(3)]
    bgColor=[xs(Theme.Colors.grayDark)]
    borderRadius=[xs(1)]
    display=[xs(#flex)]
    alignItems=[xs(#center)]
    justifyContent=[xs(#"space-between")]>
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
}
