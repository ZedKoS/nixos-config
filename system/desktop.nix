{ lib, config, ... }:
let
  sessions = [ config.desktop.defaultSession ] ++ config.desktop.otherSessions;

  mkSessionIfEnabled = session: value: lib.mkIf (lib.elem session sessions) value;
in
{
  config = lib.mkMerge (
    lib.mapAttrsToList mkSessionIfEnabled {
      xfce = {
        services.xserver = {
          enable = true;

          desktopManager = {
            xterm.enable = false;
            xfce.enable = true;
          };

          xkb.layout = "us";
        };
      };

      plasma6 = {
        services.desktopManager.plasma6.enable = true;

        # This only takes effect if SDDM is enabled
        services.displayManager.sddm.wayland.enable = true;
      };

      hyprland = {
        programs.hyprland = {
          enable = true;
          xwayland.enable = true;
        };

        # This only takes effect if SDDM is enabled
        services.displayManager.sddm.wayland.enable = true;
      };
    }
  );
}
