#!/system/bin/sh
MODDIR=${0%/*}

# 清理 package_cache,强制 PMS 重新解析新塞入的 NFC APK
# 不清缓存时系统会沿用旧的(不含国行 APK 的)解析结果,
# 导致 handleBindApplication 阶段 Resources 为 null 而 NPE
rm -rf /data/system/package_cache/*

# 触发一次 package_cache 重建,避免首次重启后相关应用启动时拿不到缓存
# (PMS 会在下次扫描时自动重建,这里只是清空旧的)
