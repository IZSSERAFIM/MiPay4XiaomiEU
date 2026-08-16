#!/system/bin/sh
# 卸载时清理 package_cache,避免残留的国行 APK 解析结果影响系统
rm -rf /data/system/package_cache/*
