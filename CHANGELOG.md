# Changelog

All notable changes to these dotfiles are recorded here.
The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## 2026-11-26

### Added

- **tmux**: window tabs show the pane title (the task Claude Code / opencode is on), the directory name for plain shells, or the Antigravity conversation title via `tmux/tmux-agy-title`; the current window is marked with `▶`.
- **zsh**: `copilot-gh` alias, Antigravity CLI path, Claude Code Code Mode, sonar-scanner and `/opt/nvim-linux64` paths, and `BROWSER` set to `wsl-browser` on WSL.
- **nvim**: copilot also for Lua and Rust; prettier formats `typescriptreact`.

### Changed

- **zsh**: Go, Java 21, pyenv, sonar-scanner and nvim paths are picked by what exists on the machine, so the same file works on Debian/WSL and the other machine.
- **zsh**: the headroom proxy env (including `ANTHROPIC_BASE_URL`) is only set where `headroom` is installed.
- **nvim/java**: the custom checkstyle formatter profile is used only when `~/Code/checkstyle.xml` exists.

## 2026-11-21

### Added

- **nvim**: new plugins
  - `claudecode.nvim`: connects Claude Code running in another terminal (`/ide`); `<leader>i*` keys to send a selection, add a buffer, and accept or deny diffs.
  - `copilot.vim` for Java, Go, Python, TypeScript and JavaScript.
  - `diffview.nvim`: `<leader>gd` toggles a view of uncommitted changes, `<leader>gm` reviews the whole branch against its merge base with `develop`.
  - `mssql.nvim` (`<leader>d` prefix), refreshing the Entra ID token before connecting when it has expired.
  - `render-markdown.nvim` (`<leader>md` toggles rendering).
  - `sonarlint.nvim` for Python, Java, TypeScript, JavaScript and Go, in its own file.
  - `which-key.nvim` (`<leader>?` lists the buffer's keymaps).
- **nvim**: `ftplugin/markdown.lua` turns on soft wrap, word-boundary line breaks and `gj`/`gk` movement in markdown buffers.
- **nvim**: buffers reload automatically when files change on disk (1s timer plus focus/cursor-hold `checktime`), with a notification on each reload.
- **tmux**: `tmux/status.sh` provides the status-line segments (CPU usage and temperature, memory, GPU temperature, Spotify track, pomodoro, and the git email for the active pane's directory), using `/proc` and `/sys` instead of external tools.
- **alacritty**: `alacritty.toml` config with a local `catppuccin-mocha.toml` theme.
- **zsh**: settings for pnpm, pipx, Java 21, pyenv, Turso, opencode, the Azure profile switcher (`azp`) and the headroom proxy.
- **zsh**: sources an untracked `~/.zshrc.local` for machine-local secrets; `.zshrc.local` is in `.gitignore`.

### Changed

- **nvim/lsp**: replaced `lsp-zero` with built-in `vim.lsp.config` and an `LspAttach` autocmd; `mason-lspconfig` enables installed servers automatically (except `jdtls`, which `nvim-jdtls` starts). Diagnostics now use `vim.diagnostic.jump`; added `<leader>t` (implementation) and `<leader>vj`/`<leader>vk`. Mason moved to `<leader>lm`.
- **nvim/treesitter**: moved to the `main` branch; parsers install on demand per filetype and highlighting starts automatically.
- **nvim/telescope**: `^0.2` instead of the frozen `0.1.x` branch, which broke file previews; also loads on `:Telescope`.
- **nvim/neo-tree**: rewritten config. `<leader>e` toggles the file tree, `<leader>ge` the git status tree; follows the current file and watches the file system.
- **nvim/gitsigns**: hunk navigation (`]h`/`[h`, `<leader>gj`/`<leader>gk`), inline preview, stage, reset and word-diff keymaps, and a quickfix list of all hunks.
- **nvim/harpoon**: previous/next moved to `<leader>hk`/`<leader>hj`.
- **nvim/fugitive**: pull moved from `<leader>gP` to `<leader>gf`.
- **nvim**: lazy.nvim checks for updates without notifying; plugin versions in `lazy-lock.json` are updated.
- **tmux**: colors updated to the actual Catppuccin Mocha palette, status refreshes every second, segments come from `status.sh`, focus events are on.

### Removed

- **alacritty**: the `catppuccin` submodule, replaced by the local theme file.
- **nvim/java**: the Java-only SonarLint setup (now in `sonarlint.lua`).
- **tmux**: `set-clipboard on` and the arrow separators in window tabs.
