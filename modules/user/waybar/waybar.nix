{ config, lib, pkgs, ... }:

{
    programs.waybar = {
        enable = true;

        settings = {
            mainBar = { 
                layer = "top";
                margin-bottom = 0;
                margin-left = 0;
                margin-right = 0;    
                spacing = 0;

                modules-left = ["custom/appmenuicon" "wlr/taskbar"];
                modules-center = ["hyprland/window"];
                modules-right = ["pulseaudio" "bluetooth" "battery" "group/hardware" "clock" "tray"];

                "custom/appmenuicon" = {
                    format = "";
                    on-click = "wlogout";
                    on-click-right = "rofi -show drun";
                    tooltip = false;
                };

                "wlr/taskbar" = {
                    format = "{icon}";
                    icon-size = 18;
                    tooltip-format = "{title}";
                    on-click = "activate";
                    on-click-middle = "close";
                    ignore-list = [
                    "kitty"
                    ];
                };

                "pulseaudio" = {
                    scroll-step = 1;
                    format = "{icon}   {volume}%";
                    format-bluetooth = "{volume}%  {icon} {format_source}";
                    format-bluetooth-muted = " {icon} {format_source}";
                    format-muted = " {format_source}";
                    format-source = "{volume}% ";
                    format-source-muted = "";
                    format-icons = {
                        headphone = " ";
                        hands-free = " ";
                        headset = " ";
                        phone = " ";
                        portable = " ";
                        car = " ";
                        default = [" " " " " "];
                    };
                    on-click = "pavucontrol";
                };

                "bluetooth" = {
                    format = " {status}";
                    format-disabled = "";
                    format-off = "";
                    interval = 30;
                    on-click = "blueman-manager";
                    format-no-controller = "";
                };

                "battery" = {
                    states = {
                        warning = 30;
                        critical = 15;
                    };
                    format = "{icon}   {capacity}%";
                    format-charging = "  {capacity}%";
                    format-plugged = "  {capacity}%";
                    format-alt = "{icon}  {time}";
                    format-icons = [" " " " " " " " " "];
                };

                "custom/system" = {
                    format = "";
                    tooltip = false;
                };

                "group/hardware" = {
                    orientation = "inherit";
                    drawer = {
                        transition-duration = 300;
                        children-class = "not-memory";
                        transition-left-to-right = false;
                    };
                    modules = [
                    "custom/system" "disk" "cpu" "memory"
                    ];
                };

                "clock" = {
                    format = "{:%H:%M %a}";
                    timezone = "America/Bogota";
                    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                    format-alt = "{:%Y-%m-%d}";
                };

                "tray" = {
                    icon-size = 21;
                    spacing = 10;
                };
            };
        };

        style = ./style.css;
    };
}
