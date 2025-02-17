{ ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.alicja =
    { pkgs, lib, ... }:
    {
      programs.ssh = let 
        onePassPath = "~/.1password/agent.sock";
      in {
        enable = true;
        extraConfig = ''
          Host *
              IdentityAgent ${onePassPath}
        '';
      };
    };
}
