{
  runCommand,
  linux-firmware,
}:

# The minimum set of firmware files required for the family
runCommand "lenovo-hana-firmware"
  {
    src = linux-firmware;
    meta.license = linux-firmware.meta.license;
  }
  ''
    for firmware in \
      mediatek/mt8173/vpu_d.bin \
      mediatek/mt8173/vpu_p.bin \
      mrvl/usb8897_uapsta.bin \
      mrvl/sd8897_uapsta.bin \
      mrvl/pcie8897_uapsta.bin \
      mwlwifi/88W8897.bin \
      ath10k/QCA6174/hw3.0 \
      qca/nvm_00440302.bin \
      qca/nvm_00440302_eu.bin \
      qca/nvm_00440302_i2s_eu.bin \
      qca/rampatch_00440302.bin \
    ; do
      mkdir -p "$(dirname $out/lib/firmware/$firmware)"
      cp -vrf "$src/lib/firmware/$firmware" $out/lib/firmware/$firmware
    done
  ''
