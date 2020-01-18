{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sdb";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "mescal";

  services.xserver.videoDrivers = [ "nvidia" ];

  # 120Hz
  services.xserver.monitorSection = "VertRefresh 120.00";
  services.xserver.exportConfiguration = true;
  services.xserver.displayManager.sessionCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 3440x1440 --rate 120.00
  '';

  services.compton.refreshRate = 120;

  system.stateVersion = "19.09";
}