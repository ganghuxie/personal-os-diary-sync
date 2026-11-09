# 安装 Personal OS 与 Personal Brain

## 用户只需要做什么

1. 打开 ChatGPT 左侧边栏，在“项目”右侧点击 `+`（或点击“新建项目”）。
2. 创建第一个空项目，名称为 `Personal OS`，记忆设置保持默认。
3. 再次点击 `+`，创建第二个空项目，名称为 `Personal Brain`。
4. 确认两个项目都出现在左侧边栏，不要把两套规则放进同一个项目。
5. 打开 ChatGPT 桌面版的新窗口或新聊天，在顶部选择“工作”。如果系统提供本地与云端选择，使用能够访问这台 Windows 电脑的本地工作方式。
6. 把本仓库 GitHub 链接发给这个工作模式聊天。
7. 发送：

```text
请按这个仓库的安装说明安装并配置 Personal OS 与 Personal Brain。先检查我是否已创建这两个 ChatGPT 项目；缺少时引导我创建。把仓库中的 Personal OS V2.3 和 Personal Brain V2.0 完整项目说明分别写入对应项目，并读取两个真实 project ID。检查这台 Windows 电脑是否已安装 Obsidian；如果没有，我授权你从 Obsidian 官方来源下载安装，并在执行前告诉我安装来源和默认 Vault 路径；如果我没有提出异议，继续创建 Vault 及仓库规定的 Personal OS、Personal Brain 和日记目录。能自动读取的配置直接读取，只有账号授权、Google Drive 连接、Vault 路径冲突、已有个人数据可能被覆盖或重要系统修改无法确认时再问我。完成后按仓库验收清单实测两个项目，不要把软件已安装、规则已配置或文件夹已创建当成同步已经跑通。
```

8. 在系统要求时确认 GitHub 安装、Google Drive 登录、本地文件访问和 Obsidian 安装。

## Obsidian 尚未安装时

安装流程必须先检查，不重复安装。确认缺失后：

1. 只使用 Obsidian 官方下载页或经核验的系统包管理器来源；
2. 安装完成后实际启动 Obsidian；
3. 创建或选择 Vault，已有 Vault 时优先复用，不静默另建；
4. 创建 `Personal-OS/Raw`、`Personal-OS/Daily`、`Personal-OS/Weekly`、`Personal-Brain/Raw`、`Personal-Brain/BRAIN`、`Personal-Brain/Weekly` 和 `04-Life/Daily`；
5. 回读目录，并在 Obsidian 中确认 Vault 可以打开；
6. 再继续 PAM 与 Windows 计划任务配置。

完整要求见 `skills/personal-os-diary-sync/references/obsidian-setup.md`。

Windows 环境可在用户已经授权安装并确认 Vault 路径后调用：

```powershell
powershell -ExecutionPolicy Bypass -File skills/personal-os-diary-sync/scripts/bootstrap_obsidian.ps1 -VaultPath "<ABSOLUTE_VAULT_PATH>" -InstallObsidian
```

脚本返回 `prepared` 只代表软件与目录已准备好，不代表 PAM、Obsidian 路由或无人值守任务已经实跑。

## 项目规则能否自动填写

只有当前环境实际具备项目设置写入能力或经过授权的浏览器操作能力时，才能自动把两份规则填入项目并回读核验。

普通 ChatGPT 网页聊天不能保证只凭提示词和 GitHub 链接修改项目设置。无法自动填写时：

1. 打开 `Personal OS` 项目的更多菜单，进入“项目设置”，把 `skills/personal-os-diary-sync/assets/personal-os-project-instructions.md` 代码块内的完整内容粘贴到“说明”。
2. 打开 `Personal Brain` 项目的更多菜单，进入“项目设置”，把 `skills/personal-os-diary-sync/assets/personal-brain-project-instructions.md` 代码块内的完整内容粘贴到“说明”。
3. 保存后重新打开两个项目设置，核对版本标题和项目名称。

这是安装流程允许的两次人工粘贴。除此之外，不应要求用户在 ChatGPT、Codex 和 Obsidian 之间转抄运行反馈。

## ChatGPT/Codex 应如何处理这个链接

### 支持插件仓库安装时

1. 把用户提供的 GitHub 仓库链接添加为 marketplace source；仓库清单位于 `.agents/plugins/marketplace.json`。
2. 读取根目录 `plugin.json` 并安装 `personal-os-diary-sync`。
3. 运行 `./skills/personal-os-diary-sync/SKILL.md` 指定的 onboarding；是否能直接修改项目说明，以当前环境实际提供的权限为准。
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
- 多个同名项目、Vault、Google Docs 或任务之间应选择哪一个。

不得让用户在 ChatGPT、Codex 和 Obsidian 之间人工复制运行反馈；能通过工具、文件和日志回读的结果由安装流程自行取得。

