#import "@preview/mantys:0.1.4": *
#import "@preview/tablex:0.0.9": tablex, hlinex

#import "lib.typ": *

#let manifest = toml("typst.toml")
#(manifest.package.description = [
  #show "LaTeX": LaTeX
  #manifest.package.description
])
#show: mantys.with(
  ..manifest,
  title: [The #manifest.package.name package],
  date: datetime.today(),
  abstract: [
    This package adds commands to typeset #LaTeX compiler logos and exposes
    their spacing parameters to the end user. Similar to the original #LaTeX
    `metalogo` package, it allows the compiler logos to be optimized for
    different typefaces.
  ],
)
#show table.cell.where(y: 0): strong
#let toprule = 1pt
#let midrule = 0.75pt
#let bottomrule = 1pt
#set table(
  align: center,
  stroke: (x, y) => (
    top:
      if y == 0 { toprule }
      else if y == 1 { midrule }
      else { 0pt },
    bottom: bottomrule,
  ),
  inset: (x, y) => (
    x: 5pt,
    y:
      if y == 0 { 0.6em }
      else { 0% + 6pt },
  ),
)

= Commands

== Logo commands <cmd-logo>

#variable("TeX")[#TeX]
#variable("LaTeX")[#LaTeX]
#variable("XeTeX")[#XeTeX]
#variable("XeLaTeX")[#XeLaTeX]
#variable("LuaLaTeX")[#LuaLaTeX]
#variable("LuaTeX")[#LuaTeX]
#variable("LaTeXe")[#LaTeXe]

== Configuration

#command("metalogo", sarg("options"))[
  #argument("options", types: ((:)), default: none)[
    Options passed to #cmd("metalogo") override the lengths used by the logo
    commands described in @cmd-logo globally.

    @metalogo-options lists the accepted options and their default values.
  ]
]

#context {
  let cfg = config.get()
  [
    #figure(caption: [Kern and drop parameters])[
      Kerns
      #table(
        columns: 4,
        table.header[Characters][Logo][Option][Default value],

        [T#h(cfg.kern-te)#drop(cfg.drop-tex)[E]],
        [#TeX],
        [#opt("kern-te")],
        [#value(cfg.kern-te)],

        [#drop(cfg.drop-tex)[E]#h(cfg.kern-ex)X],
        [#TeX],
        [#opt("kern-ex")],
        [#value(cfg.kern-ex)],

        [],
        [#LaTeX],
        [#opt("kern-la")],
        [#value(cfg.kern-la)],

        [],
        [#LaTeX],
        [#opt("kern-at")],
        [#value(cfg.kern-at)],

        [],
        [#XeTeX],
        [#opt("kern-xe")],
        [#value(cfg.kern-xe)],

        [],
        [#XeTeX],
        [#opt("kern-et")],
        [#value(cfg.kern-et)],

        [],
        [#XeLaTeX],
        [#opt("kern-el")],
        [#value(cfg.kern-el)],

        [],
        [#LaTeXe],
        [#opt("kern-x2")],
        [#value(cfg.kern-x2)],
      )

      Drops
      #table(
        columns: 4,
        table.header[Character][Logo][Option][Default value],

        [#drop(cfg.drop-tex)[E]],
        [#TeX],
        [#opt("drop-tex")],
        [#value(cfg.drop-tex)],

        [#drop(cfg.drop-xe)[#mirror[E]]],
        [#XeTeX],
        [#opt("drop-xe")],
        [#value(cfg.drop-xe)],
      )
    ] <metalogo-options>
  ]
}
