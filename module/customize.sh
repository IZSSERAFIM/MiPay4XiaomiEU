SKIPUNZIP=1
ASH_STANDALONE=1

print_banner() {
    ui_print ""
    ui_print "[MiPay4XiaomiEU v2.0.0]"
    ui_print "Restore CN NFC smart-card / transit card for xiaomi.eu HyperOS 2"
    ui_print ""
}

print_step() {
    ui_print "- $1"
}

print_success() {
    ui_print "  OK: $1"
}

print_warn() {
    ui_print "  ! $1"
}

print_banner

print_step "Extracting module files"
unzip -o "$ZIPFILE" -x 'META-INF/*' -d $MODPATH >/dev/null 2>&1
print_success "Files extracted"

# 设定权限:目录 0755,文件 0644
set_perm_recursive $MODPATH 0 0 0755 0644

# NFC 组件目录权限(系统应用需要 0755)
if [ -d "$MODPATH/system/product/app" ]; then
    set_perm_recursive $MODPATH/system/product/app 0 0 0755 0644
fi

# 清理安装器残留文件
rm -f $MODPATH/customize.sh $MODPATH/*.md $MODPATH/.git* $MODPATH/LICENSE 2>/dev/null

ui_print ""
ui_print "INSTALLATION COMPLETED"
ui_print "Reboot required to apply changes."
ui_print ""
ui_print "Requirements:"
ui_print "  - KernelSU with OverlayFS MetaModule (or equivalent mount metamodule)"
ui_print "  - Disable 'Umount modules' for these apps in App Profile:"
ui_print "      android.uid.system"
ui_print "      com.miui.nextpay"
ui_print "      com.miui.tsmclient"
ui_print "      com.unionpay.tsmservice.mi"
ui_print "      android.uid.nfc"
