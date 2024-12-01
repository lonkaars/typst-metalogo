all: demo.svg manual.pdf

%.pdf: %.typ
	typst compile $<

%.svg: %.pdf
	pdf2svg $< $@
	rsvg-convert --zoom 3 --background-color white --format svg --output $@ $@

