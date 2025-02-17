{ config, pkgs, lib, ... }:

let
  hmProgramsFolder = lib.filter
      (n: lib.strings.hasSuffix ".nix" n)
      (lib.filesystem.listFilesRecursive ./hm-programs);
in
{
  imports = [
    <home-manager/nixos>
  ] ++ hmProgramsFolder;

  # Home Manager Config
  home-manager.useGlobalPkgs = true;

  home-manager.users.alicja =
    { pkgs, lib, ... }:
    {
      home.stateVersion = "24.11";
      home.packages = [ ];

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          scaling-factor = lib.hm.gvariant.mkUint32 1;
        };
      };

      programs.bash.enable = true;
    };
}
