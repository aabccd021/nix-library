{
  description = "nix-library: dev environment flake templates";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }@inputs: let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system;};
    m8pkgs = import ./pkgs { inherit pkgs; };
  in
  {
    templates = {
      bevy = {
        path = ./templates/bevy;
        description = "Rust / Bevy Engine development environment";
      };
    };

    packages.${system} = m8pkgs;
    defaultPackage.${system} = m8pkgs.slidev;

    apps.${system}.slidev = {
      type = "app";
      program = "${m8pkgs.slidev}/bin/slidev";
    };

    defaultApp.${system} = self.apps.${system}.slidev;

  };
}

