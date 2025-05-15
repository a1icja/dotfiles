{ pkgs, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.users.alicja =
    { pkgs, lib, ... }:
    {
      programs.waybar = {
        enable = true;

        style = ../themes/waybar/style.css;

        settings = {
          mainBar = {
            layer = "top";
            position = "left";
            mode = "dock";
            exclusive = true;
            passthrough = false;
            "gtk-layer-shell" = true;
            height = 864;
            width = 0;

            modules-left = [
              "clock"
              "hyprland/workspaces"
            ];
            modules-center = [
              #"hyprland/window"
            ];
            modules-right = [
              "tray"
              # "memory"
              # "cpu"
              # "network"
              "battery"
              "backlight"
              "pulseaudio"
              "pulseaudio#microphone"
            ];

            "hyprland/window" = {
              # format = "󰣇 {}";
              format = "{}";
            };

            "hyprland/workspaces" = {
              "disable-scroll" = true;
              "all-outputs" = true;
              "on-click" = "activate";
            };

            tray = {
              "icon-size" = 13;
              spacing = 10;
            };

            clock = {
              format = "{:%m\n%d\n\n%H\n%M}";
              interval = 1;
              rotate = 0;
              "tooltip-format" = "<tt>{calendar}</tt>";
              calendar = {
                mode = "month";
                "mode-mon-col" = 3;
                "on-scroll" = 1;
                "on-click-right" = "mode";
                format = {
                  months = "<span color='#a6adc8'><b>{}</b></span>";
                  weekdays = "<span color='#a6adc8'><b>{}</b></span>";
                  today = "<span color='#a6adc8'><b>{}</b></span>";
                  days = "<span color='#555869'><b>{}</b></span>";
                };
              };
            };

            backlight = {
              device = "intel_backlight";
              format = "Bri\n{percent}";
              "format-icons" = [
                "󰃞"
                "󰃟"
                "󰃠"
              ];
              "on-scroll-up" = "brightnessctl set 1%+";
              "on-scroll-down" = "brightnessctl set 1%-";
              "min-length" = 4;
            };

            battery = {
              states = {
                good = 95;
                warning = 30;
                critical = 20;
              };
              format = "Bat\n{capacity}";
              "format-charging" = "Chg\n{capacity}";
              "format-plugged" = "Plg\n{capacity}";
              "format-alt" = "{time} {icon}";
              "format-icons" = [
                "󰂃"
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰁿"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };

            pulseaudio = {
              format = "Vol\n{volume}";
              tooltip = false;
              "format-muted" = "Vol\nM";
              "on-click" = "pamixer -t";
              "on-scroll-up" = "pamixer -i 1";
              "on-scroll-down" = "pamixer -d 1";
              "scroll-step" = 5;
              "format-icons" = {
                headphone = "";
                "hands-free" = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = [
                  ""
                  ""
                  ""
                  ""
                ];
              };
            };

            "pulseaudio#microphone" = {
              format = "{format_source}";
              "format-source" = "Mic\n{volume}";
              "format-source-muted" = "Mic\nM";
              "on-click" = "pamixer --default-source -t";
              "on-scroll-up" = "pamixer --default-source -i 5";
              "on-scroll-down" = "pamixer --default-source -d 5";
              "scroll-step" = 5;
            };

            memory = {
              states = {
                c = 90; # critical
                h = 60; # high
                m = 30; # medium
              };
              interval = 10;
              format = "󰾆 {used}GB";
              "format-m" = "󰾅 {used}GB";
              "format-h" = "󰓅 {used}GB";
              "format-c" = " {used}GB";
              "format-alt" = "󰾆 {percentage}%";
              "max-length" = 10;
              tooltip = true;
              "tooltip-format" = "󰾆 {percentage}%\n {used:0.1f}GB/{total:0.1f}GB";
            };

            cpu = {
              interval = 10;
              format = "󰍛 {usage}%";
              "format-alt" = "{icon0}{icon1}{icon2}{icon3}";
              "format-icons" = [
                "▁"
                "▂"
                "▃"
                "▄"
                "▅"
                "▆"
                "▇"
                "█"
              ];
            };

            network = {
              tooltip = true;
              "format-wifi" = "  {essid}";
              "format-ethernet" = "󰈀 ";
              "tooltip-format" =
                "Network: <big><b>{essid}</b></big>\nSignal strength: <b>{signaldBm}dBm ({signalStrength}%)</b>\nFrequency: <b>{frequency}MHz</b>\nInterface: <b>{ifname}</b>\nIP: <b>{ipaddr}/{cidr}</b>\nGateway: <b>{gwaddr}</b>\nNetmask: <b>{netmask}</b>";
              "format-linked" = "󰈀 {ifname} (No IP)";
              "format-disconnected" = "󰖪 ";
              "tooltip-format-disconnected" = "Disconnected";
              "format-alt" =
                "<span foreground='#99ffdd'> {bandwidthDownBytes}</span> <span foreground='#ffcc66'> {bandwidthUpBytes}</span>";
              interval = 2;
            };
          };
        };
      };
    };
}
