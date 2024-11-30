// TODO: base should *actually* be lowered by 0.5ex, but Typst does not yet
// have an ex unit, only em. See https://github.com/typst/typst/issues/2405
#let (TeX, LaTeX, XeTeX, XeLaTeX, LuaTeX, LuaLaTeX) = {
  // Vertical change for specific letters
  // TODO: change to ex units when supported
  let drop = (
    e: 0.22em, // Baseline drop for 'E' in TeX and XeTeX
    a: -0.2em, // Baseline drop for 'A' in LaTeX
  )

// Kerning for specific letter-pairs
  let kern = (
    t-e: -0.1667em, // Kerning between 'T' and 'E' in TeX
    e-x: -0.125em,  // Kerning between 'E' and 'X' in TeX

    l-a: -0.33em,   // Kerning between 'L' and 'A' in LaTeX
    a-t: -0.15em,   // Kerning between 'A' and 'T' in LaTeX

    x-e: -0.1667em, // Kerning between 'X' and 'E' in XeTeX
    e-t: -0.125em,  // Kerning between 'E' and 'T' in XeTeX
  )

  // Sizes for specific letters
  let size = (
    a: 0.7em, // Size of 'A' in LaTeX
  )

  // Helper functions
  let lower(y, body) = box(baseline: y)[#body]  // Note the negative sign
  let rev(body)      = scale(x: -100%)[#body]
  let ncm(body)      = text(font: "New Computer Modern")[#body]

  // Build components
  let TeX      = [T#h(kern.t-e)#lower(drop.e)[E]#h(kern.e-x)X]
  let A        = lower(drop.a)[#text(size: size.a)[A]]
  let LaTeX    = [L#h(kern.l-a)#A#h(kern.a-t)#TeX]
  let Xe       = [X#h(kern.x-e)#lower(drop.e)[#rev[E]]#h(kern.e-t)]
  let XeTeX    = [#Xe#TeX]
  let XeLaTeX  = [#Xe#LaTeX]
  let LuaTeX   = [Lua#TeX]
  let LuaLaTeX = [Lua#LaTeX]

  // Return tuple of exported function
  //
  // Forces each to New Computer Modern and shifts down by `drop.e` since the E
  // in TeX is meant to be below the baseline. Note that `lower` wraps content
  // with `box` so it's unbreakable.
  (
    ncm(lower(drop.e, TeX)),
    ncm(lower(drop.e, LaTeX)),
    ncm(lower(drop.e, XeTeX)),
    ncm(lower(drop.e, XeLaTeX)),
    ncm(lower(drop.e, LuaTeX)),
    ncm(lower(drop.e, LuaLaTeX)),
  )
}
