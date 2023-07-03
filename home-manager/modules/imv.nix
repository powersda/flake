{ config, lib, pkgs, ...}@inputs:
{
    programs.imv = {
        enable = true;
        settings = {
            # Default config for imv
            options = {
                # Suppress built-in key bindings, and specify them explicitly in this
                # config file.
                # suppress_default_binds = true;
                background = "#282828";
            }; 

            aliases = {
                # Define aliases here. Any arguments passed to an alias are appended to the
                # command.
                # alias = command to run
            };
            
            binds = {
                # Define some key bindings
                q = "quit";
                y = "exec echo working!";
            
                # Image navigation
                "<Shift+H>" = " prev";
                "<Shift+K>" = " prev";
                "<Shift+J>" = " next";
                "<Shift+L> " = " next";
                "gg " = " goto 1";
                "<Shift+G> " = " goto -1";
            
                # Panning
                "k" = "pan 0 -50";
                "j" = "pan 0 50";
                "h" = "pan 50 0";
                "l" = "pan -50 0";
            
                # Zooming
                "<Up>" = "zoom 1";
                "<Shift+plus>" = "zoom 1";
                "i" = "zoom 1";
                "<Down>" = "zoom -1";
                "<minus>" = "zoom -1";
                "o" = "zoom -1";
                
                # Rotate Clockwise by 90 degrees
                "<Ctrl+r>" = "rotate by 90";
            
                # Other commands
                "x" = "close";
                "f" = "fullscreen";
                "d" = "overlay";
                "p" = "exec echo $imv_current_file";
                "c" = "center";
                "s" = "scaling next";
                "<Shift+S>" = "upscaling next";
                "a" = "zoom actual";
                "r" = "reset";
                # w = exec cp $imv_current_file $(dirname $imv_current_file)/current.png && hyprctl hyprpaper preload $imv_current_file && hyprctl hyprpaper wallpaper ,$imv_current_file
                "w" = "exec cp $imv_current_file $(dirname $imv_current_file)/current && killall swaybg && nohup swaybg -i $imv_current_file &";
                
                # Gif playback
                "<period>" = "next_frame";
                "<space>" = "toggle_playing";
            
                # Slideshow control
                "t" = "slideshow +1";
                "<Shift+T>" = "slideshow -1";
            };
        };
    };
}
