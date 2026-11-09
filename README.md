# Personal OS + Personal Brain：ChatGPT 同步到 Obsidian

> 很难坚持写日记，通常不是因为不想记录，而是记录太耗时。

传统日记需要专门打开软件、回忆一天、组织语言、排版和分类。忙起来，这件事最容易被放弃。但在 AI 时代，长期、真实、可追溯的个人记录，正是让 AI 逐渐理解你的重要数据。

这套流程把记录动作缩短成两件事：

1. 生活记录放进 `Personal OS`，知识探索、想法和决策放进 `Personal Brain`；
2. 当天记录结束时发送“收工”。

之后按已经跑通的链路处理：

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

两个项目的 RAW 都只保存用户原始输入。Personal OS 的 DAILY 保存生活记录、健康、财务、行为洞察和行动反馈；Personal Brain 的 BRAIN 保存 Resource、Insight、Knowledge、Idea、Decision、待确认和后续探索。系统负责查重、修订、冲突保护、正式准入、路由和写后回读。

## 最简单的安装方式

把本仓库的 GitHub 链接发给 ChatGPT/Codex，然后只发送这一句话：

```text
请按这个仓库的安装说明安装并配置 Personal OS 与 Personal Brain。把仓库中的 V2.3 和 V2.0 完整项目说明分别写入对应 ChatGPT 项目，自动读取两个真实 project ID；能自动读取的配置直接读取，只有账号授权、私人健康目标、Google Drive 连接和 Obsidian Vault 路径无法确认时再问我。完成后按仓库验收清单实测两个项目，不要把配置成功当成已同步成功。
```

支持仓库插件安装的 ChatGPT/Codex 会读取根目录 `plugin.json`，安装后自动调用 onboarding Skill。Codex 也可以使用内置 `skill-installer` 从本仓库的 `skills/personal-os-diary-sync` 安装。

安装和本机写入仍需要用户确认账号登录、Google Drive 授权和本地文件权限。普通 ChatGPT 网页聊天不能绕过这些授权直接修改 Windows 上的 Obsidian；需要在支持本地文件操作的 Codex 或 ChatGPT 桌面环境中完成本地部分。

详细安装边界见 [INSTALL.md](INSTALL.md)。

## 安装后会自动做什么

onboarding Skill 会尽量自行完成：

1. 从项目清单中找到 `Personal OS` 和 Personal Brain，并分别取得真实 project ID；不会把示例 ID 固化到代码或互换两个项目。
2. 把完整的 Personal OS V2.3 和 Personal Brain V2.0 项目说明分别写入并回读核验。
3. 检查 Google Drive 连接、Obsidian Vault、Python、rclone、现有 PAM 文件、Windows 计划任务和日志。
4. 保留已经通过验收的实现，不重复创建同名任务或覆盖现有配置。
5. 配置或修订两个项目各自的 Google Drive 归档规则。
6. 配置本地正式任务 `PersonalAI-PAMDriveSync`：每天 02:00、登录后 1 分钟补跑、禁止并发、失败每 5 分钟重试最多 3 次。
7. 先在隔离测试目录验证，再申请接入正式 Vault。
8. 实测两个项目的首次同步、重复运行、修订、`incomplete`、重复标题、错误项目/类型和人工编辑冲突。
9. 分别报告 Google Drive、PAM 正式准入、Obsidian 路由、本地回读和无人值守实跑状态。

## 日常怎么用

不需要填写固定模板。生活记录发到 Personal OS，例如：

```text
今天终于把拖了很久的方案交了。真正卡住我的不是不会做，而是担心交出去被否定。
```

当天说完后发送：

```text
收工
```

只有明确的“收工”才触发正式日归档。“本周收工”“本月收工”、提醒消息和普通聊天都不触发这条链路。

知识、观点、资料、创意和决策讨论发到 Personal Brain，同样在当天结束时发送“收工”。两个项目不会自动把内容互相搬运。

## 当前规则

- Personal OS 云端只创建或原位修订 `PAM-OS-RAW-YYYY-MM-DD` 与 `PAM-OS-DAILY-YYYY-MM-DD`。
- Personal Brain 云端只创建或原位修订 `PAM-BRAIN-RAW-YYYY-MM-DD` 与 `PAM-BRAIN-BRAIN-YYYY-MM-DD`。
- 云端自动化不直接写 Obsidian；本地 `PersonalAI-PAMDriveSync` 负责正式准入与路由。
- RAW 只保留用户原话，不混入 AI 回复，不改写错别字和口误。
- DAILY/BRAIN 使用对应项目“收工”后同轮次最终整理结果，不补造缺失记录。
- 正文、分页、同日其他窗口或附件无法完整读取时，使用 `content_status: incomplete`。
- 同标题 0 份创建；1 份核验并按需修订；2 份及以上停止并报告冲突。
- 内容相同跳过；新增消息、附件变为可读或明确更正时，在原文档推进 `revision`。
- Personal OS 不生成 BRAIN；Personal Brain 不生成 DAILY。普通日归档不生成 WEEKLY 或 MONTHLY 云端文档。
- DAILY 只写入人工日记的 `PAM-DAILY-START/END` 区块；区块外内容不动。
- 一次运行即使退出码为 0，只要存在正式校验 reject，也必须报告为部分成功。

完整提示词规则见 [Personal OS 规则](skills/personal-os-diary-sync/references/personal-os-rules.md)与 [Personal Brain 规则](skills/personal-os-diary-sync/references/personal-brain-rules.md)。

## 已跑通到什么程度

截至 2026-11-08，参考实现已真实运行：Google Docs 导出、SHA-256、正式准入、元数据路由、重复运行跳过、DAILY 日记嵌入、Windows 02:00/登录触发均有日志证据。最近一次 Personal OS 检查中，有效文档已路由并完成两份 DAILY 嵌入，同时仍有 3 份早期格式错误文档被拒绝；这也是本 Skill 坚持分层报告的原因。

Personal Brain V2.0 项目说明及 RAW/BRAIN 协议已从实际项目设置回读并纳入 Skill，但这次打包没有新建正式 Google Docs，也没有重新触发 Windows 任务。新用户安装后仍必须分别实跑两个项目，不能把模板已安装说成同步已经完成。

公开仓库不包含真实项目 ID、Google 文件 ID、用户名、Vault 路径、日记正文或生产日志。状态快照见[参考实现状态](skills/personal-os-diary-sync/references/reference-status.md)。

## 文件导航

| 文件 | 用途 |
|---|---|
| [INSTALL.md](INSTALL.md) | GitHub 链接安装方式和真实能力边界 |
| [SKILL.md](skills/personal-os-diary-sync/SKILL.md) | 安装、配置、维护和排障入口 |
| [Personal OS 项目说明](skills/personal-os-diary-sync/assets/personal-os-project-instructions.md) | 可直接加入 ChatGPT 项目说明 |
| [Personal Brain 项目说明](skills/personal-os-diary-sync/assets/personal-brain-project-instructions.md) | 可直接加入 ChatGPT 项目说明 |
| [Personal OS 规则](skills/personal-os-diary-sync/references/personal-os-rules.md) | 当前云端归档提示词的全部有效规则 |
| [Personal Brain 规则](skills/personal-os-diary-sync/references/personal-brain-rules.md) | Personal Brain RAW/BRAIN 云端归档规则 |
| [本地同步规则](skills/personal-os-diary-sync/references/local-sync.md) | PAM V2.3、本地任务和日记嵌入规则 |
| [验收清单](skills/personal-os-diary-sync/references/acceptance.md) | 判断每一层是否真的完成 |
| [隐私规则](skills/personal-os-diary-sync/references/privacy.md) | GitHub 发布和日志脱敏 |

## 隐私检查

发布前运行：

```powershell
python skills/personal-os-diary-sync/scripts/privacy_scan.py .
```

本仓库目前未预设 LICENSE；正式公开前应由仓库所有者选择许可证。

仓库结构采用 OpenAI 官方的 plugin + skills 结构。参见 [Package your plugin](https://developers.openai.com/plugins/build/plugins) 和 [Skills](https://developers.openai.com/plugins/concepts/skills)。


