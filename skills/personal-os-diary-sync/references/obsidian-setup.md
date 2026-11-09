# Obsidian 安装与 Vault 初始化

## 完成标准

只有以下结果都有直接证据时，才能报告 Obsidian 本地环境已经就绪：

1. Obsidian 已安装并能实际启动；
2. 正式 Vault 路径唯一且已由用户提供、确认或在全新环境中按已授权默认值创建；
3. 必需目录已经创建并回读；
4. Obsidian 能打开该 Vault；
5. 隔离测试文件能够写入、打开、回读和清理；
6. 正式 PAM 同步仍需另行通过验收，不能因以上步骤完成就声称已经同步成功。

## 检查现有环境

先只读检查：

- 系统是否为 Windows；本 Skill 的正式无人值守任务以 Windows 为目标。
- Obsidian 是否已安装、版本、可执行文件位置和启动状态。
- Obsidian 已登记或最近使用的 Vault。
- 用户给出的 Vault 路径、现有 `.obsidian` 配置和 Personal OS/Brain 目录。

发现现有 Vault 时优先复用并报告路径。不要另建平行 Vault，不要移动、合并或覆盖已有笔记。

## 缺少 Obsidian 时

下载和安装软件属于本机变更。只有用户的当前请求或安装提示词已经明确授权安装 Obsidian 时才执行；否则先申请授权。

1. 以 Obsidian 官方安装说明和下载页为准：`https://obsidian.md/help/install`、`https://obsidian.md/download`。
2. Windows 上可以使用官方安装包；若使用系统包管理器，先实时核验包名、发布者和来源，不在 Skill 中固化可能变化的包 ID。
3. 不从网盘、镜像站或不明第三方下载。
4. 安装后实际启动 Obsidian并读取可验证的版本或应用状态。
5. 下载完成但没有安装、安装完成但没有启动，必须分别报告，不合并为“已完成”。

本仓库提供 `scripts/bootstrap_obsidian.ps1`。在 Windows、用户已经授权安装且 Vault 绝对路径明确时，优先使用它执行可回读的安装与目录初始化：

```powershell
powershell -ExecutionPolicy Bypass -File scripts/bootstrap_obsidian.ps1 -VaultPath "<ABSOLUTE_VAULT_PATH>" -InstallObsidian
```

脚本会先通过 WinGet 实时核验 `Obsidian.Obsidian`，再安装、创建缺失目录、启动应用并输出 JSON。若 WinGet 不可用，回到 Obsidian 官方安装包流程。不要为了绕过系统限制而下载第三方安装包。

`-ExecutionPolicy Bypass` 只作用于这一次脚本进程，不得修改机器的持久执行策略。调用脚本前仍需遵守当前环境的权限审批。

## 创建或选择 Vault

如果用户已经给出 Vault 路径，先解析为绝对路径并确认目录位于用户授权范围内。

如果全新环境没有 Vault，安装提示词已授权创建且用户没有指定路径，可以在当前用户的 Documents 目录下提出一个清楚的默认 Vault 路径；执行前向用户显示该路径。路径有异议、存在同名目录或发现其他 Vault 时停止并请用户选择。

创建空目录后，用 Obsidian 的“打开文件夹作为仓库”将它注册为 Vault。不要手工伪造 `.obsidian` 配置来冒充已经打开。

脚本返回 `status: prepared` 只表示应用和目录准备完成。必须继续在 Obsidian 中打开该 Vault；不能把 `prepared` 报告为已经正式同步。

## 必需目录

在确认的 Vault 下创建缺失目录，不删除或覆盖同名已有内容：

```text
Personal-OS/Raw
Personal-OS/Daily
Personal-OS/Weekly
Personal-Brain/Raw
Personal-Brain/BRAIN
Personal-Brain/Weekly
04-Life/Daily
```

创建后逐一回读绝对路径和目录类型。若已有同名文件而不是目录，停止并报告冲突。

## 隔离测试

正式接入前，在 Vault 内新建明确标记为测试的临时目录或使用 `test_only: true`，验证 Markdown 文件写入、Obsidian 打开、内容回读和重复运行。不得用真实日记覆盖测试。

清理测试文件前确认目标只位于测试目录。不得删除正式 Personal OS、Personal Brain、人工日记或其他用户笔记。

## 分层报告

必须分别报告：

- Obsidian 安装包已下载；
- Obsidian 已安装；
- Obsidian 已启动；
- Vault 已创建或已选择；
- 必需目录已创建并回读；
- 隔离测试已通过；
- PAM 正式准入是否通过；
- 正式文件是否已路由并在 Obsidian 回读；
- Windows 无人值守任务是否真实运行。

没有 Obsidian 应用时，Markdown 文件写入普通目录只能报告为“Markdown 已生成”，不能报告为“Obsidian 已路由”。

