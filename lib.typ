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
      assert(
        c.at(key, default: none) != none,
        message: "metalogo: Unknown option \"" + key + "\""
      )
      let expected_type = type(c.at(key))
      let actual_type = type(value)
      assert(
        expected_type == actual_type,
        message: "metalogo: Option \"" + key + "\" has type `" +
        str(expected_type) + "` but was assigned a `" + str(actual_type) + "`"
      )
      c.insert(key, value)
    }
    return c
  })
}

#let drop(distance, body) = box(move(dy: distance, body))
#let mirror(body) = scale(x: -100%)[#body]

#let TeX = context[#box[#{
  let cfg = config.get()
  [T]
  h(cfg.kern-te)
  drop(cfg.drop-tex)[E]
  h(cfg.kern-ex)
  [X]
}]]

#let Xe = context[#box[#{
  let cfg = config.get()
  [X]
  h(cfg.kern-xe)
  drop(cfg.drop-xe)[#mirror[E]]
}]]

#let LaTeX = context[#box[#{
  let cfg = config.get()

  [L]
  h(cfg.kern-la)
  // TODO: factor out `A` component and add spacing parameters to config
  // TODO: `A` is too far to the left compared to real LaTeX
  drop(-.2em)[#text(0.7em)[A]]
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
  let cfg = config.get()

  LaTeX
  h(cfg.kern-x2)
  [2]
  [$attach(, b: #sym.epsilon)$]
}]]

