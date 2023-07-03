{ config, lib, pkgs, ...}@inputs:
{
    programs.zathura = {
        enable = true;
        options = {
            font = "${inputs.theme.terminal_font} 9";
            adjust-open = "best-fit";
            default-bg = "${inputs.theme.bgcolour}";
            default-fg = "${inputs.theme.fgcolour}";

            inputbar-fg = "${inputs.theme.fgcolour}"; #04;
            inputbar-bg = "${inputs.theme.bgcolour}"; #01;

            highlight-color = "#5294E2"; #0A;
            highlight-active-color = "#6A9FB5"; #0D;

            notification-bg = "#90A959"; #0B;
            notification-fg = "#151515"; #00;

            guioptions = "v";
            recolor = true;
            recolor-darkcolor = "#dce3ed";
            recolor-lightcolor = "#282828";
            recolor-keephue = true;
            selection-clipboard = "clipboard";
        };
        
        mappings = {
            p = "navigate previous";
            n = "navigate next";
        };
    };
}
