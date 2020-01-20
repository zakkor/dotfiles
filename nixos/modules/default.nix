{ config, pkgs, ... }:
{
  imports = [
    ../overlays

    ./wm.nix
  ];

  # TODO: split up into more sub-files
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
    extraGroups = [ "wheel" "networkmanager" ];
  };

  users.defaultUserShell = pkgs.bash;

  sound.enable = true;

  hardware.pulseaudio.enable = true;

  services.xserver = {
    enable = true;
    layout = "us";
  };

  # Remap caps lock to esc
  services.interception-tools.enable = true;

  environment.systemPackages = with pkgs; [
    unstable.go
    unstable.vscode
    stow
    wget
    zip
    unzip
    nixfmt
    google-chrome
    discord
    git
    autocutsel
    scrot
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
    emacs
  ];

  fonts.fonts = with pkgs; [
    roboto-mono
    twemoji-color-font
  ];
}
