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

- `atm` : change to a **_random_** (dark) theme 🔀
- `atm <theme>` : change theme to **_\<theme\>_** 🌈
- `atm ls` : list **_all_** available themes 📋
- `atm -s` : **_star_** current theme ⭐️
- `atm -s ls` : **_list_** starred themes 🌟
- `atm -u` : unstar **_current_** theme ❌
- `atm -u <theme>` : unstar **_\<theme\>_** ❌
- `atm -i` : get **_info_** about current theme ℹ️
