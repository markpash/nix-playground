{
  description = "nix-playground";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/master";
  inputs.flake-parts.url = "github:hercules-ci/flake-parts";

  outputs = inputs@{ flake-parts, ... }: flake-parts.lib.mkFlake { inherit inputs; } {
    flake = { };
    systems = [ "x86_64-linux" "aarch64-linux" ];
    perSystem = { pkgs, ... }: {
      packages = {
        cloak = (import ./pkgs/cloak.nix) { inherit pkgs; };
        go-shadowsocks2 = (import ./pkgs/go-shadowsocks2.nix) { inherit pkgs; };
        gost = (import ./pkgs/gost.nix) { inherit pkgs; };
        hysteria = (import ./pkgs/hysteria.nix) { inherit pkgs; };
        litespeedtest = (import ./pkgs/litespeedtest.nix) { inherit pkgs; };
        mieru = (import ./pkgs/mieru.nix) { inherit pkgs; };
        shadowsocks-libev = (import ./pkgs/shadowsocks-libev.nix) { inherit pkgs; };
        shadowsocks-rust = (import ./pkgs/shadowsocks-rust.nix) { inherit pkgs; };
        shadowsocks-v2ray-plugin = (import ./pkgs/shadowsocks-v2ray-plugin.nix) { inherit pkgs; };
        shadowsocks-xray-plugin = (import ./pkgs/shadowsocks-xray-plugin.nix) { inherit pkgs; };
        tun2socks = (import ./pkgs/tun2socks.nix) { inherit pkgs; };
        v2ray-core = (import ./pkgs/v2ray-core.nix) { inherit pkgs; };
        xray-core = (import ./pkgs/xray-core.nix) { inherit pkgs; };
      };
    };
  };
}
