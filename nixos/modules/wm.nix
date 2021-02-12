{ config, pkgs, ... }:
{
  services.xserver = {
    displayManager = {
      lightdm.enable = true;
      defaultSession = "none+bspwm";
    };
    desktopManager.xterm.enable = false;
    windowManager.bspwm.enable = true;
  };

  # Compositor
  services.picom = {
    enable = true;
    fade = true;
    shadow = true;
    fadeDelta = 4;
  };

  # Night light
  location.provider = "geoclue2";
  services.redshift.enable = true;

  # Thumbnails
  services.tumbler.enable = true;

  environment.systemPackages = with pkgs; [
    (polybar.override { pulseSupport = true; })
    rofi
    dunst
    feh
    lxappearance
    gnome3.nautilus
    gnome3.file-roller
    gnome3.eog
    gnome3.gnome-screenshot
  ];

  fonts.fonts = with pkgs; [
    # Polybar font
    roboto
    # Emoji font
    twemoji-color-font
  ];
}