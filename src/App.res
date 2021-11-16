let container = Emotion.css({
  "border": "1px solid red"
})

@react.component
let make = () => {
  <div className={container}>
    <h1> {`Hello from ReScript and Vite 😄`->React.string} </h1>
  </div>
}
