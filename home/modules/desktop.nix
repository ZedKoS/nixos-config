{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  cfg = config.desktop;
  sessions = [cfg.defaultSession] ++ cfg.otherSessions;

  mkSessionIfEnabled = session: value: lib.mkIf (lib.elem session sessions) value;
in {
  config = lib.mkMerge (lib.mapAttrsToList mkSessionIfEnabled {
    hyprland = {
      # wayland.windowManager.hyprland = {
      #   enable = true;
      #   package = null;
      # };

      # xdg.portal.configPackages = [
      #   pkgs.xdg-desktop-portal-hyprland
      #   pkgs.xdg-xdg-desktop-portal-gtk
      # ];

      home.packages = with pkgs; [
        hyprpaper
        hyprpolkitagent
      ];

      services = {
        # Wallpaper
        hyprpaper.enable = true;

        hyprpolkitagent.enable = true;

        # Day/night gamma adjustment
        wlsunset.enable = true;
      };

      programs = {
        rofi = {
          enable = true;
          plugins = [ pkgs.rofi-calc pkgs.rofi-emoji ];

          modes = ["drun" "run" "emoji" "ssh" "calc"];

          terminal = "${pkgs.kitty}/bin/kitty";
        };

        hyprlock.enable = true;
      };

      stylix.targets.rofi.enable = false;
    };

    plasma6 = {
      stylix.targets.kde.enable = false;
    };
  });
}
