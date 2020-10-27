{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../modules
  ];

  # Boot
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "dinghy";

  # Touch pad and trackpoint
  services.xserver.libinput.enable = true;
  hardware.trackpoint.enable = true;
  hardware.trackpoint.sensitivity = 80;
  hardware.trackpoint.emulateWheel = true;

  # Allow video group to access backlight, so we can change the brightness from Polybar
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';

  system.stateVersion = "19.09";
}