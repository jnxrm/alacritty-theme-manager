# alacritty-theme-manager

[Fish shell](https://fishshell.com) ([GitHub](https://github.com/fish-shell/fish-shell)) plugin to easily switch theme in [Alacritty](https://alacritty.org) ([GitHub](https://github.com/alacritty/alacritty))

# Installation

First, make sure to clone [alacritty-theme](https://github.com/alacritty/alacritty-theme)

```
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
```

Install the plugin with [fisher](https://github.com/jorgebucaran/awsm.fish)

```
fisher install jnxrm/alacritty-theme-manager
```

Then, add the following line to `alacritty.toml`

```
import = ["~/.config/alacritty/atm_theme.toml"]
```

It is recommended to enable `live_config_reload` in `alacritty.toml`

```
live_config_reload = true
```

## Usage

- `atm` : _change_ to a **random** (dark) theme 🔀
- `atm ls` : _list_ **all** available themes 📋
- `atm <theme>` : _change_ theme to **\<theme\>** 🌈
- `atm -s` : **star** _current_ theme ⭐️
- `atm -s ls` : **list** _starred_ themes 🌟
- `atm -s r` : change to a **_random_** _starred_ theme 💫
- `atm -u` : _unstar_ **current** theme ❌
- `atm -u <theme>` : _unstar_ **\<theme\>** ❌
- `atm -i` : get **info** about _current_ theme ℹ️
