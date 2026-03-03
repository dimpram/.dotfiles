### System Prerequisites (Arch Linux)

Before launching Neovim, install the necessary system dependencies to ensure parsers can compile, clipboard syncing works, and Telescope can search lightning-fast.

Open your terminal and run:
Bash

sudo pacman -S base-devel tree-sitter tree-sitter-cli ripgrep wl-clipboard ttf-jetbrains-mono-nerd

Note: To see the Nerd Font icons properly in the foot terminal, ensure your ~/.config/foot/foot.ini has the font set: font=JetBrainsMono Nerd Font:size=11

### Post-Install Steps

Launch Neovim (nvim). lazy.nvim will automatically download and install all plugins.

Type :Mason to open the Mason package manager.

Install the required formatters by pressing / to search and i to install:

    gofumpt
    goimports
    prettier

### Custom Keybind Cheatsheet

Your Leader Key is set to Space.
Navigation & Search

    Space + e: Toggle File Explorer sidebar (nvim-tree)

    Space + f + f: Find files by name (telescope)

    Space + f + g: Live grep / Search text across all files (telescope)

    Space + f + b: Find open buffers / Switch active files (telescope)

    Space + f + h: Find help tags (telescope)

    Ctrl + h/j/k/l: Move seamlessly between split windows

Code Intelligence (LSP)

    K (Shift + k): Hover documentation / function signatures

    gd: Go to Definition

    gD: Go to Declaration

    gi: Go to Implementation

    gr: Find References

    Space + r + n: Rename variable across the project

    Space + c + a: Code Actions (auto-fix, organize imports)

Editing & Utilities

    Ctrl + Space: Manually trigger autocomplete

    Enter: Confirm autocomplete selection

    Esc (in Normal mode): Clear highlighted search results

    y, p, d: Yank, paste, and delete natively sync with your OS clipboard!
