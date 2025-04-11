{ pkgs, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira-code-nerdfont
    ];
  };

  users.users.alicja = {
    packages = with pkgs; [
      alacritty-theme
    ];
  };

  home-manager.users.alicja =
    { pkgs, lib, ... }:
    {
      programs.alacritty = {
        enable = true;
        settings = {
          general.import = [ "${pkgs.alacritty-theme}/one_dark.toml" ];
          font = {
            normal.family = "FiraCode Nerd Font Mono";
          };
          window ={
            opacity = 0.85;
          };
          env = {
            TERM = "xterm-256color";
          };
          keyboard.bindings = [
            { key = "Right"; mods = "Alt"; chars = "\\u001BF"; }
            { key = "Left";  mods = "Alt"; chars = "\\u001BB"; }
          ];
        };
      };
    };
}
