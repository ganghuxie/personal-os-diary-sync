# PersonalAI-PAMDriveSync 与 PAM V2.3

## 安装产物

在用户 Vault 的系统目录中复用或建立以下组成部分；如果已经存在，先审计再修改，不创建第二套并行实现：

- `pam_drive_sync.py`：Google Drive 只读发现、导出、正式准入、SHA-256、PAM-Inbox 和状态日志；
- `pam_document_router.py`：按项目元数据和文档类型路由；
- `pam_daily_embed.py`：把正式 DAILY 写入人工日记的 PAM 区块；
- `run_pam_drive_sync.ps1`：网络检查、同步、partial 路由和启动器日志；
- 用户私有配置 JSON：rclone、staging、Vault、state、logs、lock、daily note、backup 和 conflict 路径；
- 单元测试：正式字段、Google Docs 转义、首次同步、重复同步、revision、空文件、错误 ID/类型/日期、test_only、人工编辑冲突、断网和恢复。

项目 ID、用户名、绝对路径和 rclone 凭据只进入用户本机私有配置，不进入公开 Skill。

## 正式任务

任务名：`PersonalAI-PAMDriveSync`

- 每天 02:00；
- 用户登录后延迟 1 分钟；
- 错过计划后尽快运行；
- 网络可用时运行；
- 禁止并发；
- 失败每 5 分钟重试，最多 3 次；
- 调用 `run_pam_drive_sync.ps1`。

启动器先检查 Python、rclone 配置、同步脚本、路由器、配置文件和 Google 网络解析，再运行 Drive 同步。`result=partial` 时仍路由已通过正式准入的文档，并把拒绝项保留在日志中。不得因启动器最终退出码为 0 而隐藏 reject。

## 数据流

```text
Google Drive 只读导出
→ 独立 staging run 目录
→ UTF-8、定向 Markdown 修复与 SHA-256
→ PAM-Inbox 受管入口
→ 正式文档元数据路由
→ Personal-OS/Raw/YYYY/YYYY-MM-DD.md
→ Personal-OS/Daily/YYYY/YYYY-MM-DD.md
→ 04-Life/Daily/YYYY-MM-DD.md 的 PAM-DAILY 区块

或按正式项目元数据路由：
→ Personal-Brain/Raw/YYYY/YYYY-MM-DD.md
→ Personal-Brain/BRAIN/YYYY/YYYY-MM-DD.md
```

## 正式准入

只自动发现严格命名的正式文件：

- `PAM-OS-RAW-YYYY-MM-DD.md`
- `PAM-OS-DAILY-YYYY-MM-DD.md`
- `PAM-BRAIN-RAW-YYYY-MM-DD.md`
- `PAM-BRAIN-BRAIN-YYYY-MM-DD.md`

同时校验：文件名、项目 ID、项目名、类型、日期、`revision`、`revision_of`、`test_only`、`content_status`、`source_created_at` 和唯一匹配 H1。Personal OS 只接受 RAW/DAILY；Personal Brain 只接受 RAW/BRAIN，且正式项目名必须为 `Personal Brain`。未知字段、重复字段、无效日期、项目/类型不一致、空文件、同标题不同 Google Docs 文件 ID、未推进修订号或人工编辑冲突都 fail closed。

Google Docs 导出允许定向修复开头 YAML 分隔线、支持的 H1 和 YAML 白名单字段名中的转义；不得全局修改字段值或 RAW 正文。

## 去重与恢复

- 同一来源路径、原始 SHA-256 和修复后 SHA-256 相同：跳过。
- 来源更新：保留受管历史版本，再更新当前文件。
- 已写入但状态未更新：根据受管 marker 和正文哈希恢复，不重复写正文。
- rclone 失败：不写 Inbox，标记 `needs_retry`，保留 staging。
- 锁只在确认没有运行进程且超过过期时间后恢复。

## DAILY 日记嵌入

- 只处理新建或修订的正式 Personal OS DAILY；既有 skip 来源不自动回填。
- `backfill_existing=false`。
- 只更新 `<!-- PAM-DAILY-START -->` 与 `<!-- PAM-DAILY-END -->` 之间的内容。
- 移除 YAML 与 DAILY H1 后嵌入；H2-H5 下移一级。
- 区块外计划、勾选状态和人工笔记保持原样。
- 修改前备份，使用原子替换并写后回读。
- 区块内发生人工修改时停止覆盖，并生成差异报告。
- `test_only: true` 不进入正式日记；`content_status: incomplete` 原样保留。

## 周复盘

当前参考实现另有 `PersonalAI-PAMWeeklyReview`，每周一 09:30 先强制执行同一 Drive 同步，再核验上一 ISO 周的 RAW/DAILY 完整性。缺失或 `incomplete` 明确标记，不视为零。该任务不是完成日记同步所必需；只有用户要求复刻完整 Personal OS 周复盘时才配置。


