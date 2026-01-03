# Prema - Dev Container - Automations

A development container specialized for document generation and automation tasks, part of the Slough project.

## About the Slough Project

This container is part of the **Slough project** by Daryl Stark. The Slough project aims to deliver consistent development tooling through standardized dev containers, providing developers with ready-to-use, reproducible development environments.

## Overview

This dev container extends the Slough generic base image with specialized tools for document automation and conversion. It includes support for:

- **Markdown to PDF conversion** using Pandoc with LaTeX
- **Markdown to EPUB** generation
- **LaTeX to PDF** compilation
- **Typst to PDF** conversion
- Pre-configured templates and automation scripts

## Using this Dev Container

### Image Tag

This container is available as a Docker image with the following tag format:

```
dast1968/prema-dev-dc-automations:1.0.0
```

### Quick Start with VS Code

1. **Prerequisites:**
   - Install [Docker Desktop](https://www.docker.com/products/docker-desktop)
   - Install [Visual Studio Code](https://code.visualstudio.com/)
   - Install the [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

2. **Using the Container:**
   
   Create a `.devcontainer/devcontainer.json` file in your project:

   ```json
   {
     "name": "Document Automation Environment",
     "image": "dast1968/prema-dev-dc-automations:1.0.0",
     "mounts": [
       "source=/var/run/docker.sock,target=/var/run/docker.sock,type=bind"
     ]
   }
   ```

3. **Open in Container:**
   - Open your project in VS Code
   - Press `F1` and select "Dev Containers: Reopen in Container"
   - Wait for the container to start

## Tips for Working with Dev Containers on Microsoft Windows

### Docker Desktop Configuration

- **Enable WSL 2 backend**: Go to Docker Desktop Settings → General → Use the WSL 2 based engine
- **Resource allocation**: Ensure adequate memory (at least 4GB) is allocated in Docker Desktop Settings → Resources
- **File sharing**: Windows paths are automatically shared, but check Settings → Resources → File Sharing if you encounter issues

### Performance Tips

- **Use WSL 2 file system**: Store your project files in the WSL 2 file system (e.g., `\\wsl$\Ubuntu\home\username\projects`) for better performance
- **Avoid Windows paths**: Working directly from `/mnt/c/` can be significantly slower
- **Line endings**: Configure Git to handle line endings correctly:
  ```bash
  git config --global core.autocrlf input
  ```

### Common Windows Issues

- **Port conflicts**: If ports are already in use, close applications or change port mappings in `devcontainer.json`
- **Path format**: Use forward slashes (`/`) in container paths, not backslashes (`\`)
- **Docker socket**: The container mounts Docker socket for Docker-in-Docker support
- **Antivirus software**: Some antivirus programs may slow down container operations; consider adding exclusions for Docker directories

## Container Configuration

### User Account

- **Username**: `developer`
- **Home directory**: `/home/developer`
- **Sudo access**: Available **without password** - you can run privileged commands freely
- **Shell**: Bash with Starship prompt configured

### Pre-configured Environment

The container includes:

- **Automations folder**: `/home/developer/automations` (added to PATH)
- **Templates folder**: `/home/developer/templates`
- **Eisvogel template**: Pre-installed Pandoc LaTeX template for professional documents

## Installed Tools and Usage

### 1. Pandoc

**Purpose**: Universal document converter

**Installed version**: Latest from Ubuntu repositories

**Usage example**:
```bash
pandoc input.md -o output.pdf
```

### 2. LaTeX (TeXLive Full)

**Purpose**: Complete LaTeX distribution for document typesetting

**Components**: Full TeXLive installation with all packages

**Usage example**:
```bash
pdflatex document.tex
```

### 3. Typst

**Purpose**: Modern markup-based typesetting system

**Installed version**: 0.14.2

**Usage example**:
```bash
typst compile document.typ output.pdf
```

## Automation Scripts

The container provides several convenience scripts in `/home/developer/automations` (available in your PATH):

### convert-md-to-pdf.sh

Converts Markdown files to PDF using Pandoc with the Eisvogel template.

**Usage**:
```bash
convert-md-to-pdf.sh <source_folder> <output_file>
```

**Requirements**:
- Source folder must contain a `src` subdirectory with `.md` files
- Optional `settings.env` file in source folder for metadata (TITLE, SUBTITLE, DATE, AUTHOR, INSTITUTE)

**Example**:
```bash
convert-md-to-pdf.sh ./my-document ./output/document.pdf
```

### convert-md-to-epub.sh

Converts Markdown files to EPUB3 format for e-readers.

**Usage**:
```bash
convert-md-to-epub.sh <source_folder> <output_file>
```

**Requirements**:
- Same structure as `convert-md-to-pdf.sh`
- Supports the same metadata through `settings.env`

**Example**:
```bash
convert-md-to-epub.sh ./my-book ./output/book.epub
```

### convert-latex-to-pdf.sh

Compiles LaTeX files to PDF.

**Usage**:
```bash
convert-latex-to-pdf.sh <source_file> <output_directory>
```

**Example**:
```bash
convert-latex-to-pdf.sh document.tex ./output/
```

### convert-typst-to-pdf.sh

Compiles Typst files to PDF.

**Usage**:
```bash
convert-typst-to-pdf.sh <source_file> <output_file>
```

**Example**:
```bash
convert-typst-to-pdf.sh document.typ output.pdf
```

## Templates

### Eisvogel Pandoc Template

A professional Pandoc LaTeX template (v3.3.0) is pre-installed in `/home/developer/templates/eisvogel/`.

**Features**:
- Professional title pages
- Table of contents
- Syntax highlighting for code blocks
- Customizable styling

### Custom Template Files

- `metadata.md`: Metadata template for document generation
- `front-page.png`: Title page background image
- `chapter-pagebreak.lua`: Lua filter for adding page breaks between chapters

## Project Structure for Document Generation

To use the automation scripts effectively, structure your project as follows:

```
my-document/
├── settings.env          # Metadata configuration
└── src/
    ├── 01-introduction.md
    ├── 02-chapter1.md
    └── 03-conclusion.md
```

**settings.env example**:
```bash
export TITLE="My Document"
export SUBTITLE="A Comprehensive Guide"
export DATE="$(date +%Y)"
export AUTHOR="Your Name"
export INSTITUTE="Your Organization"
```

## Additional Resources

- [Dev Containers documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Pandoc documentation](https://pandoc.org/MANUAL.html)
- [Typst documentation](https://typst.app/docs/)
- [Eisvogel template documentation](https://github.com/Wandmalfarbe/pandoc-latex-template)

## License

This project is licensed under the MIT License. See [LICENSE.md](LICENSE.md) for details.

## Author

**Daryl Stark**

Part of the Slough project - Consistent development tooling through dev containers.
