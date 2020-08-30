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
    lxappearance-gtk3
    hubstaff
    xarchiver
    mpv
    protobuf
    go-protobuf
    shotwell
    pantheon.elementary-screenshot-tool
    pcmanfm
    acme
    nodejs-12_x
    yarn
    file
    ripgrep
    upwork
    skype
    slack
    kakoune
    xsel
    ranger
    gnumake
    pavucontrol
    firefox
    elixir
    docker-compose
		calibre
    
    unstable.discord
    unstable.go
    unstable.vscode
  ];

  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "ed" ];

  systemd.coredump.extraConfig = ''
    Compress=false
  '';

  networking.extraHosts = ''
    127.0.0.1 example.com
    127.0.0.1 robots.example.com
    127.0.0.1 projects.example.com
    127.0.0.1 arrival.example.com
  '';

  programs.java.enable = true;

  fonts.fonts = with pkgs; [
    # Editor font
    roboto-mono
    menlo
  ];
}
