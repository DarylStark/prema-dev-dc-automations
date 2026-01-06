#let question(body) = {
  block(
    width: 100%,
    fill: rgb("#f8f9fa"),
    stroke: (left: 3pt + rgb("#2d3436")),
    inset: (x: 12pt, y: 8pt),
    radius: (right: 4pt),
    [
      #set text(size: 0.95em, weight: "medium")
      #stack(
        dir: ttb,
        spacing: 10pt,
        text(
          size: 0.75em,
          weight: "bold",
          fill: rgb("#2d3436"),
          tracking: 0.5pt,
          "OPDRACHT",
        ),
        text(style: "italic", fill: luma(50), body),
      )
    ],
  )
  v(1.5em, weak: true)
}
