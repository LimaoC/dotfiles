<center>
    <h1>Limao's Dotfiles</h1>
</center>

![desktop](/.assets/desktop.png)


## Overview

- OS: Ubuntu
- Desktop environment: [Gnome](#gnome)
- Terminal emulator: [kitty](#kitty)
- Terminal shell: zsh with [Oh My Zsh](#oh-my-zsh)
- Text editor: [Neovim](#neovim)

## Gnome
Tutorial for installing Gnome shell extensions [here](https://itsfoss.com/gnome-shell-extensions/).

### GTK Icons
- [Papirus](https://www.gnome-look.org/p/1166289)

### Gnome Shell Extensions
- [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/): Adds a blur look to different parts of the GNOME Shell, including the top panel, dash, and overview.
- [Rounded Window Corners](https://extensions.gnome.org/extension/5237/rounded-window-corners/): Add rounded corners for all windows
- [Unite](https://extensions.gnome.org/extension/1287/unite/): Makes a few layout tweaks to the top panel and removes window decorations to make it look like Ubuntu Unity Shell.

## kitty

![kitty](/.assets/kitty.png)

### Installation
Installation instructions [here](https://sw.kovidgoyal.net/kitty/binary/). 

### Configuration
My configuration files can be found [here](/.config/kitty) (`.config/kitty`).
- Colour theme: Based on [Tokyo Night](https://github.com/davidmathers/tokyo-night-kitty-theme), with some minor changes
- Font: [Caskaydia Cove (patched font for Cascadia Code)](https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/CascadiaCode)

### Keyboard Shortcuts
The keyboard shortcuts are mostly based on the default Gnome Terminal shortcuts, with a few changes. The configuration file can be found [here](/.config/kitty/shortcuts.conf) (`.config/kitty/shortcuts.conf`).

<details>
<summary>Copy/paste</summary>

| Action               | Shortcut           |
| -------------------- | ------------------ |
| Copy to clipboard    | `ctrl + shift + c` |
| Paste from clipboard | `ctrl + shift + v` |

</details>

<details>
<summary>Debugging</summary>

| Action            | Shortcut            |
| ----------------- | ------------------- |
| Open debug config | `ctrl + shift + f6` |

</details>

<details>
<summary>Layouts</summary>

| Action                | Shortcut           |
| --------------------- | ------------------ |
| Rotate to next layout | `ctrl + shift + r` |

</details>

<details>
<summary>Miscellaneous</summary>

| Action                     | Shortcut            |
| -------------------------- | ------------------- |
| Show kitty documentation   | `ctrl + shift + f1` |
| Edit kitty config file     | `ctrl + shift + f2` |
| (Re)load kitty config file | `ctrl + shift + f5` |

</details>

<details>
<summary>Tab Management</summary>

| Action                                    | Shortcut             |
| ----------------------------------------- | -------------------- |
| Switch to tab 1                           | `ctrl + alt + 1`     |
| Switch to tab 2                           | `ctrl + alt + 2`     |
| Switch to tab 3                           | `ctrl + alt + 3`     |
| Switch to tab 4                           | `ctrl + alt + 4`     |
| Switch to tab 5                           | `ctrl + alt + 5`     |
| Switch to tab 6                           | `ctrl + alt + 6`     |
| Switch to tab 7                           | `ctrl + alt + 7`     |
| Switch to tab 8                           | `ctrl + alt + 8`     |
| Switch to tab 9                           | `ctrl + alt + 9`     |
| Switch to tab 10                          | `ctrl + alt + 0`     |
| Close current tab                         | `ctrl + shift + q`   |
| Move current tab backward                 | `ctrl + shift + ,`   |
| Move current tab forward                  | `ctrl + shift + .`   |
| Open a new tab (in the current directory) | `ctrl + shift + t`   |
| Switch to the next tab                    | `ctrl + tab`         |
| Switch to the previous tab                | `ctrl + shift + tab` |

</details>

<details>
<summary>Window Management</summary>

| Action                                                      | Shortcut               |
| ----------------------------------------------------------- | ---------------------- |
| Switch to window 1                                          | `ctrl + shift + 1`     |
| Switch to window 2                                          | `ctrl + shift + 2`     |
| Switch to window 3                                          | `ctrl + shift + 3`     |
| Switch to window 4                                          | `ctrl + shift + 4`     |
| Switch to window 5                                          | `ctrl + shift + 5`     |
| Switch to window 6                                          | `ctrl + shift + 6`     |
| Switch to window 7                                          | `ctrl + shift + 7`     |
| Switch to window 8                                          | `ctrl + shift + 8`     |
| Switch to window 9                                          | `ctrl + shift + 9`     |
| Switch to window 10                                         | `ctrl + shift + 0`     |
| Decrease font size for all windows                          | `ctrl + shift + minus` |
| Increase font size for all windows                          | `ctrl + shift + plus`  |
| Move current window backward                                | `ctrl + shift + b`     |
| Move current window forward                                 | `ctrl + shift + f`     |
| Move current window to top                                  | ``ctrl + shift + ` ``  |
| Switch to the next window                                   | `ctrl + shift + l`     |
| Switch to the previous window                               | `ctrl + shift + h`     |
| Swap current window with another window (selected visually) | `ctrl + shift + f8`    |
| Close current window                                        | `ctrl + shift + w`     |
| Open a new window (in the current directory)                | `ctrl + shift + n`     |
| Toggle fullscreen                                           | `f11`                  |
| Make current window narrower                                | `ctrl + shift + left`  |
| Make current window wider                                   | `ctrl + shift + right` |
| Make current window taller                                  | `ctrl + shift + up`    |
| Make current window shorter                                 | `ctrl + shift + down`  |
| Reset window sizes to default                               | `ctrl + shift + home`  |

</details>

### Miscellaneous

- To make kitty the default terminal on Ubuntu (which lets you use `ctrl + alt + t` on Ubuntu to open kitty), run the following commands:
    ```
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator `which kitty` 50
    sudo update-alternatives --config x-terminal-emulator
    ```
    and select kitty. Note that this assumes `kitty` is on your `$PATH`. If you installed a pre-built binary of `kitty` using the default command, `kitty` is installed to `~/.local/kitty.app` on Linux, and you can add it to your path by e.g. adding a symlink for it in `/usr/local/bin`, which is what I have done.

## Oh My Zsh

### Installation
- Installation instructions for zsh [here](https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH).
- Installation instructions for Oh My Zsh [here](https://github.com/ohmyzsh/ohmyzsh). You'll need to have zsh installed first.

### Configuration
- Main config file for zsh is [here](/.zshrc) (`.zshrc`).
- Custom Oh My Zsh config is [here](/.oh-my-zsh-custom) (I use `$ZSH_CUSTOM = ~/.oh-my-zsh-custom` for my custom Oh My Zsh directory).

### Plugins
- [Git](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git): Provides some aliases and useful functions. Built-in to Oh My Zsh.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions): Suggests commands as you type based on history and completions.
- [zsh-nvm](https://github.com/lukechilds/zsh-nvm): Set up nvm once and never touch it again. Has a lazy-load setting for nvm which is very useful.
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting): Syntax highlighting for zsh.

### Theme
- I use a custom theme with a pretty prompt that displays useful things like
  - Git info (if in a Git repository)
  - Conda environment (if one is active)
  - Timestamp (I don't use this personally, but the option is there if you'd like to use it)
It can be found [here](/.oh-my-zsh-custom/themes/limao.zsh-theme) (`/.oh-my-zsh-custom/themes/limao.zsh-theme`). You can enable/disable parts of the prompt to your liking, or add more parts.

## Neovim

![neovim](/.assets/nvim.png)
![neovim2](/.assets/nvim2.png)

### Installation
Installation instructions [here](https://github.com/neovim/neovim/wiki/Installing-Neovim).

### Configuration
My configuration files can be found [here](/.config/nvim) (`.config/nvim`). For compatibility's sake (and in the rare occasion where I do need to use regular vim), settings that are common to regular vim can be found in `.vimrc`, and my Neovim config is set up to first run everything that is in `.vimrc`.

### General Plugins
- [folke/lazy.nvim](https://github.com/folke/lazy.nvim) - A modern plugin manager for Neovim.

### Code Plugins
- [averms/black-nvim](https://github.com/averms/black-nvim) - A Neovim plugin to format your code using Black.
- [lervag/vimtex](https://github.com/lervag/vimtex) - A modern Vim and neovim filetype plugin for LaTeX files.

### Editor Plugins
- [romgrk/barbar.nvim](https://github.com/romgrk/barbar.nvim) - The neovim tabline plugin.
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - A blazing fast and easy to configure neovim statusline plugin written in pure lua.
- [nvim-tree/nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) - A file explorer tree for neovim written in lua.

### LSP Plugins
- [hrsh7th/cmp-nvim-lsp](https://github.com/hrsh7th/cmp-nvim-lsp) - nvim-cmp source for neovim builtin LSP client.
- [ray-x/lsp_signature.nvim](https://github.com/ray-x/lsp_signature.nvim) - LSP signature hint as you type.
- [VonHeikemen/lsp-zero.nvim](https://github.com/VonHeikemen/lsp-zero.nvim) - A starting point to setup some lsp related features in neovim.
- [williamboman/mason.nvim](https://github.com/williamboman/mason.nvim) - Portable package manager for Neovim that runs everywhere Neovim runs. Easily install and manage LSP servers, DAP servers, linters, and formatters.
- [williamboman/mason-lspconfig.nvim](https://github.com/williamboman/mason-lspconfig.nvim) - Extension to mason.nvim that makes it easier to use lspconfig with mason.nvim.
- [hrsh7th/nvim-cmp](https://github.com/hrsh7th/nvim-cmp) - A completion plugin for neovim coded in Lua.
- [neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - Quickstart configs for Nvim LSP.
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Nvim Treesitter configurations and abstraction layer.

### Theme
- [TokyoNight.nvim](https://github.com/folke/tokyonight.nvim/): Tokyo Night theme for Neovim.

### Miscellaneous
- If you're using Wayland (like me), you might need to `apt install wl-clipboard` to get copy/paste with the system clipboard working in Neovim.

## Other
- [Zathura](https://pwmt.org/projects/zathura/) - PDF viewer with vim-esque bindings. Integrates with vimtex.
- [Wallpaper](https://wall.alphacoders.com/big.php?i=1163116)

