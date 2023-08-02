LATEX=pdflatex
LATEXOPT=--shell-escape

LATEXMK=latex-mk
LATEXMKOPT=--pdflatex

MAIN=main
BIB=references
HEADER=header
GLOSSARY=glossary

MAINDIR:=$(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
IMAGEDIR:=$(MAINDIR)/images
COMPILEDIR:=$(MAINDIR)/compile
PARTSDIR:=$(MAINDIR)/parts

all:
	mkdir -p $(COMPILEDIR)
	cp $(MAIN).tex $(COMPILEDIR)
	#cp $(BIB).bib $(COMPILEDIR)
	cp -r $(BIB) $(COMPILEDIR)
	cp $(HEADER).tex $(COMPILEDIR)
	cp $(GLOSSARY).tex $(COMPILEDIR)
	rsync -ahSD $(IMAGEDIR) $(COMPILEDIR)
	rsync -ahSD $(PARTSDIR) $(COMPILEDIR)
	cd $(COMPILEDIR) && \
	$(LATEXMK) $(LATEXMKOPT) $(MAIN).tex
	cp $(COMPILEDIR)/$(MAIN).pdf $(MAINDIR)
clean:
	rm -rf $(COMPILEDIR)
	rm -rf $(COMPILEDIR)_html
veryclean:
	rm -rf $(COMPILEDIR)
	rm -rf $(COMPILEDIR)_html
	rm $(MAIN).pdf

.PHONY: clean veryclean all
