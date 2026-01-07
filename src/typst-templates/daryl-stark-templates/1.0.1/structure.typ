#let empty_page_till_odd = {
  set page(header: [], footer: [])
  pagebreak(to: "odd", weak: true)
}

#let unnumbered_section(body) = {
  set heading(numbering: none, supplement: body)
  body
}

#let numbered_section(body) = {
  set heading(numbering: "1.1", supplement: "Hoofdstuk")
  body
}

#let appendixes(body) = {
  set heading(numbering: "A.1", supplement: [Bijlage])
  counter(heading).update(0)
  body
}

#let collect_sources(bib_file) = {
  pagebreak(weak: true)
  set bibliography(style: "apa", title: "Bronvermelding")
  bibliography(bib_file)
}
