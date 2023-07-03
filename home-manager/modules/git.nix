{ config, lib, pkgs, ...}@inputs:
{
    programs.git = {
        enable = true;
        userEmail = "34976872+powersda@users.noreply.github.com";
        userName = "David Powers";
    };
}
