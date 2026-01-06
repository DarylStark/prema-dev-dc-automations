#let header = context {
  let headings-on-page = query(selector(heading.where(level: 1)).after(here())).filter(h => (
    h.location().page() == here().page()
  ))

  let headings-before = query(selector(heading.where(level: 1)).before(here()))

  let chapter-title = if headings-on-page.len() > 0 {
    headings-on-page.first().body
  } else if headings-before.len() > 0 {
    headings-before.last().body
  } else {
    ""
  }

  let page-num = counter(page).get().first()
  let align_title = if calc.even(page-num) { left } else { right }

  align(align_title, text(size: 9pt, style: "italic", fill: gray)[#chapter-title])
}
