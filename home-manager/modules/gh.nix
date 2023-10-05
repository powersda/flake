{ config, lib, pkgs, ...}@inputs:
{
    programs.gh= {
        enable = true;
        gitCredentialHelper = true;
        settings.editor = "nvim";
    };
}
