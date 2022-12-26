{ pkgs, ... }:

with pkgs.pkgsStatic;

rustPlatform.buildRustPackage rec {
  pname = "shadowsocks-rust";
  version = "1.15.2";

  src = fetchFromGitHub {
    owner = "shadowsocks";
    repo = "shadowsocks-rust";
    rev = "v${version}";
    sha256 = "sha256-CvAOvtC5U2njQuUjFxjnGeqhuxrCw4XI6goo1TxIhIU=";
  };

  cargoSha256 = "sha256-ctZlYo82M7GKVvrEkw/7+aH9R0MeEsyv3IKl9k4SbiA=";

  nativeBuildInputs = [ pkg-config ];
  buildFeatures = [
    "stream-cipher"
    "aead-cipher-extra"
    "aead-cipher-2022"
    "local-dns"
    "local-http-native-tls"
    "local-redir"
    "local-tun"
  ];

  OPENSSL_STATIC = "yes";
  OPENSSL_INCLUDE_DIR = "${openssl.dev}/include/";
  OPENSSL_LIB_DIR = "${lib.getLib openssl}/lib/";
  OPENSSL_NO_VENDOR = 1;

  doCheck = false;

  meta = {
    homepage = "https://github.com/shadowsocks/shadowsocks-rust";
    license = lib.licenses.mit;
  };
}