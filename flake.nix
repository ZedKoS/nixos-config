{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }:
    let
      username = "zeta";
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

      hosts = [
        (mkHost {
          hostname = "zeta-asus";
          system = "x86_64-linux";
        })
      ];

    in

    # Iterate through each host
    builtins.foldl' lib.recursiveUpdate { } (
      builtins.map (
        host@{
          hostname,
          system,
          config,
          pkgs,
          ...
        }:
        {
          nixosConfigurations.${hostname} = lib.nixosSystem {
            inherit system;

            specialArgs = {
              inherit username;
              inherit host;
            };

            modules = [
              ./system
            ];
          };

          homeConfigurations."${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = {
              inherit username;
              inherit host;
            };

            modules = [
              ./home
            ];
          };
        }
      ) hosts
    );
}
