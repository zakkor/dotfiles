{ config, pkgs, ... }:
{
  imports = [
    ../overlays

    ./wm.nix
  ];

  # TODO: split up into more sub-files

  boot.kernelPackages = pkgs.linuxPackages_latest;

  nixpkgs.config = { allowUnfree = true; };

  time.timeZone = "Europe/Bucharest";

	console = {
		font = "Lat2-Terminus14";
		keyMap = "us";
	};
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.ed = {
    isNormalUser = true;
    home = "/home/ed";
    useDefaultShell = true;
    extraGroups = [ "wheel" "networkmanager" "video" "docker" ];
  };
  users.users.www-data = {
    isNormalUser = true;
    home = "/home/www-data";
    uid = 82;
    useDefaultShell = true;
    extraGroups = [ "wheel" "networkmanager" "video" "docker" ];
  };

  networking.networkmanager.enable = true;

  users.defaultUserShell = pkgs.bash;

  sound.enable = true;

  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
  };

  virtualisation.docker.enable = true;

  # Remap caps lock to esc
  services.interception-tools.enable = true;

  environment.systemPackages = with pkgs; [
    #DNA#
    htop
    stow
    wget
    zip
    unzip
    p7zip
    nixfmt
    google-chrome
    git
    autocutsel
    scrot
    termite
    qbittorrent
    screenfetch
    arc-theme
    arc-icon-theme
    mpv
    acme
    nodejs-12_x
    yarn
    file
    ripgrep
    slack
    xsel
    ranger
    gnumake
    pavucontrol
    firefox
    docker-compose
		calibre
    gcc
    SDL2
    dnadd

    gnome3.gnome-tweaks
    
    unstable.signal-desktop
    unstable.discord
    unstable.go
    unstable.vscode
  ];

  programs.java.enable = true;

  fonts.fonts = with pkgs; [
    # Editor font
    roboto-mono
    menlo
  ];
}
