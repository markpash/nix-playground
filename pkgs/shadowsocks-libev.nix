{ pkgs, ... }:

with pkgs.pkgsStatic;

stdenv.mkDerivation rec {
  pname = "shadowsocks-libev";
  version = "3.3.5";

  src = fetchFromGitHub {
    owner = "shadowsocks";
    repo = "shadowsocks-libev";
    rev = "refs/tags/v${version}";
    sha256 = "1iqpmhxk354db1x08axg6wrdy9p9a4mz0h9351i3mf3pqd1v6fdw";
    fetchSubmodules = true;
  };

  buildInputs = [
    libsodium
    mbedtls_2
    libev
    c-ares
    pcre
  ];

  nativeBuildInputs = with pkgs; [
    cmake
    asciidoc
    xmlto
    docbook_xml_dtd_45
    docbook_xsl
    libxslt
  ];

  cmakeFlags = [
    "-DWITH_STATIC=ON"
    "-DWITH_EMBEDDED_SRC=OFF"
    "-DCMAKE_BUILD_WITH_INSTALL_NAME_DIR=ON"
    "-DCMAKE_SKIP_BUILD_RPATH=ON"
  ];

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace '# pkg-config' \
                '# pkg-config
                 include(GNUInstallDirs)'
    substituteInPlace cmake/shadowsocks-libev.pc.cmake \
      --replace @prefix@ @CMAKE_INSTALL_PREFIX@ \
      --replace '$'{prefix}/@CMAKE_INSTALL_BINDIR@ @CMAKE_INSTALL_FULL_BINDIR@ \
      --replace '$'{exec_prefix}/@CMAKE_INSTALL_FULL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@ \
      --replace '$'{prefix}/@CMAKE_INSTALL_INCLUDEDIR@ @CMAKE_INSTALL_FULL_INCLUDEDIR@ \
      --replace '$'{prefix}/@CMAKE_INSTALL_DATAROOTDIR@ @CMAKE_INSTALL_FULL_DATAROOTDIR@ \
      --replace '$'{prefix}/@CMAKE_INSTALL_MANDIR@ @CMAKE_INSTALL_FULL_MANDIR@
    substituteInPlace libcork/src/libcork.pc.in \
      --replace '$'{exec_prefix}/@CMAKE_INSTALL_LIBDIR@ @CMAKE_INSTALL_FULL_LIBDIR@ \
      --replace '$'{prefix}/@CMAKE_INSTALL_INCLUDEDIR@ @CMAKE_INSTALL_FULL_INCLUDEDIR@
  '';

  postInstall = ''
    cp lib/* $out/lib
  '';

  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/shadowsocks/shadowsocks-libev";
    license = licenses.gpl3Plus;
  };
}