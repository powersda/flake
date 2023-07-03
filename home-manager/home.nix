{ config, lib, pkgs, ... }@inputs: 
{
    imports = [
        ./modules/bash.nix
        ./modules/kitty.nix
        ./modules/starship.nix
        ./modules/waybar.nix
        ./modules/dunst.nix
        ./modules/cava.nix
        ./modules/imv.nix
        ./modules/zathura.nix
        ./modules/hyprland.nix
        ./modules/git.nix
        ./modules/gh.nix
    ];

    xdg = {
        enable = true;
        userDirs.enable = true;
        # userDirs.createDirectories = true;
        userDirs.desktop = "$HOME";
        userDirs.documents = "$HOME";
        userDirs.download = "$HOME/downloads";
        userDirs.music = "$HOME/music";
        userDirs.pictures = "$HOME/pictures";
        userDirs.videos = "$HOME/videos";
        userDirs.templates = "$HOME/templates";
        userDirs.publicShare = "$HOME/public";
    };

    home = { 
        username = "pwrhs"; 
        homeDirectory = "/home/pwrhs";
        stateVersion = "23.05";
            sessionVariables = {
            EDITOR = "nvim";
            BEMENU_OPTS = "-i -p '' -H 30 --fn '${inputs.theme.font}' --tb ${inputs.theme.bgcolour} --tf ${inputs.theme.fgcolour} --fb ${inputs.theme.bgcolour} --ff ${inputs.theme.fgcolour} --hf ${inputs.theme.fgcolour} --hb ${inputs.theme.hlcolour} --nb ${inputs.theme.bgcolour} --nf ${inputs.theme.fgcolour} --ab ${inputs.theme.bgcolour} --af ${inputs.theme.fgcolour}";
        };

        packages = with pkgs; [ 
            # DESKTOP
            bemenu 
            swaybg
            libnotify
            xdg-utils
            swaylock-effects
            grim
            slurp
            wl-clipboard

            # GUI
            firefox
            thunderbird
            discord
            spotify
            obsidian

            # TERMINAL
            playerctl
            neofetch
            cmus
            cava
            tty-clock
            cmatrix
            cbonsai
        ];
    };

    programs = { 
        # DESKTOP
        waybar.enable = true;

        # GUI
        zathura.enable = true;
        imv.enable = true;
        mpv.enable = true;

        # TERMINAL
        bash.enable = true;
        kitty.enable = true;
        starship.enable = true;
        git.enable = true;
        neovim.enable = true;
        gh.enable = true;
    };

    services = {
        dunst.enable = true;
    };
}
