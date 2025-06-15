# Use Alpine as the base image
FROM alpine:latest

# Install Ghostscript and clean up afterward
RUN apk update && \
    apk add --no-cache ghostscript

COPY ghostscripts/pdfcompress /bin
COPY ghostscripts/pdfresize /bin

RUN chmod 777 /bin/pdfcompress && chmod 777 bin/pdfresize

# Default command to run
CMD ["/bin/sh"]