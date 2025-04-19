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

    # hyprland = {};
  };
in
{
  config = lib.mkMerge (
    lib.mapAttrsToList (session: value: lib.mkIf (lib.elem session sessions) value) sessionConfigs
  );
}
