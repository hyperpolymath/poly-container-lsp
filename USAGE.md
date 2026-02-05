# Usage Guide

> Comprehensive guide for using poly-container-lsp across VSCode, Neovim, and Emacs

## Table of Contents

- [VSCode Setup](#vscode-setup)
- [Neovim Setup](#neovim-setup)
- [Emacs Setup](#emacs-setup)
- [Configuration](#configuration)
- [Commands](#commands)
- [Troubleshooting](#troubleshooting)
- [Adapter-Specific Notes](#adapter-specific-notes)

## VSCode Setup

### Installation

1. **Install the LSP Server:**
   ```bash
   git clone https://github.com/hyperpolymath/poly-container-lsp.git
   cd poly-container-lsp
   ./install.sh
   ```

2. **Install VSCode Extension:**
   ```bash
   cd vscode-extension
   npm install
   npm run compile
   code --install-extension *.vsix
   ```

### Features

The VSCode extension provides:

- **Multi-Runtime Support**: nerdctl, podman, docker
- **Dockerfile Completion**: Instructions, best practices, multi-stage builds
- **Compose Validation**: docker-compose.yml and compose.yaml files
- **Diagnostics**: Security issues, deprecated instructions, layer optimization
- **Hover Documentation**: Instruction docs, image information
- **Commands**: Build, run, push, inspect containers directly from editor

### Available Commands

Access via Command Palette (`Ctrl+Shift+P` / `Cmd+Shift+P`):

- **Container: Build Image** - Build container image
- **Container: Run Container** - Run container from Dockerfile
- **Container: Push Image** - Push image to registry
- **Container: List Containers** - Show running containers
- **Container: List Images** - Show available images
- **Container: Inspect** - Inspect container or image
- **Container: Logs** - View container logs
- **Container: Switch Runtime** - Change between nerdctl/podman/docker

### Settings

Add to your workspace or user `settings.json`:

```json
{
  "lsp.serverPath": "/path/to/poly-container-lsp",
  "lsp.trace.server": "verbose",
  "lsp.container.runtime": "auto",
  "lsp.container.validateOnSave": true,
  "lsp.container.enableSecurityLinting": true
}
```

## Neovim Setup

### Using nvim-lspconfig

Add to your Neovim configuration:

```lua
local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

-- Register poly-container-lsp if not already defined
if not configs.poly_container_lsp then
  configs.poly_container_lsp = {
    default_config = {
      cmd = {'/path/to/poly-container-lsp/_build/prod/rel/poly_container_lsp/bin/poly_container_lsp'},
      filetypes = {'dockerfile', 'yaml'},
      root_dir = lspconfig.util.root_pattern(
        'Dockerfile',
        'Containerfile',
        'docker-compose.yml',
        'docker-compose.yaml',
        'compose.yml',
        'compose.yaml'
      ),
      settings = {
        container = {
          runtime = 'auto',
          validateOnSave = true,
          enableSecurityLinting = true
        }
      }
    }
  }
end

-- Setup the LSP
lspconfig.poly_container_lsp.setup({
  on_attach = function(client, bufnr)
    -- Enable completion
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Key mappings
    local opts = { noremap=true, silent=true, buffer=bufnr }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)

    -- Custom commands
    vim.api.nvim_buf_create_user_command(bufnr, 'ContainerBuild', function()
      vim.lsp.buf.execute_command({command = 'container.build'})
    end, {})

    vim.api.nvim_buf_create_user_command(bufnr, 'ContainerRun', function()
      vim.lsp.buf.execute_command({command = 'container.run'})
    end, {})

    vim.api.nvim_buf_create_user_command(bufnr, 'ContainerImages', function()
      vim.lsp.buf.execute_command({command = 'container.images'})
    end, {})
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities()
})
```

### Using coc.nvim

Add to `:CocConfig`:

```json
{
  "languageserver": {
    "poly-container-lsp": {
      "command": "/path/to/poly-container-lsp/_build/prod/rel/poly_container_lsp/bin/poly_container_lsp",
      "filetypes": ["dockerfile", "yaml"],
      "rootPatterns": ["Dockerfile", "docker-compose.yml", "compose.yaml"],
      "settings": {
        "container": {
          "runtime": "auto",
          "validateOnSave": true
        }
      }
    }
  }
}
```

## Emacs Setup

### Using lsp-mode

Add to your Emacs configuration:

```elisp
(use-package lsp-mode
  :hook ((dockerfile-mode yaml-mode) . lsp)
  :config
  (add-to-list 'lsp-language-id-configuration '(dockerfile-mode . "dockerfile"))

  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     '("/path/to/poly-container-lsp/_build/prod/rel/poly_container_lsp/bin/poly_container_lsp"))
    :major-modes '(dockerfile-mode yaml-mode)
    :server-id 'poly-container-lsp
    :priority 1
    :activation-fn (lsp-activate-on "dockerfile" "yaml")
    :initialization-options (lambda ()
                             '(:runtime "auto"
                               :validateOnSave t)))))

;; Custom commands
(defun container-build ()
  "Build container image."
  (interactive)
  (lsp-execute-command "container.build"))

(defun container-run ()
  "Run container."
  (interactive)
  (lsp-execute-command "container.run"))

(defun container-images ()
  "List container images."
  (interactive)
  (lsp-execute-command "container.images"))

(define-key lsp-mode-map (kbd "C-c d b") 'container-build)
(define-key lsp-mode-map (kbd "C-c d r") 'container-run)
(define-key lsp-mode-map (kbd "C-c d i") 'container-images)
```

### Using eglot

```elisp
(use-package eglot
  :hook ((dockerfile-mode yaml-mode) . eglot-ensure)
  :config
  (add-to-list 'eglot-server-programs
               '((dockerfile-mode yaml-mode)
                 . ("/path/to/poly-container-lsp/_build/prod/rel/poly_container_lsp/bin/poly_container_lsp"))))

;; Custom commands
(defun container-build ()
  "Build container image."
  (interactive)
  (eglot-execute-command (eglot--current-server-or-lose) "container.build" nil))
```

## Configuration

### Server Configuration

Create `.poly-container-lsp.json` in your project root:

```json
{
  "container": {
    "runtime": "nerdctl",
    "validateOnSave": true,
    "enableSecurityLinting": true,
    "defaultRegistry": "docker.io",
    "buildArgs": {
      "BUILDKIT_INLINE_CACHE": "1"
    }
  },
  "security": {
    "enableHadolint": true,
    "enableDockle": true,
    "enableTrivy": true,
    "failOnSeverity": "high"
  },
  "compose": {
    "validateSchema": true,
    "enableServiceCompletion": true
  }
}
```

### Environment Variables

```bash
# Runtime selection
export CONTAINER_RUNTIME=nerdctl  # or podman, docker

# nerdctl configuration
export CONTAINERD_NAMESPACE=default
export CONTAINERD_ADDRESS=/run/containerd/containerd.sock

# Podman configuration
export PODMAN_CONNECTION=podman-machine-default

# Docker configuration
export DOCKER_HOST=unix:///var/run/docker.sock
export DOCKER_BUILDKIT=1

# Registry authentication
export DOCKER_CONFIG=~/.docker
export REGISTRY_AUTH_FILE=~/.config/containers/auth.json
```

## Commands

### LSP Commands

All commands available via `workspace/executeCommand`:

#### container.build
Build container image from Dockerfile.

**Parameters:**
- `tag` (optional): Image tag
- `context` (optional): Build context path

**Returns:** Build status and image ID

**Example (Neovim):**
```lua
vim.lsp.buf.execute_command({
  command = 'container.build',
  arguments = {{tag = 'myapp:latest'}}
})
```

#### container.run
Run container from image.

**Parameters:**
- `image`: Image name/ID
- `ports` (optional): Port mappings
- `volumes` (optional): Volume mounts

**Returns:** Container ID and status

#### container.push
Push image to registry.

**Parameters:**
- `image`: Image to push
- `registry` (optional): Registry URL

**Returns:** Push status

#### container.images
List available images.

**Parameters:** None

**Returns:** Image list with tags and sizes

#### container.containers
List running containers.

**Parameters:**
- `all` (optional): Include stopped containers

**Returns:** Container list with status

#### container.inspect
Inspect container or image.

**Parameters:**
- `target`: Container/image ID or name

**Returns:** Detailed information

#### container.logs
View container logs.

**Parameters:**
- `container`: Container ID/name
- `tail` (optional): Number of lines (default: 100)

**Returns:** Log output

#### container.switch
Switch container runtime.

**Parameters:**
- `runtime`: Runtime name (nerdctl, podman, docker)

**Returns:** Success status

## Troubleshooting

### LSP Server Not Starting

**Symptoms:** No completions, diagnostics, or hover information.

**Solutions:**

1. **Check server binary:**
   ```bash
   ls -la /path/to/poly-container-lsp/_build/prod/rel/poly_container_lsp/bin/poly_container_lsp
   ```

2. **Verify runtime:**
   ```bash
   nerdctl version  # or podman, docker
   ```

3. **Test server manually:**
   ```bash
   cd /path/to/poly-container-lsp
   mix test
   ```

### Runtime Not Detected

**Symptoms:** "Container runtime not found" error.

**Solutions:**

1. **Verify runtime installation:**
   ```bash
   which nerdctl
   which podman
   which docker
   ```

2. **Check runtime socket:**
   ```bash
   # nerdctl/containerd
   ls -la /run/containerd/containerd.sock

   # podman
   podman info

   # docker
   docker info
   ```

3. **Set runtime explicitly:**
   ```json
   {"lsp.container.runtime": "nerdctl"}
   ```

### Build Failures

**Symptoms:** `container.build` command fails.

**Solutions:**

1. **Test build manually:**
   ```bash
   nerdctl build -t test:latest .
   ```

2. **Check Dockerfile syntax:**
   ```bash
   hadolint Dockerfile
   ```

3. **Verify build context:**
   ```bash
   ls -la .dockerignore
   ```

### Security Linting Errors

**Symptoms:** Many security warnings in diagnostics.

**Solutions:**

1. **Install security tools:**
   ```bash
   # Hadolint (Dockerfile linter)
   brew install hadolint  # or apt-get install hadolint

   # Dockle (image linter)
   brew install goodwithtech/r/dockle

   # Trivy (vulnerability scanner)
   brew install trivy
   ```

2. **Configure severity threshold:**
   ```json
   {"security": {"failOnSeverity": "critical"}}
   ```

## Adapter-Specific Notes

### nerdctl

**Detection:** `nerdctl` binary in PATH, containerd socket available

**Features:**
- Full Docker CLI compatibility
- Rootless mode support
- BuildKit integration
- Image encryption
- Lazy pulling

**Configuration:**
```json
{
  "adapters": {
    "nerdctl": {
      "namespace": "default",
      "address": "/run/containerd/containerd.sock",
      "enableBuildKit": true,
      "enableLazyPulling": false,
      "enableEncryption": false
    }
  }
}
```

**Known Issues:**
- Lazy pulling requires additional setup
- Image encryption not widely supported in registries

### Podman

**Detection:** `podman` binary in PATH

**Features:**
- Rootless containers
- Pod management (Kubernetes-like)
- Systemd integration
- Compose support (via podman-compose)
- Docker Socket compatibility

**Configuration:**
```json
{
  "adapters": {
    "podman": {
      "connection": "podman-machine-default",
      "enableRootless": true,
      "enablePods": true,
      "enableSystemd": true
    }
  }
}
```

**Known Issues:**
- Podman machine required on macOS
- Some Docker Compose v3 features not supported

### Docker

**Detection:** `docker` binary in PATH, Docker daemon running

**Features:**
- Wide ecosystem support
- Docker Compose integration
- BuildKit support
- Multi-platform builds
- Docker Extensions

**Configuration:**
```json
{
  "adapters": {
    "docker": {
      "host": "unix:///var/run/docker.sock",
      "enableBuildKit": true,
      "enableMultiPlatform": true,
      "enableExperimental": false
    }
  }
}
```

**Known Issues:**
- Requires Docker daemon (not rootless by default)
- Docker Desktop licensing on commercial use

## Additional Resources

- **GitHub Repository:** https://github.com/hyperpolymath/poly-container-lsp
- **Issue Tracker:** https://github.com/hyperpolymath/poly-container-lsp/issues
- **Examples:** See `examples/` directory for sample configurations
- **API Documentation:** Run `mix docs` to generate API docs

## License

PMPL-1.0-or-later
