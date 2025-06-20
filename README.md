# PDF-Utility

PDF-Util is a docker container based CLI tool which provides pdf utilities such as:

1. PDF file compression
2. PDF file resize
3. pdf file merging

This tool uses Ghostscript and Poppler to perform operations on pdf files.

## Motivation

Usually when one wants to use pdf related tasks for example compression or merging, there are online tools available. However one might not feel comfortable sharing pdf containing important information to the 3rd party softwares or servers via internet.

Hence the PDF-Util is a docker based CLI tool that runs locally leaving out any concerns about data privacy/leaks. 

## Instructions to run locally

Docker is required for this project to run.

### Build an image first 

```bash
docker build -t pdf-util .
```

**Note:** If you name the image something other than *pdf-util* then make sure to change the `IMAGE_NAME` in *pdfutil.sh* file also.

### Unix CLI

make sure the file you want to perform actions on, is in the project root directory 

*Note:* `pdfutil.sh` should have executable rights. If not then run:

```
chmod 755 pdfutil.sh
```

After that, run the bash script


```bash
./pdfutil.sh
```

#### Alternatively

if you want to run ghostscript command directly from cli rather than the predefined one inside the container `/bin/pdfcompress`

```bash
docker run --rm -v "$(pwd)":/data pdf-util \
gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook \
-dNOPAUSE -dQUIET -dBATCH -sOutputFile=/data/output.pdf /data/input.pdf
```
> `input.pdf` should be in the project root directory

### Windows CMD

you can run the `pdfutil.sh` from from Windows CLI, if you have installed Cygwin or Gitbash. If not then run directly using docker command

**Example (pdf compression):**

```batch
docker run --rm -v "%CD%":/data pdf-util gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=/data/output.pdf /data/form.pdf
```