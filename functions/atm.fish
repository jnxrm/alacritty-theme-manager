# Function to manage themes in the Alacritty terminal emulator
function atm -d "alacritty-theme-manager"
    # Paths
    set -g fisher_path $__fish_config_dir
    set -g atm_path $fisher_path/functions/atm
    set -g ala_path ~/.config/alacritty
    set -g ala_themes ~/.config/alacritty/themes/themes
    if not test -d $ala_path
        echo $(mkdir $ala_path)
    end

    # All themes
    echo $(string match -gr "(.*)\.toml" $(ls $ala_themes))|read -ag themes_all

    # Starred themes
    if not test -e $ala_path/atm/themes_starred
        echo $(touch $ala_path/atm/themes_starred)
    end
    echo $(cat $ala_path/atm/themes_starred)|read -ag themes_starred

    # Light themes
    echo $(cat $atm_path/themes_light)|read -ag themes_light

    # Dark themes
    set -g themes_dark
    for theme in $themes_all
        if not contains $theme $themes_light
            set -ag themes_dark $theme
        end
    end

    # Current theme
    if not test -e $ala_path/atm/theme_current
        echo $(touch $ala_path/atm/theme_current)
        echo base16_default_dark >> $ala_path/atm/theme_current
    else
        if contains $(cat $ala_path/atm/theme_current) $themes_all
            set -g theme_current $(cat $ala_path/atm/theme_current)
        else
            set -g theme_current base16_default_dark
        end
    end

    if count $argv > /dev/null
        switch $argv[1]
            # Star
            case -s
                switch $(count $argv)
                    # Star current theme
                    case 1
                        _save_current
                    case 2
                        # List all starred themes
                        if test $argv[2] = ls
                            _list_starred
                        else if test $argv[2] = r
                            _set_random_starred_theme
                        # Star <theme>
                        else
                            _star_theme $argv[2]
                        end
                    case \*
                        echo "Option '-s' can take a maximum of 1 parameter,"
                        echo You provided $(count $argv[2..]): $(string join ", " \'$argv[2..]\')
                end
            # Unstar
            case -u
                switch $(count $argv)
                    # Unstar current theme
                    case 1
                        _unstar_current_theme
                    # Unstar <theme>
                    case 2
                        _unstar_theme $argv[2]
                    case \*
                        echo "Option '-u' can take a maximum of 1 parameter,"
                        echo You provided $(count $argv[2..]): $(string join ", " \'$argv[2..]\')
                end
            # Get info about current theme
            case -i
                switch $(count $argv)
                    case 1
                        _get_info
                    case \*
                        echo "Option '-i' does not take any arguments"
                end
            # List all themes
            case ls
                _list_all_themes
            # Change theme to <theme>
            case \*
                _change_to_theme $argv
        end
    else
        # Shuffle through a set of random themes
        _set_random_theme
    end
end

function _save_current
    if not contains $theme_current $themes_starred
        echo $theme_current >> $ala_path/atm/themes_starred
        echo -e "\e[1;3m$theme_current\e[0m successfully added to "\uf005\uf005\uf005
    else
        echo -e "\e[1;3m$theme_current\e[0m is already in "\uf005\uf005\uf005
    end
end

function _list_starred
    for theme in $themes_starred
        echo -e \uf005 "\e[1;3m$theme\e[0m"
    end
end

function _star_theme
    if contains $argv $themes_all
        if not contains $argv $themes_starred
            echo $argv >> $ala_path/atm/themes_starred
            echo -e "\e[1;3m$argv\e[0m successfully added to "\uf005\uf005\uf005
        else
            echo -e "\e[1;3m$argv\e[0m is already in "\uf005\uf005\uf005
        end
    else
        echo -e "\e[1;3m$argv\e[0m is \e[4mnot\e[0m a valid theme name.\nCheck available theme names with \e[1;3matm ls\e[0m"
    end
end

function _unstar_current_theme
    if contains $theme_current $themes_starred
        set themes_starred (string match -v $theme_current $themes_starred)
        echo -n > $ala_path/atm/themes_starred
        for theme_starred in $themes_starred
            echo $theme_starred >> $ala_path/atm/themes_starred
        end
        echo -e "Successfully removed \e[1;3m$theme_current\e[0m from "\uf005\uf005\uf005
    else
        echo -e "\e[1;3m$theme_current\e[0m is not a starred theme, so it cannot be removed from "\uf005\uf005\uf005
    end
end

function _unstar_theme
    if contains $argv $themes_all
        if contains $argv $themes_starred
            set themes_starred (string match -v $argv $themes_starred)
            echo -n > $ala_path/atm/themes_starred
            for theme_starred in $themes_starred
                echo $theme_starred >> $ala_path/atm/themes_starred
            end
            echo -e "Successfully removed \e[1;3m$argv\e[0m from "\uf005\uf005\uf005
        else
            echo -e "\e[1;3m$argv\e[0m is not a starred theme, so it cannot be removed from "\uf005\uf005\uf005
        end
    else
        echo -e "\e[1;3m$argv\e[0m is \e[4mnot\e[0m a valid theme name.\nCheck available theme names with the function \e[1;3mlist_themes\e[0m"
    end
end

function _get_info
    if contains $theme_current $themes_starred
        echo -e "Current theme: \e[1;3m$theme_current\e[0m" \uf005
    else
        echo -e "Current theme: \e[1;3m$theme_current\e[0m"
    end
end

function _list_all_themes
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
end

function _change_to_theme
    if contains $argv $themes_all
        cp $ala_themes/$argv.toml $ala_path
        mv $ala_path/$argv.toml $ala_path/atm_theme.toml
        echo -n > $ala_path/atm/theme_current
        echo $argv >> $ala_path/atm/theme_current
        if contains $argv $themes_starred
            echo -e "Current theme: \e[1;3m$argv\e[0m" \uf005
        else
            echo -e "Current theme: \e[1;3m$argv\e[0m"
        end
    else
        echo -e "\e[1;3m$argv\e[0m is \e[4mnot\e[0m a valid theme name.\nCheck available theme names with the function \e[1;3mlist_themes\e[0m"
    end
end

function _set_random_theme
    set counter 0
    while test $counter -lt 10
        set counter (math $counter + 1)
        set theme_random $(random choice $themes_dark)
        cp $ala_themes/$theme_random.toml $ala_path
        mv $ala_path/$theme_random.toml $ala_path/atm_theme.toml
        sleep 0.05
    end
    # Echo theme name in italic using escape characters
    if contains $theme_random $themes_starred
        echo -e "Theme changed to: \e[1;3m$theme_random\e[0m "\uf005
    else
        echo -e "Theme changed to: \e[1;3m$theme_random\e[0m"
    end
    echo -n > $ala_path/atm/theme_current
    echo $theme_random >> $ala_path/atm/theme_current
end

function  _set_random_starred_theme
    set counter 0
    while test $counter -lt 10
        set counter (math $counter + 1)
        set theme_random $(random choice $themes_starred)
        cp $ala_themes/$theme_random.toml $ala_path
        mv $ala_path/$theme_random.toml $ala_path/atm_theme.toml
        sleep 0.05
    end
    # Echo theme name in italic using escape characters
    echo -e "Theme changed to: \e[1;3m$theme_random\e[0m "\uf005
    echo -n > $ala_path/atm/theme_current
    echo $theme_random >> $ala_path/atm/theme_current
end