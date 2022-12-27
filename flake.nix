{
  description = "nix-playground";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";

  outputs = inputs@{ flake-parts, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
    flake = { };
    systems = [ "x86_64-linux" "aarch64-linux" ];
    perSystem = { pkgs, lib, ... }:
    let
      makeDeb = import ./deb.nix;
      newPackages = (import ./pkgs { inherit pkgs; });
      packagesDeb = lib.attrsets.mapAttrs' (
        pkgName: pkg: lib.attrsets.nameValuePair (pkgName + "-deb") (
          makeDeb { inputPackage = pkg; stdenv = pkgs.stdenv; dpkg = pkgs.dpkg; }
        )) newPackages;
    in {
      packages = newPackages // packagesDeb;
    };
  };
}
