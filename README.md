# alacritty-theme-manager

Plugin to easily switch theme in [Alacritty](https://alacritty.org) ([GitHub](https://github.com/alacritty/alacritty))

# Installation

First, make sure to clone [alacritty-theme](https://github.com/alacritty/alacritty-theme)

```
mkdir -p ~/.config/alacritty/themes
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/theme
```

Install the plugin with [fisher](https://github.com/jorgebucaran/awsm.fish)

```
fisher install gitlab.com/jnkrm/alacritty-theme-manager
```

Then, add the following line to `alacritty.toml`

```
import = ["~/.config/alacritty/theme.toml"]
```

## Usage

`alacritty-theme-manager` : shuffle through 10 random (dark) themes 🔀

`alacritty-theme-manager <theme-name>` : change theme to _theme-name_ 🌈

`alacritty-theme-manager ls` : list all available themes 📋

`alacritty-theme-manager star` : star current theme ⭐️

`alacritty-theme-manager ls star` : list starred themes 🌟

`alacritty-theme-manager rm <theme-name>` : remove _theme-name_ from starred themes ❌
