# hadolint ignore=DL3007
FROM dast1986/slough-dev-dc-generic-base:1.0.0 AS base

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Switch to root user
USER root

# Intall Pandoc and LaTeX tools
# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    pandoc \
    texlive-full \
    wget \
    tar \
    xz-utils \
    ca-certificates && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install Typst
# hadolint ignore=DL3003
RUN TYPST_VERSION="0.14.2" && \
    wget -q "https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz" -O typst.tar.xz && \
   tar -xf typst.tar.xz && \
   mv typst-x86_64-unknown-linux-musl/typst /usr/local/bin/typst && \
   rm -rf typst-x86_64-unknown-linux-musl typst.tar.xz && \
   chmod +x /usr/local/bin/typst

# Switch back to developer user
USER developer

COPY --chown=developer:developer .bashrc.local /home/developer/.bashrc.local

# Add automations
COPY --chown=developer:developer automations /home/developer/automations
COPY --chown=developer:developer templates /home/developer/templates
RUN chmod +x /home/developer/automations/*.sh

WORKDIR /home/developer/templates
RUN wget -q -nv https://github.com/Wandmalfarbe/pandoc-latex-template/releases/download/v3.3.0/Eisvogel.tar.gz && \
    tar -xvf Eisvogel.tar.gz && \
    rm Eisvogel.tar.gz && \
    mv Eisvogel-3.3.0 eisvogel && \
    rm -r eisvogel/examples && \
    rm -r eisvogel/*.md

WORKDIR /home/developer/

# Configure Starship
ENV PROMPTNAME="MSC"

# Set the default command to bash
CMD ["bash"]