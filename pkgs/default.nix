{ pkgs, ... }:

{
  cloak = (import ./cloak.nix) { inherit pkgs; };
  go-shadowsocks2 = (import ./go-shadowsocks2.nix) { inherit pkgs; };
  gost = (import ./gost.nix) { inherit pkgs; };
  hysteria = (import ./hysteria.nix) { inherit pkgs; };
  # litespeedtest = (import ./litespeedtest.nix) { inherit pkgs; };
  mieru = (import ./mieru.nix) { inherit pkgs; };
  # shadowsocks-libev = (import ./shadowsocks-libev.nix) { inherit pkgs; };
  shadowsocks-rust = (import ./shadowsocks-rust.nix) { inherit pkgs; };
  shadowsocks-v2ray-plugin = (import ./shadowsocks-v2ray-plugin.nix) { inherit pkgs; };
  shadowsocks-xray-plugin = (import ./shadowsocks-xray-plugin.nix) { inherit pkgs; };
  tun2socks = (import ./tun2socks.nix) { inherit pkgs; };
  v2ray-core = (import ./v2ray-core.nix) { inherit pkgs; };
  xray-core = (import ./xray-core.nix) { inherit pkgs; };
}