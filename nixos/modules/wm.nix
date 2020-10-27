{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager = {
			gdm.enable = true;
			defaultSession = "gnome";
		};
    desktopManager.xterm.enable = false;
    desktopManager.gnome3.enable = true;
  };

  programs.file-roller.enable = true;

  fonts.fonts = with pkgs; [
    # Polybar font
    roboto
    # Emoji font
    twemoji-color-font
  ];
}