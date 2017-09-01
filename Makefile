FILE = wierstorf2014-perceptual_assessment_of_sound_field_synthesis
FIGURES := $(basename $(shell find */fig*/*.pdf -type f))

make:
	 	# Run LaTeX the save way
		@pdflatex $(FILE)
		@biber $(FILE)
		@pdflatex $(FILE)
		# Reduce size of pdf
		@gs -sDEVICE=pdfwrite \
		    -dCompatibilityLevel=1.4 \
			-dNOPAUSE \
			-dQUIET \
			-dBATCH \
			-sOutputFile=$(FILE)_tmp.pdf \
			$(FILE).pdf
		# Adjust metadata
		@pdftk $(FILE)_tmp.pdf \
               update_info metadata.txt \
               output $(FILE).pdf
		@ rm $(FILE)_tmp.pdf

one:
		# Run LaTeX just once
		@pdflatex $(FILE)

png: $(FIGURES)

$(figures): %:
		@./thumbnail.sh "$*.pdf"

clean:
		@rm *aux *out *log *blg *bcf *bbl *xml *toc
