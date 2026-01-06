#import "front-page.typ": front_page
#import "utils.typ": scaled
#import "structure.typ": empty_page_till_odd
#import "header.typ": header
#import "footer.typ": footer

#let assignment(
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
  paper: "a4",
  show_toc: true,
  show_toc_glance: false,
  show_image_list: false,
  show_table_list: false,
  chapters_on_odd_pages: true,
  body,
) = {
  // Default font
  set page(
    paper: paper,
    fill: white,
    background: none,
    margin: (x: 10.5%, y: 9.7%),
    flipped: false,
    header: header,
    footer: footer(subject, title),
  )
  set text(
    font: "Source Sans 3",
    size: 12pt,
    fill: rgb("000000"),
    lang: "nl",
    hyphenate: true,
  )
  set par(
    justify: true,
    leading: 0.85em,
    spacing: 2em,
    first-line-indent: 0pt,
  )

  // Header style
  set heading(numbering: "1.1")
  show heading: it => {
    let number = if it.numbering != none {
      counter(heading).display(it.numbering)
    }
    block(below: 2em, above: 3em, width: 100%)[
      #set par(justify: false)
      #grid(
        columns: (0mm, 1fr),
        column-gutter: 0mm,
        align(right)[
          #text(weight: "regular", fill: gray)[
            #number #h(10pt)
          ]
        ],

        it.body,
      )
    ]
  }
  show heading.where(level: 1): it => {
    if chapters_on_odd_pages {
      empty_page_till_odd
    } else {
      pagebreak()
    }
    it
  }

  // Style for lists
  set list(indent: 0em, body-indent: 1em)
  set enum(indent: 0em, body-indent: 1em)
  show list: set block(spacing: 1.5em)
  show enum: set block(spacing: 1.5em)

  // Style for code blocks
  show raw.where(block: false): it => {
    box(
      fill: luma(245),
      inset: (x: 3pt),
      outset: (y: 3pt),
      radius: 0pt,
    )[#it]
  }
  show raw.where(block: true): it => {
    set par(justify: false)

    block(
      fill: luma(250),
      stroke: 0.5pt + luma(200),
      inset: 12pt,
      radius: 0pt,
      width: 100%,
      table(
        columns: (auto, 1fr),
        inset: 0pt,
        stroke: none,
        column-gutter: 2em,
        row-gutter: 0.9em,
        ..it
          .lines
          .enumerate()
          .map(((i, line)) => (
            align(right, text(fill: luma(150), size: 8pt)[#(i + 1)]),
            line,
          ))
          .flatten()
      ),
    )
  }

  // Style for image captions
  show figure.caption: it => {
    set text(size: 9pt)

    strong(it.supplement)
    [ ]
    strong(context it.counter.display())
    [: ]

    it.body
  }

  // Style for references
  show ref: it => {
    let el = it.element
    if el == none { return it }

    let ref_style(body) = text(weight: "bold")[#body]

    if el.func() == heading {
      if el.numbering != none {
        let supplement = if el.level == 1 { "Hoofdstuk" } else { "Paragraaf" }
        let nr = numbering(el.numbering, ..counter(heading).at(el.location()))
        link(el.location(), ref_style[#supplement #nr])
      } else {
        link(el.location(), ref_style(el.body))
      }
    } else if el.func() == figure {
      link(el.location(), ref_style(it))
    } else {
      it
    }
  }

  // Front page
  front_page(
    subject: subject,
    subject_code: subject_code,
    author: author,
    author_id: author_id,
    title: title,
    subtitle: subtitle,
    date: date,
    study: study,
    semester: semester,
    schoolyear: schoolyear,
  )

  // First, we start with Roman page numbering
  set page(numbering: "I")
  counter(page).update(1)

  // Content at a glance
  if show_toc_glance {
    outline(
      title: [Inhoud in hoofdlijnen],
      indent: 1.0em,
      depth: 1,
    )
  }

  // Contents
  if show_toc {
    outline(
      title: [Inhoudsopgave],
      indent: 1.0em,
      depth: 3,
    )
  }

  // Lijst met Afbeeldingen (voor je Draw.io diagrammen)
  if show_image_list {
    outline(
      title: [Lijst met Afbeeldingen],
      target: figure.where(kind: image),
    )
  }

  // Lijst met Tabellen (voor je Use Cases)
  if show_table_list {
    outline(
      title: [Lijst met Tabellen],
      target: figure.where(kind: table),
    )
  }

  if chapters_on_odd_pages {
    empty_page_till_odd
  }

  // We continue with default numbering
  set page(
    numbering: "1",
  )
  counter(page).update(1)

  // Show the document of the user
  body
}
