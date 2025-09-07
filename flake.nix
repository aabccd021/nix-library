{
  description = "nix-library: dev environment flake templates";

  outputs = { self }: {
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
  };
}

