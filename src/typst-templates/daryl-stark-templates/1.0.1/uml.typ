#let uml_usecase(title: none, data: none, main_story: none, extensions: (:), label: none) = {
  // 1. Zorg dat de caption er weer is, maar zonder blok-ruimte eromheen
  show figure: set block(spacing: 0pt, above: 0pt, below: 10pt)
  show figure.caption: it => []

  show figure.caption: it => {
    set text(size: 9pt)
    // Styling: "Use Case X: Titel" (zoals we eerder hadden ingesteld)
    strong(it.supplement)
    [ ]
    strong(context it.counter.display())
    [: #it.body]
  }

  // 2. Ruimte boven de Use Case
  v(1.5em, weak: true)

  // 3. De Figure met de caption (maar zonder de tabel erin, voor de breekbaarheid)
  figure(
    none,
    caption: title,
    kind: table,
    supplement: [Use Case],
  )
  if label != none { label }

  // 4. De Tabel-constructie
  set align(left)
  block(width: 100%, breakable: true)[
    #stack(
      dir: ttb,
      spacing: 0pt,

      block(fill: rgb("#2d3436"), width: 100%, inset: 8pt, radius: (top: 4pt))[
        #text(fill: white, weight: "bold")[Use Case: #title]
      ],

      table(
        columns: (180pt, 1fr),
        inset: 8pt,
        stroke: 0.5pt + luma(200),
        fill: (x, y) => if calc.even(y) { luma(253) } else { white },
        ..data.pairs().map(((key, value)) => (strong(key), value)).flatten(),

        table.cell(colspan: 2)[
          #block(width: 100%)[
            *Hoofdsuccesscenario*: \ \
            #text(weight: "regular")[#main_story]
          ]
        ],

        table.cell(colspan: 2)[
          #block(width: 100%)[
            *Uitbreidingen*: \
            #if extensions.len() > 0 {
              grid(
                columns: (30pt, 1fr),
                row-gutter: 1em,
                column-gutter: 0pt,
                ..extensions
                  .pairs()
                  .map(((id, desc)) => (
                    [#id.],
                    text(weight: "regular")[#desc],
                  ))
                  .flatten()
              )
            } else [
              _Geen uitbreidingen bij deze Use Case._
            ]
          ]
        ],
      ),
    )
  ]

  v(1.5em, weak: true)
}
