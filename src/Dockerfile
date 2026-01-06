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

# Add automations
COPY --chown=developer:developer automations /home/developer/automations

# Set permissions and create Typst local packages directory
RUN chmod +x /home/developer/automations/*.sh && \
    mkdir -p /home/developer/.local/share/typst/packages/local/ && \
    mkdir -p ~/.local/share/fonts/source-sans

# Copy Typst templates and the required fonts
COPY --chown=developer:developer typst-templates/ /home/developer/.local/share/typst/packages/local/
COPY --chown=developer:developer fonts/SourceSans3-*.ttf /home/developer/.local/share/fonts/source-sans/

# Copy local bashrc additions
COPY --chown=developer:developer .bashrc.local /home/developer/.bashrc.local

# Set working directory
WORKDIR /home/developer/

# Configure Starship
ENV PROMPTNAME="DOC"

# Set the default command to bash
CMD ["bash"]