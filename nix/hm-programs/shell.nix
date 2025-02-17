{ pkgs, ... }:
{
  imports = [
    <home-manager/nixos>
  ];

  programs.zsh.enable = true;

  users.users.alicja = {
    packages = with pkgs; [
      zinit
      zsh-powerlevel10k
    ];

    shell = pkgs.zsh;
  };

  home-manager.users.alicja =
    { pkgs, lib, ... }:
    {
      programs.fzf = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.zoxide = {
        enable = true;
        enableZshIntegration = true;
      };

      programs.zsh = {
        enable = true;

        autocd = true;

        history.size = 10000;
        history.path = "$HOME/.zsh_history";
        history.save = 10000;
        history.ignoreDups = true;

        initExtraFirst = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";

        initExtra = ''
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'\n
          zstyle ':completion:*' menu no\n
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'\n
          zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'\n
          eval "$(fzf --zsh)"\n
          eval "$(zoxide init zsh)"
        '';

        envExtra = ''
          export DOCKER_USER="$UID:$GID"
        '';

        zplug = {
          enable = true;
          plugins = [
            { name = "zsh-users/zsh-syntax-highlighting"; }
            { name = "zsh-users/zsh-completions"; }
            { name = "zsh-users/zsh-autosuggestions"; }
            { name = "Aloxaf/fzf-tab"; }
            { name = "cpitt/zsh-dotenv"; }
          ];
        };

        shellAliases = {
          nixconfig = "sudo code /etc/nixos --no-sandbox --user-data-dir ~/.vscode-root";
          nsp = "nix-shell -p";
        };
      };
    };
}
