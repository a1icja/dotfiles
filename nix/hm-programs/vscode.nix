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
        ];
        userSettings = {
          "workbench.colorTheme" = "Atomize";
          "editor.tabSize" = 2;
        };
      };
    };
}