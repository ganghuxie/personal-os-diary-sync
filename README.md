# Personal OS Diary Sync

> 很难坚持写日记，往往不是因为不想记录，而是回忆、整理和排版太耗时。

用语音转文字或直接输入，想到什么就发什么；当天发送“收工”，ChatGPT 自动整理，再经 Drive、PAM 和 Windows 任务进入 Obsidian，成为可检索和供 AI 分析的个人资产。

## 开始前你需要

第一次配置需 20–40 分钟，不是只点一次链接。

| 项目 | 需要准备 |
| --- | --- |
| 账号 | ChatGPT、Google Drive、可访问本仓库的网络 |
| 软件 | ChatGPT 桌面端工作模式或 Codex CLI、rclone、Obsidian、Windows 计划任务 |
| 时间 | 20–40 分钟；登录或授权异常时可能更久 |
| 人工确认 | 通常 3–6 次；逐步确认路径、命令、文件和权限 |

## 安装 vs 使用：先说真相

**安装不是一键，使用才是一键。** 安装需授权和本机配置；日常只需记录并发送“收工”。

| 环境 | 能自动做什么 | 你必须手动做什么 | 预计耗时 |
| --- | --- | --- | --- |
| 网页聊天 | 读仓库、解释步骤、生成规则 | 创建项目、粘贴规则、安装软件、配置同步 | 通常超过 40 分钟 |
| 桌面端工作模式 | 获得权限后检查、安装和测试 | 逐步确认、登录账号、授权 Drive | 约 20–40 分钟 |
| Codex CLI | 下载 Skill、运行脚本和测试 | 创建项目、必要时粘贴规则、确认授权 | 约 20–40 分钟 |

网页聊天不能修改 Windows 或 Obsidian；桌面端和 CLI 仍受权限和登录状态限制。

## 术语表

先看懂这些词，就能判断流程究竟完成到了哪一步。

| 术语 | 含义 |
| --- | --- |
| PAM | 校验云端文档并路由到正式目录的本地层 |
| 正式准入 | 通过项目、类型、日期、版本和协议校验；不是仅下载成功 |
| RAW | 用户原始输入，不含 AI 回复，不改写 |
| DAILY | Personal OS 最终整理结果，只含有来源内容 |
| BRAIN | Personal Brain 的知识整理结果 |
| WEEKLY | 基于已归档数据生成的周复盘，不由普通“收工”自动生成 |
| project ID | ChatGPT 项目的唯一标识，用于防止串写 |
| Vault | Obsidian 知识库所在的本地文件夹 |
| rclone | 本地读取 Google Drive 文档并交给 PAM 校验的同步工具 |

## 它到底怎么流转

ChatGPT 负责云端文档，本地任务负责准入和路由，不能混称完成。

```text
Personal OS 项目聊天
→ Google Drive：PAM-OS-RAW / PAM-OS-DAILY
→ Windows 任务 PersonalAI-PAMDriveSync
→ PAM 正式准入
→ Obsidian：Personal-OS/Raw 与 Personal-OS/Daily
→ 04-Life/Daily 中的 PAM-DAILY 区块

Personal Brain 项目聊天
→ Google Drive：PAM-BRAIN-RAW / PAM-BRAIN-BRAIN
→ Windows 任务 PersonalAI-PAMDriveSync
→ PAM 正式准入
→ Obsidian：Personal-Brain/Raw 与 Personal-Brain/BRAIN
```

RAW 只含用户原始输入；DAILY 是 Personal OS 最终结果；BRAIN 是 Personal Brain 知识整理。读取不全须标 `incomplete`，不得补造。

## 安装步骤

先创建两个项目，再由有本地权限的工作模式或 Codex 配置。

### 1. 创建并命名两个 ChatGPT 项目

在 ChatGPT 左侧“项目”点击加号，分别创建 `Personal OS` 和 `Personal Brain`；普通网页聊天不一定能代为操作。

![点击项目右侧的加号创建项目](docs/images/01-create-project-button.jpg)

![将项目命名为 Personal OS](docs/images/02-name-personal-os.jpg)

### 2. 在新窗口切换到工作模式

工作模式可在确认后处理本机文件；普通网页聊天不能直接安装 Obsidian 或修改 Windows 任务。

![在新窗口切换到工作模式](docs/images/05-switch-to-work-mode.jpg)

### 3. 发送安装提示词和仓库链接

这段提示词要求每一步先确认。

```text
请安装并配置这个项目：
https://github.com/ganghuxie/personal-os-diary-sync

阅读 README.md、INSTALL.md、plugin.json 和 skills/personal-os-diary-sync/SKILL.md，检查系统、ChatGPT 项目、Google Drive、Obsidian Vault、rclone、PAM、Windows 计划任务和日志。

每一步执行前先列出将要进行的具体修改，包括路径、命令和将创建或修改的文件；等我明确确认后再继续执行该步。

不要覆盖已跑通配置，不删除个人数据，不写财务账本、健康记录、人工日记正文或无关文件。先隔离测试，再接入 Vault。严格区分：Drive 已写入、PAM 已导出、正式准入、Obsidian 已路由、本地已回读、无人值守已实跑。
```

详细安装边界见 [INSTALL.md](INSTALL.md)。

### 4. 配置项目规则

能操作项目设置时应读取真实 project ID、写入并回读；否则由用户粘贴，不能声称已配置。

![打开 Personal OS 的项目设置](docs/images/03-open-project-settings.jpg)

![把完整规则粘贴到项目说明](docs/images/04-paste-project-instructions.jpg)

- Personal OS：复制 [Personal OS V2.3](skills/personal-os-diary-sync/assets/personal-os-project-instructions.md)
- Personal Brain：复制 [Personal Brain V2.0](skills/personal-os-diary-sync/assets/personal-brain-project-instructions.md)

### 5. 准备 Obsidian

没有 Obsidian 时不能完整跑通；安装器须先说明来源、路径和命令并等确认，再安装或选择 Vault。

目录见 [Obsidian 自动安装、Vault 初始化与安全边界](skills/personal-os-diary-sync/references/obsidian-setup.md)，脚本见 [bootstrap_obsidian.ps1](skills/personal-os-diary-sync/scripts/bootstrap_obsidian.ps1)。

<details>
<summary>需要的 Vault 目录</summary>

```text
Personal-OS/Raw
Personal-OS/Daily
Personal-OS/Weekly
Personal-Brain/Raw
Personal-Brain/BRAIN
Personal-Brain/Weekly
04-Life/Daily
```

</details>

## 安装完成后会做什么

只有取得实际证据的环节才能报告成功。

- 读取真实 project ID，写入规则并回读；不固化作者 ID，不互换项目。
- 检查 Drive、rclone、PAM、Vault、任务和日志，保留已验收实现。
- 配置 `PersonalAI-PAMDriveSync`：先隔离测试，再接入 Vault；真实调度后才算无人值守实跑。
- 同标题 0 份创建、1 份核验修订、2 份及以上停止报告；重复运行不得重复创建或追加。
- 分别报告 Drive 写入、PAM 导出、正式准入、Obsidian 路由、本地回读和调度，不能混称完成。

## 日常怎么用

想到什么就输入或语音转文字，结束时单独发送“收工”。

```text
今天上午把首页文案改完了，但我发现真正卡住我的不是写文案，
而是不确定第一屏到底应该先讲痛点还是先讲结果。
```

当天记录结束时发送：

```text
收工
```

只有明确发送“收工”才触发当日整理；普通聊天、“本周收工”或“本月收工”不能代替。

核心规则只需记住四条：

1. RAW 只含用户原始输入；Personal OS 生成 DAILY，Personal Brain 生成 BRAIN；缺失不补造。
2. Personal OS 与 Personal Brain 按真实 project ID、标题和文档类型隔离，不能串写。
3. 云端自动化只创建或原位修订 Google Docs，不直接写 Vault；正式准入和路由由 `PersonalAI-PAMDriveSync` 负责。
4. DAILY 只更新 `PAM-DAILY-START/END` 区块，区块外人工内容不得覆盖；WEEKLY 只基于已归档且获授权的数据生成。

其余规则见 [Personal OS 云端补漏归档规则](skills/personal-os-diary-sync/references/personal-os-rules.md) 与 [Personal Brain 云端补漏归档规则](skills/personal-os-diary-sync/references/personal-brain-rules.md)。

## 成功自检 3 条

三条都满足，才算 DAILY 正确落地。

1. 在 Obsidian 中能看到当天 DAILY。
2. 当天文件中存在 `PAM-DAILY-START/END` 区块。
3. 区块外的手写内容在重复同步后仍未被覆盖。

## 隐私提醒

日记原文会上传 Google Drive 并被 ChatGPT 读取；敏感内容不要发送。

仓库不得含真实日记、聊天、Vault 路径、Drive ID、OAuth 材料或日志；请按 [隐私检查](skills/personal-os-diary-sync/references/privacy.md) 扫描。

## 进阶玩法

可把近期目标、期限和关注信号加入项目规则，但不代表 AI 已替你执行。

```text
近期目标：在 6 周内完成个人网站上线。
请在日常记录中识别与该目标相关的进展、阻塞、关键决定和下一步；
只有我明确说已经完成时，才标记为完成，不要把建议写成已执行。
```

## FAQ

常见故障多数发生在本机任务、授权或规则版本，而不是“收工”两个字本身。

**02:00 电脑关机或休眠？** 不会运行；是否补跑取决于“错过后尽快运行”或登录触发，以日志为准。

**Drive 空间不足？** 写入可能失败，不能视为已准入；释放空间后重跑并检查回读与 PAM 日志。

**改规则不生效？** 确认当前项目并重开聊天；云端补漏规则与项目说明不会互相更新。

**装错想回滚？** 暂停任务或自动化，保留日志和备份，再恢复旧配置；勿删除 Vault 或覆盖个人文件。

**Windows 之外能用吗？** 文档协议可复用，但 `bootstrap_obsidian.ps1`、Windows 任务只按 Windows 验证；macOS/Linux 需另行实现和验收。

**如何彻底卸载？** 备份 Vault，停用或删除本仓库任务与自动化，撤销 Drive/rclone 授权，卸载 Skill 和可选软件；个人数据默认保留。

## 文件导航

具体实现按下表查找。

| 文件 | 用途 |
| --- | --- |
| [SKILL.md](skills/personal-os-diary-sync/SKILL.md) | 安装器和维护器的入口 |
| [INSTALL.md](INSTALL.md) | 完整安装、权限和验收边界 |
| [Personal OS V2.3](skills/personal-os-diary-sync/assets/personal-os-project-instructions.md) | Personal OS 项目说明 |
| [Personal Brain V2.0](skills/personal-os-diary-sync/assets/personal-brain-project-instructions.md) | Personal Brain 项目说明 |
| [Personal OS 云端补漏归档规则](skills/personal-os-diary-sync/references/personal-os-rules.md) | Personal OS 云端自动化规则 |
| [Personal Brain 云端补漏归档规则](skills/personal-os-diary-sync/references/personal-brain-rules.md) | Personal Brain 云端自动化规则 |
| [本地同步参考](skills/personal-os-diary-sync/references/local-sync.md) | Drive、PAM、任务和幂等逻辑 |
| [Obsidian 设置](skills/personal-os-diary-sync/references/obsidian-setup.md) | 安装、Vault 和目录边界 |
| [验收清单](skills/personal-os-diary-sync/references/acceptance.md) | 首次同步、修订、冲突和无人值守验收 |
| [隐私检查](skills/personal-os-diary-sync/references/privacy.md) | 发布前扫描和人工复核 |

## LICENSE 建议

仓库目前未预设 LICENSE，应明确复用权限。

- MIT：适合代码和脚本，允许商用、修改和分发，须保留版权与许可声明。
- CC BY 4.0：适合文档，允许改编与商用但必须署名，不宜替代代码许可证。
- 可用 MIT 覆盖代码、CC BY 4.0 覆盖文档，并在 LICENSE 写清范围。

## 已跑通到什么程度

参考实现截至 2026-11-08（Asia/Shanghai）已有日志证据：旧的直写 Vault 自动化已暂停；`PersonalAI-PAMDriveSync` 为正式本地任务；Drive 导出、暂存、SHA、正式准入、路由、去重、Personal OS RAW/DAILY 落盘和 DAILY 管理区块已实跑并回读。

边界：3 份早期测试 Docs 因 YAML 位置或修订字段不合规而拒收；最近更新未创建正式 Docs，也未重跑 Windows 无人值守任务。仓库文档与安装包更新至 2026-11-09，不等于新增端到端实跑。

状态快照见[参考实现状态](skills/personal-os-diary-sync/references/reference-status.md)。安装到新电脑后仍需重新实测，不能把作者机器的成功当作新环境已经完成。

## 隐私检查

公开前必须同时通过自动扫描和人工复核，扫描通过也不代表已经检查了截图、提交历史或外部链接内容。

```powershell
python skills/personal-os-diary-sync/scripts/privacy_scan.py .
```

再人工检查截图、Git 历史、日志、导出文件和压缩包。插件与 Skill 的公开规范可参考 [OpenAI Plugins 文档](https://developers.openai.com/plugins/build/plugins) 和 [OpenAI Skills 文档](https://developers.openai.com/plugins/concepts/skills)。

