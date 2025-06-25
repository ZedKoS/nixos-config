{
  config,
  lib,
  pkgs,
  ...
}: let
  sessions = [config.desktop.defaultSession] ++ config.desktop.otherSessions;

  mkSessionIfEnabled = session: value: lib.mkIf (lib.elem session sessions) value;
in {
  config = lib.mkMerge (
    [
      {
        environment.systemPackages = with pkgs; [
          # Utils
          brightnessctl
          playerctl
        ];
      }
    ]
    ++ (lib.mapAttrsToList mkSessionIfEnabled {
      xfce = {
        services.xserver = {
          enable = true;

          desktopManager = {
            xterm.enable = false;
            xfce.enable = true;
          };

          xkb.layout = "us";
          xkb.variant = "intl";
        };
      };

      plasma6 = {
        services.desktopManager.plasma6.enable = true;
      };

      hyprland = {
        programs = {
          hyprland = {
            enable = true;
            xwayland.enable = true;
          };

          hyprlock.enable = true;
        };

        environment.systemPackages = with pkgs; [
          hyprpicker # color picker

          dunst # notification daemon
          waybar
          rofi # app launcher & more

          # Clipboard
          clipse
          wl-clipboard
        ];
      };
    })
  );
}
