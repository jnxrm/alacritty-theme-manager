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
fisher install gitlab.com/jnkrm/alacritty-theme-manager
```

Then, add the following line to `alacritty.toml`

```
import = ["~/.config/alacritty/theme.toml"]
```

It is also smart to enable `live_config_reload` in `alacritty.toml`

```
live_config_reload = true
```

## Usage

- `atm <theme>` : change theme to **_theme_** 🌈
- `atm` / `atm r` : **_shuffle_** through 10 random (dark) themes 💿
- `atm i` : get **_info_** about current theme ℹ️
- `atm ls` : list **_all_** available themes 📋
- `atm s` : **_star_** current theme ⭐️
- `atm ls s` / `atm s ls` : **_list_** starred themes 🌟
- `atm u` : unstar **_current_** theme ❌
- `atm u <theme>` : unstar **_theme_** ❌
