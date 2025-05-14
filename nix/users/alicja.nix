{ config, pkgs, inputs, ... }:
{
  users.users.alicja = {
    isNormalUser = true;
    description = "Alicja";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    packages = with pkgs; [
      discord-canary
      slack
      gnome-tweaks
      jetbrains.datagrip
      remmina
      spotify
      nixfmt-rfc-style
      nautilus
      inputs.zen-browser.packages."${system}".default
      hyprshot
      fastfetch
      tmux
    ];
  };
}
