{
  description = "nix-library: packages and dev flake template collection";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
  let
    systems = [ "x86_64-linux" "aarch64-linux" ];
    defaultSystem = "x86_64-linux";
    forAllSystems = f: builtins.listToAttrs (map (system: {
      name = system;
      value = f system;
    }) systems);
    pkgsBySystem = forAllSystems (system:
      import ./pkgs/all-packages.nix {
        pkgs = import nixpkgs { inherit system; };
      }
    );
  in
  {
    m8pkgs = pkgsBySystem.${defaultSystem};

    templates = {
      bevy = {
        path = ./templates/bevy;
        description = "Rust / Bevy Engine development environment";
      };
    };
  };
}

