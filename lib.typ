// TODO: workaround until Typst gets a real ex unit.
// See <https://github.com/typst/typst/issues/2405>
#let ex = 0.47
#let defaults = (
  drop-tex: 0.5em*ex,
  drop-xe: 0.5em*ex,

  kern-te: -.1667em,
  kern-ex: -.125em,
  kern-la: -.36em,
  kern-at: -.15em,
  kern-xe: -.125em,
  kern-et: -.1667em,
  kern-el: -.125em,
  kern-x2: 0.15em,
)
#let config = state("metalogo", defaults)
#let metalogo(..opts) = context{
  config.update(c => {
    for (key, value) in opts.named() {
      c.insert(key, value)
    }
    return c
  })
}

#let drop(body, distance: 0pt) = box[#move(dy: distance)[#body]]
#let mirror(body) = scale(x: -100%)[#body]

#let TeX = context[#box[#{
  let cfg = config.get()
  [T]
  h(cfg.kern-te)
  drop(distance: cfg.drop-tex)[E]
  h(cfg.kern-ex)
  [X]
}]]

#let Xe = context[#box[#{
  let cfg = config.get()
  [X]
  h(cfg.kern-xe)
  drop(distance: cfg.drop-xe)[#mirror[E]]
}]]

#let LaTeX = context[#box[#{
  let cfg = config.get()

  [L]
  h(cfg.kern-la)
  drop(distance: -.2em)[#text(0.7em)[A]]
  h(cfg.kern-at)
  TeX
}]]

#let XeTeX = context[#box[#{
  let cfg = config.get()

  Xe
  h(cfg.kern-et)
  TeX
}]]

#let XeLaTeX = context[#box[#{
  let cfg = config.get()

  Xe
  h(cfg.kern-el)
  LaTeX
}]]

#let LuaLaTeX = box[Lua#LaTeX]
#let LuaTeX = box[Lua#TeX]

#let LaTeXe = context[#box[#{
  LaTeX
  [2]
  sym.epsilon
}]]

