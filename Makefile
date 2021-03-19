LATEX=pdflatex
LATEXOPT=--shell-escape

LATEXMK=latexmk
LATEXMKOPT=-pdf

MAIN=full_article
BIB=converted_to_latex
HEADER=header
MAINDIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

all:
	mkdir -p compile
	cp *.cls compile
	cp $(MAIN).tex compile
	cp $(HEADER).tex compile
	if [ -d "compile/images" ]; then cp images/* compile/images; fi
	if [ ! -d "compile/images" ]; then cp -r images compile; fi
	if [ -d "compile/bibliography" ]; then cp images/* compile/images; fi
	if [ ! -d "compile/bibliography" ]; then cp -r images compile; fi
	cd compile && \
	$(LATEXMK) $(LATEXMKOPT) $(MAIN).tex
	cp $(MAINDIR)/compile/$(MAIN).pdf $(MAINDIR)
clean:
	rm -rf compile
veryclean:
	rm -rf compile
	rm $(MAIN).pdf
edit:
	$(VISUAL) -p $(MAIN).tex parts/*

.PHONY: clean veryclean all
