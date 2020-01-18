{ config, pkgs, ... }:
{
  services.xserver = {
    displayManager.lightdm.enable = true;
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    windowManager.bspwm.enable = true;
  };

  # Compositor
  services.compton = {
    enable = true;
    backend = "glx";
    fade = true;
    shadow = true;
    fadeDelta = 4;
  };

  # Thumbnails
  services.tumbler.enable = true;

  environment.systemPackages = with pkgs; [
    (polybar.override { pulseSupport = true; })
    rofi
    feh
  ];

  fonts.fonts = with pkgs; [
    unstable.uw-ttyp0
  ];
}