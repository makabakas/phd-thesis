#!/bin/bash

RES=150  # dpi
MAXSIZE=800  # px

image_width() {
    convert "${1}.png" -format "%w" info:
}
image_height() {
    convert "${1}.png" -format "%h" info:
}
pdf2png() {
    pdftoppm -f 1 -l 1 -aa yes -aaVector yes -png -r $RES "${1}.pdf" > "${1}.png"
}
pdf2png_scale() {
    pdftoppm -f 1 -l 1 -aa yes -aaVector yes -png -r $RES -scale-to $MAXSIZE "${1}.pdf" > "${1}.png"
}
compress() {
    zopflipng -y "${1}.png" "${1}.png" >/dev/null
}

# main
FILE="${1%.pdf}"
pdf2png "$FILE"
if [ $(image_width "$FILE") -gt 800 ] || [ $(image_height "$FILE") -gt 800 ]; then
    pdf2png_scale "$FILE"
fi
compress "$FILE"
