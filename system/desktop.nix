{ lib, config, ... }:
let
  sessions = [ config.desktop.defaultSession ] ++ config.desktop.otherSessions;

  sessionConfigs = {
    xfce = {
      services.xserver = {
        enable = true;

        desktopManager = {
          xterm.enable = true;
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
  };
in
{
  config = lib.mkMerge (
    lib.mapAttrsToList (session: value: lib.mkIf (lib.elem session sessions) value) sessionConfigs
  );
}
