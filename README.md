# MiPay4XiaomiEU

为 xiaomi.eu HyperOS 2 恢复国行 NFC 门卡 / 交通卡服务的 KernelSU 模块。

## 功能

恢复以下国行 NFC 组件(门卡 / 交通卡必需链路):

| 组件 | 包名 | 路径 |
| --- | --- | --- |
| 小米支付组件(智能卡服务桥) | `com.miui.nextpay` | `system/product/app/MINextpay` |
| 小米智能卡(NFC 卡片底层管理) | `com.miui.tsmclient` | `system/product/app/MITSMClient` |
| 银联 TSM 服务(公交卡付款/充值) | `com.unionpay.tsmservice.mi` | `system/product/app/UPTsmService` |

> [!NOTE]
> 本模块**不包含** `MipayWallet`(小米钱包)和 `PaymentService`(小米支付服务)。
> - `MipayWallet`:门卡/交通卡的 UI 入口,需用户在设备端自行安装。
> - `PaymentService`:仅用于 Mi Pay 银行卡闪付,本模块不需要。
> - `ro.se.type`:假设系统已开启 `eSE,HCE,UICC`,模块不重复注入。

## 安装要求

1. **KernelSU + OverlayFS MetaModule**(或其他可用的 systemless 挂载元模块)
2. xiaomi.eu HyperOS 2 ROM
3. 机型:Redmi Turbo 4 Pro(onyx)/ 小米15(onyx)

## 安装步骤

1. 在 KernelSU 管理器中刷入 `MiPay4XiaomiEU.zip`
2. **重启设备**(必须,`service.sh` 会清理 `package_cache` 让系统重新解析新 APK)
3. 在 KernelSU App Profile 中关闭以下应用的 `Umount modules`:

```text
android.uid.system
com.miui.nextpay
com.miui.tsmclient
com.unionpay.tsmservice.mi
android.uid.nfc
```

## 工作原理

- **路径对齐**:国行 HyperOS 中这些组件原位于 `product/app/`,本模块覆盖到 `system/product/app/`(对齐 [HyperOS3EULocalization](https://github.com/LSHFGJ/HyperOS3EULocalization) 的做法)。旧版塞在 `system/priv-app/` 会导致 PMS 路径解析不一致,触发 `Resources.getConfiguration()` NPE。
- **package_cache 清理**:`service.sh` 在开机时清理 `/data/system/package_cache/*`,强制 PMS 重新解析新塞入的 APK,避免 `handleBindApplication` 阶段因资源缓存过期而 NPE。
- **`customize.sh`**:使用 `SKIPUNZIP=1` + `ASH_STANDALONE=1` 控制解包与权限。

## 二进制来源

组件提取自小米官方完整更新包:
`OS2.0.216.0.VOLCNXM`(onyx / Redmi Turbo 4 Pro / 小米15)

## 致谢

- [HyperOS3EULocalization](https://github.com/LSHFGJ/HyperOS3EULocalization) — 参考其路径、package_cache 清理与挂载元模块方案
- [MiuiEULocalizationToolsBox](https://github.com/MinaMichita/MiuiEULocalizationToolsBox) — 原始工作
