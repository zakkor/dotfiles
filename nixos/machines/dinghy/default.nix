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
	networking.networkmanager.enable = true;

  # Touch pad and trackpoint
	hardware.brightnessctl.enable = true;
	hardware.trackpoint.enable = true;
	hardware.trackpoint.sensitivity = 80;
	hardware.trackpoint.emulateWheel = true;
	services.xserver.libinput.enable = true;

	system.stateVersion = "19.09";
}