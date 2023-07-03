{ config, lib, pkgs, ...}@inputs:
{
    programs.kitty = {
        enable = true;
        shellIntegration.enableBashIntegration = true;
        shellIntegration.mode = "no-cursor";
        font.name = "${inputs.theme.terminal_font}";
        font.size = 11;
        keybindings = {
            "kitty_mod+p" = "scroll_line_up";
            "kitty_mod+n" = "scroll_line_down";
            "kitty_mod+enter" = "new_window_with_cwd";
            "kitty_mod+j" = "next_window";
            "kitty_mod+k" = "previous_window";
        };
        settings = {
            cursor_shape = "block";
            cursor_stop_blinking_after = 0;
            mouse_hide_wait = 0;
            enabled_layouts = "vertical";
            window_padding_width = 5;
            confirm_os_window_close = 0;
            enable_audio_bell = "no";
            tab_bar_edge = "bottom";
            tab_bar_style = "powerline";
            tab_bar_separator = " | ";
            tab_powerline_style = "slanted";
            foreground = "${inputs.theme.fgcolour}";
            background = "${inputs.theme.bgcolour}";
            background_opacity = "0.8";
            color0 = "${inputs.theme.color0}";
            color8 = "${inputs.theme.color8}";
            color1 = "${inputs.theme.color1}";
            color9 = "${inputs.theme.color9}";
            color2 = "${inputs.theme.color2}";
            color10 = "${inputs.theme.color10}";
            color3 = "${inputs.theme.color3}";
            color11 = "${inputs.theme.color11}";
            color4 = "${inputs.theme.color4}";
            color12 = "${inputs.theme.color12}";
            color5 = "${inputs.theme.color5}";
            color13 = "${inputs.theme.color13}";
            color6 = "${inputs.theme.color6}";
            color14 = "${inputs.theme.color14}";
            color7 = "${inputs.theme.color7}";
            color15 = "${inputs.theme.color15}";
            update_check_interval = 0;
        };
    };
}
