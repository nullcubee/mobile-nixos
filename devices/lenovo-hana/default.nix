{
  lib,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ../families/mainline-chromeos
  ];

  mobile.device = {
    name = "lenovo-hana";
    identity = {
      name = "Chromebook C330";
      manufacturer = "Lenovo";
    };

    supportLevel = "best-effort";

    firmware = pkgs.callPackage ./firmware { };
  };

  mobile.hardware = {
    soc = "mediatek-mt8173";
    ram = (1024 * 4);
    screen = {
      width = 1366;
      height = 768;
    };
  };

  mobile.boot.stage-1 = {
    kernel.package = pkgs.callPackage ./kernel { };
    firmware = [
      config.mobile.device.firmware
    ];
  };

  mobile.system.depthcharge.kpart = {
    dtbs = "${config.mobile.boot.stage-1.kernel.package}/dtbs/mediatek";
  };

  # TODO: Not sure if this is needed
  mobile.kernel.structuredConfig = [
    (
      helpers: with helpers; {
        # Undeclared dependency needed for some
        # hid-over-i2c trackpads (e.g. acer-juniper)
        HID_RMI = yes;
        SERIO = yes;
      }
    )
  ];
}
