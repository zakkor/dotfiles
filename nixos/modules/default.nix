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

  i18n = {
    consoleFont = "Lat2-Terminus14";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  users.users.ed = {
    isNormalUser = true;
    home = "/home/ed";
    useDefaultShell = true;
    extraGroups = [ "wheel" "networkmanager" "video" "docker" ];
  };

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
    #.nixos-package-append.#
    stow
    wget
    zip
    unzip
    nixfmt
    google-chrome
    discord
    git
    p7zip
    autocutsel
    scrot
    emacs
    termite
    qbittorrent
    screenfetch
    arc-theme
    arc-icon-theme
    lxappearance-gtk3
    hubstaff
    xarchiver
    mpv
    protobuf
    go-protobuf
    shotwell
    signal-desktop
    pantheon.elementary-screenshot-tool
    pcmanfm
    acme2k
    nodejs-12_x
    yarn
    file
    ripgrep
    upwork
    docker-compose
    skype
    slack
    racket
    ripgrep

    unstable.go
    unstable.vscode
  ];

  systemd.coredump.extraConfig = ''
    Compress=false
  '';

  programs.java.enable = true;

  fonts.fonts = with pkgs; [
    # Editor font
    roboto-mono
    menlo
  ];
}
