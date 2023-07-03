{ config, lib, pkgs, ...}@inputs:
{
    programs.waybar= {
        enable = true;
        # systemd.enable = true;
        # systemd.target = "graphical.target";
        package = pkgs.waybar.overrideAttrs (oldAttrs: {
            mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
        });
        settings = {
            #// -------------------------------------------------------------------------
            #// Global configuration
            #// -------------------------------------------------------------------------

            mainBar = {
                layer = "top";

                position = "top";

                #/* "output": ["eDP-1" "HDMI-A-1"] */
                #/* "output": "eDP-1" */
                #/* "output": ["HDMI-A-1" "eDP-1"] */

                #// If height property would be not present it'd be calculated dynamically
                height = 30;

                modules-left = [
                    "wlr/workspaces"
                    "hyprland/window"
                ];

                modules-center = [
                    "custom/media"
                ];

                modules-right = [
                    "tray"
                    "custom/notifications"
                    "bluetooth"
                    # "custom/pacman"
                    # "custom/vpn"
                    "network"
                    "backlight"
                    "custom/microphone" 
                    "pulseaudio"
                    "battery"
                    "clock#date"
                    "clock#time"
                ];


                #// -------------------------------------------------------------------------
                #// Modules
                #// -------------------------------------------------------------------------

                "hyprland/window" = {
                    separate-outputs = true;
                };

                "custom/vpn" = {
                    format = "{}";
                    interval = "once";
                    exec = "[ -h \"/sys/class/net/tun0\" ] && echo ";
                    signal = 11;
                };

                "custom/media" = {
                    format = "  {}";
                    escape = true;
                    return-type = "json";
                    max-length = 40;
                    on-click = "playerctl -p spotifyd play-pause";
                    on-click-right = "playerctl -p spotifyd stop";
                    on-scroll-up = "playerctl -p spotifyd next";
                    on-scroll-down = "playerctl -p spotifyd previous";
                    exec = "~/.config/waybar/scripts/mediaplayer.py --player spotify 2> /dev/null"; #// Script in resources/custom_modules folder
                };

                "custom/microphone" = {
                    format = "{}";
                    interval = "once";
                    exec = "[[ \"$(wpctl get-volume @DEFAULT_SOURCE@)\" == *\"MUTED\"* ]] && echo  ";
                    signal = 10;
                };

                "custom/notifications" = {
                    format = "{}";
                    interval = "once";
                    exec = "[ \"$(dunstctl is-paused)\" == \"true\" ] && echo ";
                    signal = 9;
                };

                "custom/pacman" = {
                    format = "{}";
                    interval = "once";
                    exec-if = "[ ! -f \"/var/lib/pacman/db.lck\" ]";
                    exec = "yay -Qu | grep -Fcv \"[ignored]\" | sed \"s/^/  /;s/^  0$//g\"";
                    on-click = "kitty -e yay -Syu";
                    signal = 8;
                };

                "custom/mail" = {
                    format = "{}";
                    interval = "once";
                    exec = "num=\"$(find \"\$\{XDG_DATA_HOME:-$HOME/.local/share}\"/mail/*/Inbox/new -type f | wc -l 2>/dev/null)\"; [ $num != 0 ] && echo  $num";
                    signal = 7;
                };

                "battery" = {
                    interval = 10;
                    states = {
                        warning = 15;
                        critical = 5;
                    };
                    #// Connected to AC
                    format = "  {icon}   {capacity}%" ;
                    #// Not connected to AC
                    format-discharging = "{icon}   {capacity}%";
                    format-icons = [
                        ""
                        ""
                        ""
                        ""
                        ""
                    ];
                    tooltip = true;
                };

                bluetooth = {
                    format-off = "";
                    format-connected = "";
                    format-on = "";
                    tooltip-format = "{controller_alias}\t{controller_address}";
                    tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
                    tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
                };

                backlight = {
                    device = "intel_backlight";
                    format = "{icon} {percent}%";
                    format-icons = ["󰹐" "󱩎" "󱩏" "󱩐" "󱩑" "󱩒" "󱩓" "󱩔" "󱩕" "󱩖" "󰛨"];
                };

                "clock#time" = {
                    format = "{:%I:%M}";
                    tooltip = false;
                };

                "clock#date" = {
                  format = "  {:%a %b %e}"; #// Icon: calendar-alt;
                  tooltip-format = "{:%e %B %Y}";
                };

                network = {
                    interval = 5;
                    format-wifi = "  {essid} ({signalStrength}%)"; #// Icon: wifi
                    format-ethernet = "󰈀  {ipaddr}/{cidr}"; #// Icon: ethernet
                    format-disconnected = "⚠  Disconnected";
                    format-linked =  "󰈀  {ifname}"; 
                    tooltip-format = "{ifname}: {ipaddr}";
                };

                "wlr/workspaces" = {
                    all-outputs = false;
                    format = "{icon}";
                    sort-by-number = true;
                    on-click = "activate";
                    format-icons = {
                      "8" = "";
                      "9" = "󰶍";
                      "10" = "";
                    };
                };

                pulseaudio = {
                    #//"scroll-step": 1
                    format = "{icon} {volume}%";
                    format-bluetooth = "{icon} {volume}%";
                    format-muted = " Muted";
                    format-icons = {
                        headphones = "";
                        handsfree = "";
                        headset = "";
                        phone = "";
                        portable = "";
                        car = "";
                        default = ["" ""];
                    };
                };

                tray = {
                    icon-size = 21;
                    spacing = 10;
                };
            };
        };

        style = ''
            /* =============================================================================
             * Waybar configuration
             * =========================================================================== */
            
            /* -----------------------------------------------------------------------------
             * Base styles
             * -------------------------------------------------------------------------- */
            
            /* Reset all styles */
            * {
                border: none;
                border-radius: 0;
                min-height: 0;
                margin: 0;
                padding: 0;
            }
            
            /* The whole bar */
            #waybar {
                background: ${inputs.theme.bgcolour};
                color: ${inputs.theme.fgcolour};
                font-family: ${inputs.theme.font};
                font-size: 15px;
            }
            
            /* Each module */
            #custom-pacman,
            #custom-media,
            #custom-mail,
            #custom-notifications,
            #battery,
            #clock,
            #network,
            #wireplumber,
            #backlight,
            #bluetooth,
            #tray {
                padding-left: 7px;
                padding-right: 7px;
            }
            
            
            /* -----------------------------------------------------------------------------
             * Module styles
             * -------------------------------------------------------------------------- */
            
            #custom-microphone {
            }
            
            #battery {
            }
            
            #battery.warning {
                color: orange;
            }
            
            #battery.critical {
                color: red;
            }
            
            #battery.warning.discharging {
                animation-name: blink-warning;
                animation-duration: 5s;
            }
            
            #battery.critical.discharging {
                animation-name: blink-critical;
                animation-duration: 5s;
            }
            
            #clock.time {
                font-weight: bold;
            }
            #network {
                /* No styles */
            }
            
            #network.disconnected {
                color: orange;
            }
            
            #tray {
                /* No styles */
            }
            
            #workspaces button {
                border-top: 2px solid transparent;
                /* To compensate for the top border and still have vertical centering */
                padding-bottom: 2px;
                padding-left: 10px;
                padding-right: 10px;
                color: #888888;
            }
            
            #workspaces button.active{
                border-color: ${inputs.theme.hlcolour2};
                color: ${inputs.theme.fgcolour};
                background-color: ${inputs.theme.hlcolour};
            }
            
            #workspaces button.urgent {
                border-color: #c9545d;
                color: #c9545d;
            }
            #window {
                padding-left: 10px;
            }
        '';
    };
}
