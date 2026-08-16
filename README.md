# MiPay4XiaomiEU

这是一个 KernelSU 模块，用于在各种 HyperOS 修改版中安装国行 HyperOS 的 NFC 服务

也就是 门卡 交通卡 车钥匙

注意，本应用还会恢复国行应用商店（用于更新银联组件和安装 "钱包" 应用），如果不要的话可处以直接删除 module/system/app 中的 MIUISuperMarket

二进制文件提取于小米完整更新包

## 测试环境
 - 设备：Redmi Turbo 4 Pro (onyx)
 - 系统版本: OS2.0.216.0.VOLCNXM (xiaomi.eu)
 - KernelSU版本: 32179
 - 挂载元模块: [magic_mount_rs](https://github.com/KernelSU-Modules-Repo/magic_mount_rs)

## 致谢
- [HyperOS3EULocalization](https://github.com/LSHFGJ/HyperOS3EULocalization) — 参考其路径、package_cache 清理与挂载元模块方案
