{ ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.alicja =
    { pkgs, lib, ... }:
    {
      programs.git = {
        enable = true;
        userName = "Alicja Mahr";
        userEmail = "alicja@bu.edu";
        aliases = {
          ci = "commit";
          co = "checkout";
          s = "status";
        };
        extraConfig = {
          push = {
            autoSetupRemote = true;
          };

          # 1password Signing Config
          gpg = {
            format = "ssh";
          };
          "gpg \"ssh\"" = {
            program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
          };
          commit = {
            gpgsign = true;
          };
          user = {
            signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOJ65o1XQfn/DY5rnOc+Hc/mFLHHgzTZTj1k5toZ5xrD";
          };
        };
      };
    };
}
