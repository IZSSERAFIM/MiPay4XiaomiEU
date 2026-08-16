# MiPay4XiaomiEU

这是一个 KernelSU 模块，用于在各种 HyperOS 修改版中安装国行 HyperOS 的 NFC 服务

也就是 门卡 交通卡 车钥匙

每次 Release 会发布两个版本:
- **MiPay4XiaomiEU-lite.zip** — 仅含 NFC 门卡/交通卡组件(MINextpay / MITSMClient / UPTsmService)
- **MiPay4XiaomiEU-full.zip** — 在 lite 基础上额外包含国行应用商店 MIUISuperMarket(用于更新银联组件和安装"钱包"应用),不需要可直接删除 `module/system/app/MIUISuperMarket` 或使用 lite 版本

二进制文件提取于小米完整更新包

## 测试环境
 - 设备：Redmi Turbo 4 Pro (onyx)
 - 系统版本: OS2.0.216.0.VOLCNXM (xiaomi.eu)
 - KernelSU版本: 32179
 - 挂载元模块: [magic_mount_rs](https://github.com/KernelSU-Modules-Repo/magic_mount_rs)

## 使用说明
- 在 KernelSU 中关闭默认卸载模块，或在 `android.uid.nfc` 的 App Profile 中关闭"卸载模块"，否则 NFC 组件不会加载。
- 如需双击电源键唤起小米智能卡，在 Scene 附加模块的 `service.sh` 中写入以下内容（代码源于酷安 @NERV2233）：

```sh
#!/system/bin/sh

MODDIR=${0%/*}

until [ "$(getprop sys.boot_completed)" = "1" ]; do
    sleep 1
done

sleep 2

# 开启双击电源键唤起刷卡页
settings put system double_click_power_key mi_pay

# ==========================================
# 滚动日志：保留最近 2 次启动记录
# - tsm_old.log = 上一次的日志(被挤掉)
# - tsm_new.log = 本次启动日志
# ==========================================
LOG_DIR="/data/local/tmp"
# 把当前的新日志"降级"为旧日志(如果存在的话)
[ -f "$LOG_DIR/tsm_new.log" ] && mv -f "$LOG_DIR/tsm_new.log" "$LOG_DIR/tsm_old.log"
# 写入本次新日志
echo "=== $(date) ===" > "$LOG_DIR/tsm_new.log"
echo "double_click_power_key = $(settings get system double_click_power_key)" >> "$LOG_DIR/tsm_new.log"
echo "exit_code = $?" >> "$LOG_DIR/tsm_new.log"
```

## 致谢
- [ReiAccept/MiPay4XiaomiEU](https://github.com/ReiAccept/MiPay4XiaomiEU) — 本项目 fork 自该仓库
- 酷安 @NERV2233 — 双击电源键唤起小米智能卡的 service.sh 脚本
