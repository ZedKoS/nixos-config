{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpgs.follows = "nixpkgs";
    # }
  };

  # outputs = inputs @ { self, nixpkgs, home-manager, ... }: {
  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      lib = nixpkgs.lib;

      mkHost =
        {
          hostname,
          system,
          config ? { },
        }:
        rec {
          inherit hostname system config;
          pkgs = nixpkgs.legacyPackages.${system};
        };

      mkSystemConfig =
        host@{
          hostname,
          system,
          config,
          ...
        }:
        {
          ${hostname} = lib.nixosSystem {
            inherit system;

            specialArgs = { inherit host; };

            modules = [
              ./system
            ];
          };
        };

      hosts = [
        (mkHost {
          hostname = "zeta-asus";
          system = "x86_64-linux";
        })
      ];

    in
    {
      nixosConfigurations = builtins.foldl' (a: b: a // b) { } (builtins.map mkSystemConfig hosts);
    };
}
