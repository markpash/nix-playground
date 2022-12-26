{ pkgs, ...}:

with pkgs.pkgsStatic;

buildGoModule rec {
  pname = "xray-core";
  version = "1.7.0";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${version}";
    sha256 = "sha256-aNIb90obew+tvd/rYVddK1MmUqLXSqi9xAu65BQFvk0=";
  };

  CGO_ENABLED = 0;

  vendorSha256 = "sha256-zZdUPjlul9f1jKy0Zf79KOToHIsvfgwDp6XpFPYyTzk=";

  ldflags = [ "-s" "-w" "-buildid=" ];
  subPackages = [ "main" ];

  installPhase = ''
    install -Dm555 "$GOPATH"/bin/main $out/bin/xray
  '';

  doCheck = false;

  meta = {
    homepage = "https://github.com/XTLS/Xray-core";
    license = lib.licenses.mpl20;
  };
}
