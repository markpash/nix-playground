{ pkgs, ... }:

with pkgs.pkgsStatic;

buildGoModule rec {
  pname = "litespeedtest";
  version = "0.13.1";

  src = fetchFromGitHub {
    owner = "xxf098";
    repo = "LiteSpeedTest";
    rev = "v${version}";
    sha256 = "sha256-uyPVAyQn4iFP/WPZAdIQiKUhrfkN+CVk/o8odKRT1gI=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-csuAUEFRwz6KTCY6c4p6ePYQoPwGYu+tpLQgMUaY9Qo=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "." ];

  doCheck = false;

  meta = {
    homepage = "https://github.com/xxf098/LiteSpeedTest/";
    license = lib.licenses.mit;
  };
}