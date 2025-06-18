# Use a slim but compatible Debian base image
FROM debian:bookworm-slim

# Install Ghostscript and pdfunite (via poppler-utils)
RUN apt-get update && \
    apt-get install -y ghostscript poppler-utils && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# copy compress and resize command scripts
COPY scripts/pdfcompress /bin
COPY scripts/pdfresize /bin

RUN chmod 777 /bin/pdfcompress && chmod 777 bin/pdfresize

# Default to shell to keep container alive if needed
CMD ["bash"]