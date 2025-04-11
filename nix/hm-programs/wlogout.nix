{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.users.alicja =
    { pkgs, lib, ... }:
    {
      programs.wlogout = {
        enable = true;

        style = ../themes/wlogout/style.css;

        layout = [
          {
              "label" = "exit";
              "action" = "";
              "text" = "Exit";
              "keybind" = "h";
          }
          {
              "label" = "shutdown";
              "action" = "systemctl poweroff";
              "text" = "Shutdown";
              "keybind" = "s";
          }
          {
              "label" = "suspend";
              "action" = "systemctl suspend-then-hibernate";
              "text" = "Suspend";
              "keybind" = "u";
          }
          {
              "label" = "lock";
              "action" = "hyprlock";
              "text" = "Lock";
              "keybind" = "l";
          }
          {
              "label" = "logout";
              "action" = "hyprctl dispatch exit";
              "text" = "Logout";
              "keybind" = "e";
          }
          {
              "label" = "reboot";
              "action" = "systemctl reboot";
              "text" = "Reboot";
              "keybind" = "r";
          }
        ];
      };
    };
}
