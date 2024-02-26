# Function to manage themes in the Alacritty terminal emulator
function atm -d "Manage Alacritty themes"
    # All themes
    echo $(string match -gr "(.*)\.toml" $(ls ~/.config/alacritty/themes/themes))|read -a themes_all
    # Starred themes
    if not test -e ~/.config/alacritty/themes_starred
        echo $(touch ~/.config/alacritty/themes_starred)
    end
    echo $(cat ~/.config/alacritty/themes_starred)|read -a themes_starred
    # Light themes
    if not test -e ~/.config/alacritty/themes_light
        echo $(touch ~/.config/alacritty/themes_light)
        set themes_light alabaster ashes_light atom_one_light ayu_light catppuccin_latte everforest_light github_light github_light_colorblind github_light_default github_light_high_contrast github_light_tritanopia gruvbox_light gruvbox_material_hard_light gruvbox_material_medium_light night_owlish_light noctis-lux nord_light papercolor_light papertheme pencil_light rose-pine-dawn solarized_light
        for theme in $themes_light
            echo $theme >> ~/.config/alacritty/themes_light
        end
    end
    echo $(cat ~/.config/alacritty/themes_light)|read -a themes_light
    # Dark themes
    set themes_dark
    for theme in $themes_all
        if not contains $theme $themes_light
            set -a themes_dark $theme
        end
    end
    # Current theme
    if not test -e ~/.config/alacritty/theme_current
        echo $(touch ~/.config/alacritty/theme_current)
        echo papercolor_dark >> ~/.config/alacritty/theme_current
    end
    set theme_current $(cat ~/.config/alacritty/theme_current)
    switch $(count $argv)
        case 0
            # Shuffle through a set of random themes
            set counter 0
            while test $counter -lt 10
                set counter (math $counter + 1)
                set theme_random $(random choice $themes_dark)
                cp ~/.config/alacritty/themes/themes/$theme_random.toml ~/.config/alacritty/
                mv ~/.config/alacritty/$theme_random.toml ~/.config/alacritty/theme.toml
                sleep 0.05
            end
            # Echo theme name in italic using escape characters
            if contains $theme_random $themes_starred
                echo -e "Theme changed to: \e[1;3m$theme_random\e[0m "\uf005
            else
                echo -e "Theme changed to: \e[1;3m$theme_random\e[0m"
            end
            echo -n > ~/.config/alacritty/theme_current
            echo $theme_random >> ~/.config/alacritty/theme_current
        case 1
            # Print all themes
            if test $argv = l
                set counter 0
                for theme in $themes_all
                    set counter (math $counter + 1)
                    if contains $theme $themes_starred
                        echo -e "\e[4;5m$counter\e[0m: \e[1;3m$theme\e[0m "\uf005
                    else if contains $theme $themes_light
                        echo -e "\e[4;5m$counter\e[0m: \e[1;3m$theme\e[0m \e[7mlight\e[0m"
                    else
                        echo -e "\e[4;5m$counter\e[0m: \e[1;3m$theme\e[0m"
                    end
                end
            # Star current theme
            else if test $argv = s
                if not contains $theme_current $themes_starred
                    echo $theme_current >> ~/.config/alacritty/themes_starred
                    echo -e "\e[1;3m$theme_current\e[0m successfully added to "\uf005\uf005\uf005
                else
                    echo -e "\e[1;3m$theme_current\e[0m is already in "\uf005\uf005\uf005
                end
            # Get info about current theme
            else if test $argv = i
                if contains $theme_current $themes_starred
                    echo -e "Current theme: \e[1;3m$theme_current\e[0m" \uf005
                else
                    echo -e "Current theme: \e[1;3m$theme_current\e[0m"
                end
                # Shuffle through a set of random themes
            else if test $argv = r
                set counter 0
                while test $counter -lt 10
                    set counter (math $counter + 1)
                    set theme_random $(random choice $themes_dark)
                    cp ~/.config/alacritty/themes/themes/$theme_random.toml ~/.config/alacritty/
                    mv ~/.config/alacritty/$theme_random.toml ~/.config/alacritty/theme.toml
                    sleep 0.05
                end
                # Echo theme name in italic using escape characters
                if contains $theme_random $themes_starred
                    echo -e "Theme changed to: \e[1;3m$theme_random\e[0m "\uf005
                else
                    echo -e "Theme changed to: \e[1;3m$theme_random\e[0m"
                end
                echo -n > ~/.config/alacritty/theme_current
                echo $theme_random >> ~/.config/alacritty/theme_current
            else if test $argv = u
                if contains $theme_current $themes_starred
                    set themes_starred (string match -v $theme_current $themes_starred)
                    echo -n > ~/.config/alacritty/themes_starred
                    for theme_starred in $themes_starred
                        echo $theme_starred >> ~/.config/alacritty/themes_starred
                    end
                    echo -e "Successfully removed \e[1;3m$theme_current\e[0m from "\uf005\uf005\uf005
                else
                    echo -e "\e[1;3m$theme_current\e[0m is not a starred theme, so it cannot be removed from "\uf005\uf005\uf005
                end
            else
                # 
                if contains $argv $themes_all
                    cp ~/.config/alacritty/themes/themes/$argv.toml ~/.config/alacritty/
                    mv ~/.config/alacritty/$argv.toml ~/.config/alacritty/theme.toml
                    echo -n > ~/.config/alacritty/theme_current
                    echo $argv >> ~/.config/alacritty/theme_current
                    if contains $argv $themes_starred
                        echo -e "Current theme: \e[1;3m$argv\e[0m" \uf005
                    else
                        echo -e "Current theme: \e[1;3m$argv\e[0m"
                    end
                else
                    echo -e "\e[1;3m$argv\e[0m is \e[4mnot\e[0m a valid theme name.\nCheck available theme names with the function \e[1;3mlist_themes\e[0m"
                end
            end
        case 2
            if test $argv[1] = s && test $argv[2] = s
                for theme in $themes_starred
                    echo -e \uf005 "\e[1;3m$theme\e[0m"
                end
            else if test $argv[1] = s && test $argv[2] = s
                for theme in $themes_starred
                    echo -e \uf005 "\e[1;3m$theme\e[0m"
                end
            else if test $argv[1] = s
                set theme $argv[2]
                if contains $theme $themes_all
                    if not contains $theme $themes_starred
                        echo $theme >> ~/.config/alacritty/themes_starred
                        echo -e "\e[1;3m$theme\e[0m successfully added to "\uf005\uf005\uf005
                    else
                        echo -e "\e[1;3m$theme\e[0m is already in "\uf005\uf005\uf005
                    end
                else
                    echo -e "\e[1;3m$theme\e[0m is \e[4mnot\e[0m a valid theme name.\nCheck available theme names with the function \e[1;3mlist_themes\e[0m"
                end
            else if test $argv[1] = u
                set theme $argv[2]
                if contains $theme $themes_all
                    if contains $theme $themes_starred
                        set themes_starred (string match -v $theme $themes_starred)
                        echo -n > ~/.config/alacritty/themes_starred
                        for theme_starred in $themes_starred
                            echo $theme_starred >> ~/.config/alacritty/themes_starred
                        end
                        echo -e "Successfully removed \e[1;3m$theme\e[0m from "\uf005\uf005\uf005
                    else
                        echo -e "\e[1;3m$theme\e[0m is not a starred theme, so it cannot be removed from "\uf005\uf005\uf005
                    end
                else
                    echo -e "\e[1;3m$theme\e[0m is \e[4mnot\e[0m a valid theme name.\nCheck available theme names with the function \e[1;3mlist_themes\e[0m"
                end
            else
                echo Invalid arguments
            end
    end
end