# 安装 Personal OS 与 Personal Brain

## 用户只需要做什么

1. 把本仓库 GitHub 链接发给 ChatGPT/Codex。
2. 发送：

```text
请按这个仓库的安装说明安装并配置 Personal OS 与 Personal Brain。把仓库中的 V2.3 和 V2.0 完整项目说明分别写入对应 ChatGPT 项目，自动读取两个真实 project ID；能自动读取的配置直接读取，只有账号授权、私人健康目标、Google Drive 连接和 Obsidian Vault 路径无法确认时再问我。完成后按仓库验收清单实测两个项目，不要把配置成功当成已同步成功。
```

3. 在系统要求时确认 GitHub 安装、Google Drive 登录和本地文件访问。

## ChatGPT/Codex 应如何处理这个链接

### 支持插件仓库安装时

1. 把用户提供的 GitHub 仓库链接添加为 marketplace source；仓库清单位于 `.agents/plugins/marketplace.json`。
2. 读取根目录 `plugin.json` 并安装 `personal-os-diary-sync`。
3. 运行 `./skills/personal-os-diary-sync/SKILL.md` 指定的 onboarding。
4. 安装后继续当前对话，不要求用户重新复制提示词。

### Codex 只有 Skill 安装能力时

1. 使用内置 `skill-installer`。
2. 从本仓库路径 `skills/personal-os-diary-sync` 安装。
3. 下一轮调用 `$personal-os-diary-sync`，继续 onboarding。

### 只能读取 GitHub、不能访问本机时

读取规则并说明当前能够完成的云端部分。不得声称已经安装 Windows 任务或写入 Obsidian。让用户在能访问本地 Vault 的 Codex/ChatGPT 桌面环境中继续，并保留当前配置结论。

## onboarding 只问必要问题

优先自动发现：

- `Personal OS` 与 Personal Brain 两个 ChatGPT 项目及各自的真实 project ID；
- 已连接的 Google Drive；
- 本机 Python、rclone、Obsidian Vault 和现有 PAM 文件；
- `PersonalAI-PAMDriveSync`、旧同名或冲突任务；
- 当前状态、日志和已通过测试。

只有无法安全确认时才询问：

- 哪个目录是正式 Obsidian Vault；
- 是否允许完成 Google Drive/rclone 登录；
- 是否允许创建或修改正式 Windows 计划任务；
- 是否填写 Personal OS 的私人健康目标和背景；
- 多个同名项目、Vault、Google Docs 或任务之间应选择哪一个。

不得让用户在 ChatGPT、Codex 和 Obsidian 之间人工复制运行反馈；能通过工具、文件和日志回读的结果由安装流程自行取得。

