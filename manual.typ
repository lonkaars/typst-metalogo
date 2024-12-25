#import "@preview/mantys:0.1.4": *
#import "@preview/tablex:0.0.9": tablex, hlinex

#import "lib.typ": *

#show: metalogo.with(
  drop-tex: 0.14em,
  drop-xe: 0.14em,
  kern-xe: -.09em,
  kern-el: -.09em,
  kern-et: -.08em,
  kern-la: -.35em,
  kern-at: -.10em,
  kern-te: -.08em,
  kern-ex: -.10em,
)

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
  examples-scope: (
    LaTeX: LaTeX,
    metalogo: metalogo,
  ),
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

== Logos <cmd-logo>

#columns(4)[
  #variable("LaTeX")[#LaTeX]
  #variable("LaTeXe")[#LaTeXe]
  #colbreak()
  #variable("XeTeX")[#XeTeX]
  #variable("XeLaTeX")[#XeLaTeX]
  #colbreak()
  #variable("LuaTeX")[#LuaTeX]
  #variable("LuaLaTeX")[#LuaLaTeX]
  #colbreak()
  #variable("TeX")[#TeX]
]

== Configuration

#command("metalogo", sarg[options], barg[body])[
  Change kern and drop parameters for the content inside #arg[body].

  #argument("options", types: ((:)), default: none)[
    Options passed to #cmd[metalogo] override the lengths used by the logo
    commands (@cmd-logo). If no options are passed, all options are reset to
    their default values.

    @metalogo-options lists the accepted options and their default values.
  ]
]

#context [
#let cfg = config.get()
#let kerns = table(
  columns: 4,
  table.header[Pair][Logo][Option][Default value],

  [T#kern(cfg.kern-te)#drop(cfg.drop-tex)[E]],
  [#TeX],
  [#opt[kern-te]],
  [#default(defaults.kern-te)],

  [#drop(cfg.drop-tex)[E]#kern(cfg.kern-ex)X],
  [#TeX],
  [#opt[kern-ex]],
  [#default(defaults.kern-ex)],

  [L#kern(cfg.kern-la)#a],
  [#LaTeX],
  [#opt[kern-la]],
  [#default(defaults.kern-la)],

  [#a#kern(cfg.kern-at)T],
  [#LaTeX],
  [#opt[kern-at]],
  [#default(defaults.kern-at)],

  [#Xe],
  [#XeTeX],
  [#opt[kern-xe]],
  [#default(defaults.kern-xe)],

  [#drop(cfg.drop-xe)[#mirror[E]]#kern(cfg.kern-et)T],
  [#XeTeX],
  [#opt[kern-et]],
  [#default(defaults.kern-et)],

  [#drop(cfg.drop-xe)[#mirror[E]]#kern(cfg.kern-el)L],
  [#XeLaTeX],
  [#opt[kern-el]],
  [#default(defaults.kern-el)],

  [X#kern(cfg.kern-x2)2],
  [#LaTeXe],
  [#opt[kern-x2]],
  [#default(defaults.kern-x2)],
)
#let drops = table(
  columns: 4,
  table.header[Glyph][Logo][Option][Default value],

  [#drop(cfg.drop-tex)[E]],
  [#TeX],
  [#opt[drop-tex]],
  [#default(defaults.drop-tex)],

  [#drop(cfg.drop-xe)[#mirror[E]]],
  [#Xe],
  [#opt[drop-xe]],
  [#default(defaults.drop-xe)],

  [#a],
  [#LaTeX],
  [#opt[drop-a]],
  [#default(defaults.drop-a)],
)

#pad(y: 5mm)[
  #figure(caption: [Kern and drop parameters#footnote[The default parameters
  are taken from the original #LaTeX metalogo package, which expects the
  default #LaTeX font to be used (Latin Modern). The values shown in
  @metalogo-options are not the values used in this document.]])[
    #columns(2)[
      #kerns
      #colbreak()
      #drops
    ]
  ] <metalogo-options>
]

]

= Examples

== Scoped configuration

#example[```
#LaTeX

#metalogo(kern-la: .3em)[
  #LaTeX
]

#LaTeX
```]

== Global configuration

#example[```
#LaTeX

#show: metalogo.with(kern-la: .3em)

#LaTeX

#LaTeX
```]
