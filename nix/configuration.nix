{ config, pkgs, lib, ... }:


let
  usersFolder = lib.filter
      (n: lib.strings.hasSuffix ".nix" n)
      (lib.filesystem.listFilesRecursive ./users);
in
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./home-manager.nix
    ./graphics/nvidia.nix
    ./battery.nix
  ] ++ usersFolder;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "eniac2"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Enable flakes and nix-command
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  services.fwupd.enable = true;

  services.tailscale.enable = true;

  services.flatpak.enable = true;

  # This thing is annoying and unnecessary
  systemd.services.NetworkManager-wait-online.enable = false;


  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Ensure there's a browser available
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Global packages
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
  ];

  # Move the nix configuration out of /etc/nixos
  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "nixos-config=${config.users.users.alicja.home}/.dotfiles/nix/configuration.nix"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  system.stateVersion = "24.11";

  # Docker Config
  virtualisation.docker.enable = true;
  virtualisation.docker.daemon.settings.features.cdi = true;

  # 1password
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    # Certain features, including CLI integration and system authentication support,
    # require enabling PolKit integration on some desktop environments (e.g. Plasma).
    polkitPolicyOwners = [ "alicja" ];
  };

  # Shouldn't have to do this, but just in case
  environment.etc = {
      "1password/custom_allowed_browsers" = {
        text = ''
          firefox
        '';
        mode = "0755";
      };
    };

  networking.firewall.enable = true;
}
