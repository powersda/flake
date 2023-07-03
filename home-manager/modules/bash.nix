{ config, lib, pkgs, ...}@inputs:
{
    programs.bash = {
        enable = true;
        enableCompletion = true;
        shellAliases = {
            clock = "tty-clock -ctC 7";
        };
        profileExtra = ''
            if [[ "$(tty)" == "/dev/tty1" ]]; then
                exec Hyprland 
            fi
        '';
    };

        
}
