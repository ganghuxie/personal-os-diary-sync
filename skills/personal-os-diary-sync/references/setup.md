# Personal OS 与 Personal Brain 安装与配置

## 目标

在 Windows 上复用以下正式链路：

```text
ChatGPT Personal OS
→ Google Drive PAM-OS-RAW / PAM-OS-DAILY
→ PersonalAI-PAMDriveSync
→ PAM 正式准入
→ Obsidian Personal-OS/Raw 与 Personal-OS/Daily
→ 04-Life/Daily PAM-DAILY 区块

ChatGPT Personal Brain
→ Google Drive PAM-BRAIN-RAW / PAM-BRAIN-BRAIN
→ PersonalAI-PAMDriveSync
→ PAM 正式准入
→ Obsidian Personal-Brain/Raw 与 Personal-Brain/BRAIN
```

## 第一步：自动发现

先执行只读检查：

1. 读取 ChatGPT 项目清单，精确匹配 `Personal OS` 和用户的 Personal Brain 项目，分别取得真实 project ID。Personal Brain 的界面名称可以是 `Personal brain`，但正式元数据名称必须为 `Personal Brain`。没有、重复或无法唯一识别时停止并请用户确认。
2. 检查 Google Drive 是否已连接。若未连接，只请求完成所需登录和最小权限，不读取无关文件。
3. 搜索当前工作区、用户提供的知识库目录和 Obsidian 配置，识别正式 Vault。多个候选时请用户选择，不猜测。
4. 检查 Python、rclone、PowerShell、现有 `PAM-Drive-Sync`、状态、日志和 Windows 任务。
5. 查找同名自动化与任务。保留已有正式 `PersonalAI-PAMDriveSync`；如果存在 `PersonalAI-PAMDriveSync2`，保持禁用且不删除。发现其他旧版、重复或冲突项时只报告，暂停或修改前遵守授权边界。

## 第二步：配置 ChatGPT 项目

1. 将 `assets/personal-os-project-instructions.md` 中的安装变量替换为用户真实 Personal OS project ID，以及用户自愿提供的健康目标和背景；未提供私人健康信息时删除对应句子，不得猜测。
2. 将解析后的完整内容写入 `Personal OS` 项目说明，不得摘要或遗漏章节。
3. 将 `assets/personal-brain-project-instructions.md` 中的 project ID 替换为用户真实 Personal Brain project ID，并把完整内容写入该项目说明。
4. 写入后重新打开两个项目设置，回读项目说明，核验版本标题、项目 ID、文档类型、H1、YAML 字段、Google Docs 命名和 Obsidian 目录。

若工具无法修改项目说明，分别提供两个解析后的文件，并明确这是仅有的人工粘贴步骤；不要让用户转抄运行日志。

## 第三步：配置 Google Drive 补漏归档

使用 `references/personal-os-rules.md` 创建或修订名称为 `Personal OS Google Drive 补漏归档 V2.3` 的自动化：

- 每周一北京时间 10:00；
- 检查最近 7 个北京时间自然日，并补查最近 30 天遗漏；
- 只写 Google Drive RAW/DAILY；
- 只在明确 `收工` 后归档；
- 写前查重、原位修订、写后回读；
- 无变化且无异常时保持安静。

创建后回读状态、名称、时间、目标项目和完整提示词。旧的直接写 Vault 自动化不得重新启用。

如用户要求 Personal Brain 自动补漏归档，使用 `references/personal-brain-rules.md` 创建或修订独立的 Personal Brain 云端自动化。它只能写 PAM-BRAIN RAW/BRAIN Google Docs，不能复用 Personal OS project ID，不能直接写 Vault。创建后同样回读目标项目、完整提示词和状态。

## 第四步：配置本地 PAM

当前参考实现需要同时识别 Personal OS 与 Personal Brain 的正式元数据：

- Python 3；
- rclone 的 Google Drive remote；
- 独立 staging、lock、state、JSONL logs；
- 严格正式准入；
- 元数据路由到 `Personal-OS/Raw`、`Personal-OS/Daily`、`Personal-Brain/Raw` 和 `Personal-Brain/BRAIN`；
- DAILY 受管区块；
- 原子写入、历史版本、备份和冲突报告。

如果环境已有 PAM V2.3，优先验证和复用；不要重新生成另一套并行目录。若不存在，按 `references/local-sync.md` 实现，先在隔离测试 Vault 验收。

## 第五步：Windows 任务

正式本地任务名称固定为 `PersonalAI-PAMDriveSync`：

- 每天 02:00；
- 当前用户登录后延迟 1 分钟；
- `StartWhenAvailable=true`；
- 仅网络可用时运行；
- `IgnoreNew`，禁止并发；
- 失败每 5 分钟重试，最多 3 次；
- 调用隐藏、非交互 PowerShell 启动器。

不要启用第二个承担同一职责的正式任务。任务定义创建成功只算“已配置”；必须等待或触发一次真实运行并回读日志，才能算“无人值守已实跑”。

## 第六步：验收

按 `references/acceptance.md` 实测。测试通过后才接入正式 Vault。涉及覆盖现有个人数据、扩大权限或替换重要任务时先请求授权。


