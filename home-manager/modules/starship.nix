{ config, lib, pkgs, ...}@inputs:
{
    programs.starship = {
        enable = true;
        enableBashIntegration = true;
        settings = {
            format = lib.concatStrings [ 
                "$username"
                "$os"
                "$hostname"
                "$localip"
                "$directory"
                "$git_branch"
                "$git_commit"
                "$git_state"
                "$git_status"
                "$line_break"
                "$python"
                "$nix_shell"
                "$character"
            ];
            #add_newline = false;

            line_break = {
                disabled = true;
            };

            character = {
                success_symbol = "[->](bold green)";
                error_symbol = "[->](bold red)";
                #success_symbol = "[>](bold green)";
                #error_symbol = "[>](bold red)";
            };

            localip = {
                disabled = true;
                ssh_only = false;
            };

            username = {
                #show_always = true;
                format = "[$user]($style)@";
            };

            hostname = {
                #ssh_only = false;
                format = "[$ssh_symbol$hostname]($style) ";
            };

            directory = {
                truncation_length = 0;
                truncate_to_repo = true;
            };

        };
    };
}
