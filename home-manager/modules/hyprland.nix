{ config, lib, pkgs, ...}@inputs:
{
    xdg.configFile.hyprland = {
        enable = true;
        target = "hypr/hyprland.conf";
        text = ''
            # For a full list, see the wiki
            #
            
            # See https://wiki.hyprland.org/Configuring/Monitors/
            #
            # monitor = HDMI-A-1, 1920x1080, 0x0, 1, mirror, eDP-1
            # monitor = eDP-1, preferred, 0x1440, 1
            # monitor = HDMI-A-1, preferred, 0x0, 1
            # monitor = HDMI-A-1, 1920x1080@60, 0x0, 1, mirror, eDP-1
            monitor = , preferred, auto, 1
            
            # bindl = ,switch:on:Lid Switch, exec, hyprctl keyword monitor eDP-1, disable
            # bindl = ,switch:off:Lid Switch, exec, hyprctl keyword monitor eDP-1, preferred, auto, 1
            # bindl = , switch:off:Lid Switch, exec, killall -SIGUSR2 waybar 
            
            # See https://wiki.hyprland.org/Configuring/Keywords/ for more
            
            exec-once = [workspace special silent] kitty
            exec-once = waybar & swaybg -i /home/pwrhs/wallpapers/current --mode fill
            exec-once = hyprctl setcursor Dracula-cursors 16
            
            # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
            input {
                kb_layout = us
                kb_variant =
                kb_model =
                kb_options =
                kb_rules =
            
                follow_mouse = 1
                accel_profile = flat 
                # force_no_accel = true
                sensitivity = 0.7 
                # scroll_button = 274
                # scroll_method = edge
            
                touchpad {
                    natural_scroll = yes
                    scroll_factor = 0.7 
                }
            
            }
            
            device:logitech-pro-x-wireless {
                # scroll_method = on_button_down
            }
            
            $gaps_in = 5 
            $gaps_out = 20
            general {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
            
                gaps_in = $gaps_in 
                gaps_out = $gaps_out
                border_size = 2
                col.active_border = rgba(${lib.strings.removePrefix "#" inputs.theme.hlcolour3}EE)
                col.inactive_border = rgba(${lib.strings.removePrefix "#" inputs.theme.bgcolour}AA)
                layout = dwindle
                # no_border_on_floating = true
                # sensitivity = 0.5
            }
            
            misc {
                disable_hyprland_logo = true
                enable_swallow = true
                swallow_regex = ^(kitty)$
                vfr = true
            }
            
            $rounding = 7
            decoration {
                # See https://wiki.hyprland.org/Configuring/Variables/ for more
            
                rounding = $rounding
            
                drop_shadow = true
                shadow_range = 6
                shadow_render_power = 3
                col.shadow = rgba(1a1a1aee)
            
                dim_inactive = true
                dim_strength = 0.15

                blur {
                    enabled = true
                    size = 5
                    passes = 1
                    ignore_opacity = false
                    new_optimizations = true
                }
            }
            
            animations {
                enabled = yes
            
                # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
            
                bezier = myBezier, 0.05, 0.9, 0.1, 1.00
            
                animation = windows, 1, 3, myBezier
                animation = windowsOut, 1, 8, default, popin 75%
                animation = border, 1, 10, default
                animation = fade, 1, 5, default
                animation = workspaces, 1, 3, default
                animation = specialWorkspace, 1, 9, myBezier, fade
            }
            
            dwindle {
                # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
                # pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
                preserve_split = true # you probably want this
                force_split = 2
                special_scale_factor = 0.7
            }
            
            binds {
                # workspace_back_and_forth = true
                allow_workspace_cycles = true
            }
            
            # Window Rules
            windowrulev2 = tile, class:^(Sxiv)$
            windowrulev2 = workspace 8, class:^(obsidian)$
            windowrulev2 = workspace 9, class:^(thunderbird)$
            windowrulev2 = opacity 1.0, class:^(thunderbird)$
            windowrulev2 = float, class:^(thunderbird)$, title:^(Write:)
            windowrulev2 = workspace 10, class:^(discord)$
            windowrulev2 = workspace 10, class:^("Microsoft Teams - Preview")$
            windowrulev2 = workspace 10, class:^(Slack)$
            
            #Binds
            $mainMod = SUPER
            
            bind = $mainMod, p, exec, hyprctl keyword monitor eDP-1, disable
            # bind = , switch:Lid Switch,  exec, hyprctl keyword monitor eDP-1, preferred, 0x1440, 1
            bind = $mainMod_SHIFT, p, exec, hyprctl keyword monitor eDP-1, preferred, auto, 1
            
            bind = $mainMod_SHIFT, q, killactive, 
            
            bind = $mainMod_SHIFT, q, killactive, 
            bind = $mainMod_CTRL_SHIFT, q, exit, 
            bind = $mainMod_CTRL_SHIFT, r, forcerendererreload, 
            bind = $mainMod, v, togglefloating, 
            bind = $mainMod, s, exec, GRIM_DEFAULT_DIR=~/screenshots/ grim && notify-send "Screenshot Taken!"
            bind = $mainMod_SHIFT, s, exec, (slurp | xargs -I % grim -g % - | wl-copy) && [[ "$(wl-paste)" ]] && notify-send "Screensnip sent to clipboard!"
            bind = $mainMod, semicolon, exec, swaylock --screenshots --effect-blur 7x5 --fade-in 0.2 -u
            # bind = $mainMod, o, pseudo, # dwindle
            bind = $mainMod, t, togglesplit, # dwindle
            # bind = $mainMod, y, togglegroup
            #
            # Launch Shortcuts
            bind = $mainMod, return, exec, kitty
            bind = , print, exec, kitty
            bind = $mainMod, d, exec, bemenu-run -p "Run:"
            bind = $mainMod, c, exec, ~/.local/bin/vpn_select &> /dev/null && pkill -SIGRTMIN+11 waybar &> /home/pwrhs/TEST
            bind = $mainMod, k, exec, ~/.local/bin/vm_select & /dev/null 
            
            # Monitors
            bind = $mainMod, period, focusmonitor, +1
            bind = $mainMod, comma, focusmonitor, -1
            bind = $mainMod_SHIFT, period, movewindow, mon:+1
            bind = $mainMod_SHIFT, comma, movewindow, mon:-1 
            bind = $mainMod_SHIFT, slash, swapactiveworkspaces, 0 1
            
            # Notifications
            bind = $mainMod, n, exec, dunstctl set-paused toggle && pkill -SIGRTMIN+9 waybar
            bind = $mainMod, space, exec, dunstctl close-all
            
            # Waybar
            bind = $mainMod, b, exec, killall -SIGUSR1 waybar
            bind = $mainMod_SHIFT, b, exec, killall -SIGUSR2 waybar
            
            # Gaps
            bind = $mainMod_CTRL, j, exec, hyprctl keyword general:gaps_out 0 && hyprctl keyword general:gaps_in 0 && hyprctl keyword decoration:rounding 0
            bind = $mainMod_CTRL, k, exec, hyprctl keyword general:gaps_out $gaps_out && hyprctl keyword general:gaps_in $gaps_in && hyprctl keyword decoration:rounding $rounding
            
            # Move focus with mainMod + arrow keys
            bind = $mainMod, h, movefocus, l
            bind = $mainMod, l, movefocus, r
            bind = $mainMod, k, movefocus, u
            bind = $mainMod, j, movefocus, d
            
            # Move window 
            bind = $mainMod_SHIFT, h, movewindow, l
            bind = $mainMod_SHIFT, l, movewindow, r
            bind = $mainMod_SHIFT, k, movewindow, u
            bind = $mainMod_SHIFT, j, movewindow, d
            
            # Resize window
            binde = $mainMod_CTRL, l, splitratio, +0.25 
            binde = $mainMod_CTRL, h, splitratio, -0.25 
            
            # Scratchpad
            bind = $mainMod, grave, togglespecialworkspace
            
            # Switch workspaces with mainMod + [0-9]
            bind = $mainMod, 1, workspace, 1
            bind = $mainMod, 2, workspace, 2
            bind = $mainMod, 3, workspace, 3
            bind = $mainMod, 4, workspace, 4
            bind = $mainMod, 5, workspace, 5
            bind = $mainMod, 6, workspace, 6
            bind = $mainMod, 7, workspace, 7
            bind = $mainMod, 8, workspace, 8
            bind = $mainMod, 9, workspace, 9
            bind = $mainMod, 0, workspace, 10
            bind = $mainMod, tab, workspace, previous
            
            # Move active window to a workspace with mainMod + SHIFT + [0-9]
            bind = $mainMod_SHIFT, 1, movetoworkspace, 1
            bind = $mainMod_SHIFT, 2, movetoworkspace, 2
            bind = $mainMod_SHIFT, 3, movetoworkspace, 3
            bind = $mainMod_SHIFT, 4, movetoworkspace, 4
            bind = $mainMod_SHIFT, 5, movetoworkspace, 5
            bind = $mainMod_SHIFT, 6, movetoworkspace, 6
            bind = $mainMod_SHIFT, 7, movetoworkspace, 7
            bind = $mainMod_SHIFT, 8, movetoworkspace, 8
            bind = $mainMod_SHIFT, 9, movetoworkspace, 9
            bind = $mainMod_SHIFT, 0, movetoworkspace, 10
            bind = $mainMod_SHIFT, grave, movetoworkspace, special
            
            # Move/resize windows with mainMod + LMB/RMB and dragging
            bindm = $mainMod, mouse:272, movewindow
            bindm = $mainMod, mouse:273, resizewindow
            
            # Fullscreen
            bind = $mainMod, f, fullscreen, 0
            bind = $mainMod_SHIFT, f, fakefullscreen, 
            
            # Function Keys
            bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_SINK@ toggle
            bind = , XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_SOURCE@ toggle && pkill -SIGRTMIN+10 waybar
            bind = , XF86AudioRaiseVolume, exec, test $(wpctl get-volume @DEFAULT_SINK@ | sed -e 's/[^0-9]//g;s/^00\?//g') -lt 100 && wpctl set-volume @DEFAULT_SINK@ 0.05+
            #bind = , XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05+ 
            bind = , XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_SINK@ 0.05-
            bind = , XF86MonBrightnessDown, exec, light -U 2
            bind = , XF86MonBrightnessUp, exec, light -A 2
            
            # Media Keys
            bind = CTRL, XF86AudioMute, exec, playerctl -a play-pause
            bind = CTRL, XF86AudioLowerVolume, exec, playerctl -a stop
            bind = CTRL, XF86AudioRaiseVolume, exec, playerctl -a previous
            bind = CTRL, XF86AudioMicMute, exec, playerctl -a next
            bind = , XF86AudioPlay, exec, playerctl -a play-pause
            bind = , XF86AudioPrev, exec, playerctl -a previous
            bind = , XF86AudioNext, exec, playerctl -a next
        '';
    };
}
