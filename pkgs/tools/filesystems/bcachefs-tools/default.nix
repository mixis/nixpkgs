{ stdenv, fetchgit, pkgconfig, attr, libuuid, libscrypt, libsodium, keyutils
, liburcu, zlib, libaio, zstd, lz4 }:

stdenv.mkDerivation rec {
  name = "bcachefs-tools-unstable-2018-12-12";

  src = fetchgit {
    url = "https://evilpiepirate.org/git/bcachefs-tools.git";
    rev = "a10a41fa2b1a917b0f3b34d20175867f968b2d12";
    sha256 = "1f8pjv7jcx8iixm326xdr6g9c4z57kiwy74f4cf5bj9rbxzad81b";
  };

  enableParallelBuilding = true;
  nativeBuildInputs = [ pkgconfig ];
  buildInputs = [ attr libuuid libscrypt libsodium keyutils liburcu zlib libaio zstd lz4 ];
  installFlags = [ "PREFIX=$(out)" ];

  preInstall = ''
    sed -i \
      "s,INITRAMFS_DIR=/etc/initramfs-tools,INITRAMFS_DIR=$out/etc/initramfs-tools,g" Makefile
  '';

  meta = with stdenv.lib; {
    description = "Tool for managing bcachefs filesystems";
    homepage = https://bcachefs.org/;
    license = licenses.gpl2;
    maintainers = with maintainers; [ davidak chiiruno ];
    platforms = platforms.linux;
  };
}
