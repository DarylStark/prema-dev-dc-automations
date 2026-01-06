#import "utils.typ": scaled

#let detail(
  body,
) = {
  block(
    inset: 0.8em,
    fill: rgb("000"),
    radius: 0pt,
    stroke: 0pt,
  )[
    #set text(fill: rgb("ffffff"), weight: "bold")
    #body
  ]
}

#let student_info(naam, nummer) = {
  set align(left)
  set text(size: 10pt)
  naam
  v(-6pt)
  line(length: 120pt, stroke: 0.5pt + luma(200))
  v(-6pt)
  text(fill: luma(120), size: 0.8em)[Studentnummer: #nummer]
}

#let front_page(
  subject: "",
  subject_code: "",
  author: "",
  author_id: "",
  title: "",
  subtitle: "",
  date: "",
  study: "",
  semester: 0,
  schoolyear: "",
) = {
  set page(
    margin: (x: 0cm, y: 0cm),
    background: image(
      "images/front-page.png",
      fit: "cover",
      width: 100%,
      height: 100%,
    ),
    flipped: false,
  )

  set par(
    justify: false,
  )

  context {
    let scaled_size(size) = scaled(size, page.width)

    place(
      top + left,
      dx: 0mm,
      dy: 0mm,
      float: true,
    )[
      #block(width: 100%, height: 100%)[

        // Document details
        #place(
          top + right,
          dx: -2.4%,
          dy: 2.4%,
        )[
          #text(scaled_size(10pt))[
            #stack(
              spacing: scaled_size(3pt),
              detail()[#study],
              detail()[Kwartiel #semester: #schoolyear],
              detail()[#subject_code],
            )]
        ]

        #place(
          top + left,
          dx: 0mm,
          dy: 38.7%,
          block(width: 100%, inset: (x: 9.5%, y: 0mm))[
            #text(scaled_size(22pt), weight: "bold")[#subject]
          ],
        )

        #place(
          top + left,
          dx: 0mm,
          dy: 52.2%,
          block(width: 100%, inset: (x: 9.5%, y: 0mm))[
            #text(scaled_size(18pt), weight: "bold")[#title]
          ],
        )

        #place(
          top + left,
          dx: 0mm,
          dy: 57.23%,
          block(width: 100%, inset: (x: 9.5%, y: 0mm))[
            #text(scaled_size(12pt), weight: "regular")[#subtitle]
          ],
        )

        #place(
          top + left,
          dx: 0mm,
          dy: 69%,
          block(width: 100%, inset: (x: 9.5%, y: 0mm))[
            #text(scaled_size(12pt), weight: "regular")[#date]
            #stack(
              dir: ltr,
              spacing: 8pt,
              [#author],
              if author_id != "" and author_id != none {
                move(dy: -2pt)[
                  #line(
                    angle: 90deg,
                    length: 1em,
                    stroke: 0.5pt + luma(150),
                  )
                ]
              },
              if author_id != "" and author_id != none {
                text(fill: luma(100), size: 0.9em)[#author_id]
              },
            )
          ],
        )
      ]
    ]
  }
}
