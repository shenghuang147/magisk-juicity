#!/system/bin/sh

SKIPUNZIP=0
BIN_NAME="juicity-client"
MODULE_NAME="Juicity"

if [ "$BOOTMODE" != true ]; then
  abort "-----------------------------------------------------------"
  ui_print "! Please install in Magisk Manager"
  ui_print "! Install from recovery is NOT supported"
  abort "-----------------------------------------------------------"
fi

ui_print "- Setting permissions"
set_perm_recursive $MODPATH 0 0 0 0644
set_perm_recursive /data/adb/${MODULE_NAME}/ 0 0 0 0644
set_perm $MODPATH/${BIN_NAME} 0 0 0755
set_perm $MODPATH/juicity.init 0 0 0755
set_perm $MODPATH/service.sh 0 0 0755
set_perm $MODPATH/uninstall.sh 0 0 0755

if [ -d "/data/adb/${MODULE_NAME}" ]; then
  ui_print "- Backup Juicity"
  temp_bak=$(mktemp -d "/data/adb/${MODULE_NAME}/${MODULE_NAME}_backup.XXXXXXXXXX")
  temp_dir="${temp_bak}"
  # backup modules
  mv /data/adb/${MODULE_NAME}/* "${temp_dir}/"
  # install modules
  mv "$MODPATH/${MODULE_NAME}/"* /data/adb/${MODULE_NAME}/
  backup_juicity="true"
else
  mv "$MODPATH/${MODULE_NAME}" /data/adb/${MODULE_NAME}
fi

ui_print "- Create directories"
mkdir -p /data/adb/${MODULE_NAME}/run

if [ "${backup_juicity}" = "true" ]; then
  ui_print "- Restore configuration juicity"
  config_name="config.json"
  if [ -f "${temp_dir}/${config_name}" ]; then
    cp -f "${temp_dir}/${config_name}" "/data/adb/${MODULE_NAME}/${config_name}"
  fi

  ui_print "- Restore logs"
  cp "${temp_dir}/run/"* "/data/adb/${MODULE_NAME}/run/"
fi

ui_print "- Delete leftover files"
rm -rf $MODPATH/${MODULE_NAME}
rm -rf ${temp_dir}

ui_print "- Installation is complete, reboot your device"

