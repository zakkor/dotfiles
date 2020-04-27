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
    dunst
    feh
    lxqt.compton-conf
  ];

  fonts.fonts = with pkgs; [
    # Polybar font
    roboto
    # Emoji font
    twemoji-color-font
  ];
}