{...}:{
  imports = [
    <home-manager/nixos>
  ];

  home-manager.users.alicja =
    { pkgs, lib, ... }:
    {
      programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
          emroussel.atomize-atom-one-dark-theme
          jnoortheen.nix-ide
          github.copilot
          ms-azuretools.vscode-docker
          prisma.prisma
          esbenp.prettier-vscode
        ];
        userSettings = {
          "workbench.colorTheme" = "Atomize";
          "editor.tabSize" = 2;
          "[typescript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
        };
      };
    };
}