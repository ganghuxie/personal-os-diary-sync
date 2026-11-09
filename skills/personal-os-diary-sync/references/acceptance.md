# Personal OS 与 Personal Brain 验收清单

## 必须分开的状态

| 状态 | 最低证据 |
|---|---|
| 聊天来源已读取 | 目标日期、聊天范围、user message 数量、附件边界和完整性 |
| Obsidian 已安装 | 应用安装状态、可执行文件或版本，并且实际启动成功 |
| Vault 已初始化 | 唯一绝对路径、Obsidian 已打开该 Vault、必需目录逐一回读 |
| Google Drive 已写入 | 对应项目的精确标题、唯一文件 ID、正文和正式字段写后回读 |
| PAM 已正式准入 | 对应文档正式校验通过；reject 单独列出 |
| Obsidian 已路由 | 路由器结果和预期 Personal OS 或 Personal Brain 正式路径 |
| 本地文件已回读 | frontmatter、H1、revision、正文哈希和 UTF-8 读取 |
| DAILY 已嵌入 | 目标日记、单一开始/结束 marker、区块外正文未变 |
| 无人值守调度已实跑 | 真实计划触发、启动器日志、同步日志、路由日志和最终文件回读 |

上游成功不能推断下游成功。

## 安装验收

1. 已从当前项目清单分别取得 Personal OS 与 Personal Brain 的真实 project ID；没有互换或复制示例值。
2. 已回读两个项目的完整项目说明：Personal OS 为 V2.3、Personal Brain 为 V2.0；正式元数据名称、文档类型、H1、YAML 和目录与模板一致。
3. Obsidian 已安装并实际启动；没有安装时不能把普通 Markdown 文件夹称为 Obsidian Vault 已就绪。
4. 正式 Vault 已创建或唯一选定，`Personal-OS/Raw`、`Personal-OS/Daily`、`Personal-OS/Weekly`、`Personal-Brain/Raw`、`Personal-Brain/BRAIN`、`Personal-Brain/Weekly` 和 `04-Life/Daily` 均已回读。
5. Personal OS 云端自动化名称为 `Personal OS Google Drive 补漏归档 V2.3`，每周一北京时间 10:00。
6. 旧版直接写 Vault 的自动化未启用。
7. 本地正式任务只保留 `PersonalAI-PAMDriveSync`，每天 02:00、登录后 1 分钟、禁止并发、失败重试最多 3 次。
8. Google Drive 连接、Vault、staging、state、logs、backup 和 conflict 路径均已解析到用户自己的环境。

## 文档验收

1. Personal OS 新的完整 RAW 与 DAILY 各创建一份；Personal Brain 新的完整 RAW 与 BRAIN 各创建一份。
2. RAW 不含 AI 回复，来源范围包含 thread ID、user message ID、北京时间和附件边界。
3. DAILY 或 BRAIN 来自对应项目 `收工` 后同轮次最终整理结果，栏目和格式与项目说明一致。
4. 同样内容重跑不创建、不追加、不覆盖，结果为 no change/skip。
5. 新增消息或明确更正修订原 Google Doc，`revision` 加 1，`revision_of` 为上一版数字；对应项目的两份日文档一起推进版本。
6. 同标题两份及以上停止，不任意选择。
7. 不完整来源保留 `content_status: incomplete`，不补造。
8. 错误 project ID、项目名、类型、日期、H1、YAML 字段或 revision 被拒绝。
9. `test_only: true` 不进入任何正式 Personal OS、Personal Brain 路径或人工日记。

## 本地验收

1. Personal OS RAW/DAILY 与 Personal Brain RAW/BRAIN 分别进入正确目录，不跨项目路由。
2. 路由依据项目元数据和文档类型，不只看正文标题。
3. DAILY 只更新 PAM-DAILY marker 区块。
4. 区块外人工正文、计划和勾选状态保持不变。
5. 区块内人工修改触发冲突，停止覆盖并生成差异报告。
6. 写入前有备份，写入使用原子替换，写后回读。
7. rclone 失败不写 Inbox，状态为 `needs_retry`。
8. 启动器退出码为 0 时仍检查 `formal_rejected` 和 exceptions。

## 报告用语

只使用这些明确状态：

- 已配置、未实跑。
- Obsidian 已安装并启动；Vault 尚未创建。
- Vault 与必需目录已创建并回读；PAM 尚未实跑。
- Google Drive 已写入并回读；PAM 未运行。
- PAM 正式准入通过；Obsidian 路由失败。
- Obsidian 已路由并完成本地回读。
- 无人值守调度已实跑。
- 部分成功：有效文档已路由，另有正式文档被拒绝。


