### Build an image first 

```bash
docker build -t ghostscript-image .
```

### Run the compression

make sure the file you want to compress is in the project root directory 

```bash
./compress-pdf.sh form.pdf
```

#### Alternatively

if you want to customize ghostscript command rather than the predefined one inside the container `/bin/pdfcompress`

```bash
docker run --rm -v "$(pwd)":/data ghostscript-image \
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
-dNOPAUSE -dQUIET -dBATCH -sOutputFile=/data/output.pdf /data/input.pdf
```
> `input.pdf` should be in the project root directory