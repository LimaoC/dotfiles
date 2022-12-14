<center>
    <h1>Limao's Dotfiles</h1>
</center>

## Gnome

### GTK Icons
- [Papirus](https://www.gnome-look.org/p/1166289)

### Gnome Shell Extensions
- [Blur my Shell](https://extensions.gnome.org/extension/3193/blur-my-shell/): Adds a blur look to different parts of the GNOME Shell, including the top panel, dash, and overview.
- [Unite](https://extensions.gnome.org/extension/1287/unite/): Makes a few layout tweaks to the top panel and removes window decorations to make it look like Ubuntu Unity Shell.

Tutorial for installing gnome shell extensions [here](https://itsfoss.com/gnome-shell-extensions/).

## kitty

### Installation
Installation instructions [here](https://sw.kovidgoyal.net/kitty/binary/). 

### Configuration
Configuration files can be found [here](/.config/kitty) (`./config/kitty/`). Notably:
- Colour theme: [Tokyo Night](https://github.com/enkia/tokyo-night-vscode-theme)
- Font: [Fira Code](https://github.com/tonsky/FiraCode)

### Keyboard Shortcuts
The keyboard shortcuts are mostly based on the default Gnome Terminal shortcuts, with a few changes.

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
| Switch to tab 1                           | `alt + 1`            |
| Switch to tab 2                           | `alt + 2`            |
| Switch to tab 3                           | `alt + 3`            |
| Switch to tab 4                           | `alt + 4`            |
| Switch to tab 5                           | `alt + 5`            |
| Switch to tab 6                           | `alt + 6`            |
| Switch to tab 7                           | `alt + 7`            |
| Switch to tab 8                           | `alt + 8`            |
| Switch to tab 9                           | `alt + 9`            |
| Switch to tab 10                          | `alt + 0`            |
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

- To make kitty the default terminal on Ubuntu (which lets you use `ctrl + alt + t` to open kitty), run the following commands:
    ```
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator `which kitty` 50
    sudo update-alternatives --config x-terminal-emulator
    ```
    and select kitty (this assumes `kitty` is on your `$PATH`).
