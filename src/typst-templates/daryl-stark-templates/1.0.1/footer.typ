#let footer(subject, title) = context {
  let page-num = here().page()
  let is-even = calc.even(page-num)

  let left-content = if is-even { counter(page).display() } else { title }
  let right-content = if is-even { subject } else { counter(page).display() }

  set text(size: 9pt)
  grid(
    columns: (1fr, 1fr),
    align(left, left-content), align(right, right-content),
  )
}
