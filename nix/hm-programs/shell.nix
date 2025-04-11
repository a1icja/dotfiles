{ pkgs, inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
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

        initExtraBeforeCompInit = ''
          # zmodload zsh/zprof

          export ZINIT_HOME=$HOME/.zinit
          source ${pkgs.zinit}/share/zinit/zinit.zsh
          source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

          zinit light zsh-users/zsh-completions
          zinit light zsh-users/zsh-autosuggestions
          zinit light zsh-users/zsh-syntax-highlighting
          zinit light Aloxaf/fzf-tab
          zinit light cpitt/zsh-dotenv
        '';

        initExtra = ''
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'\n
          zstyle ':completion:*' menu no\n
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'\n
          zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'\n
          eval "$(fzf --zsh)"\n
          eval "$(zoxide init zsh)"\n

          clear

          # zprof
        '';

        envExtra = ''
          export DOCKER_USER="$UID:$GID"
          export NIXPKGS_ALLOW_UNFREE=1
        '';

        shellAliases = {
          dots = "code ~/.dotfiles";
          nsp = "nix-shell -p";
        };
      };
    };
}
