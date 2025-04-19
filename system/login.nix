{ config, lib, ... }:
let
  displayManager = config.desktop.displayManager;

  displayManagers = {
    ly = {
      services.displayManager = {
        ly.enable = true;

        ly.settings = {
          animation = "matrix";
          box_title = "Box Title Test";
          vi_mode = true;
          vi_default = "insert";
        };

        defaultSession = config.desktop.defaultSession;
      };
    };
  };
in
{
  config = lib.mkMerge (
    lib.mapAttrsToList (dm: value: lib.mkIf (dm == displayManager) value) displayManagers
  );
}
