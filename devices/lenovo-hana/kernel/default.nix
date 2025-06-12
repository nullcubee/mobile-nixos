{
  mobile-nixos,
  fetchurl,
  ...
}:

mobile-nixos.kernel-builder {
  version = "6.12.33";
  configfile = ./config.aarch64;

  src = fetchurl {
    url = "https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-6.12.33.tar.xz";
    hash = "sha256-wKV1Yw8mA6ILsGQfjfj5VeRsnXrB+ui1SyExbmtSolQ=";
  };

  patches = [
    ./mt8173-fix-mmc-order.patch
    ./mt8173-fix-mmc1-speed.patch
    ./mt8173-higher-temps.patch
  ];

  isModular = true;
  isCompressed = false;
}
