{ config, lib, pkgs, ...}@inputs:
{
    programs.gh= {
        enable = true;
        enableGitCredentialHelper = true;
        settings.editor = "nvim";
    };
}
