# GitHub 隐私规则

## 不进入公开仓库

- 真实 project ID、thread ID、message ID、Google Docs 文件 ID；
- 用户名、电脑名、邮箱、电话和本机绝对路径；
- 真实 Vault 名称、私人目录、日记正文、截图和附件；
- OAuth token、cookie、API key、rclone 配置和任何凭据；
- 生产日志、状态文件、staging 导出、备份、差异报告和真实正文哈希；
- 填写完成的私人安装配置。

`Personal OS`、`Personal Brain`、`PersonalAI-PAMDriveSync`、`PAM-OS-RAW`、`PAM-OS-DAILY`、`PAM-BRAIN-RAW`、`PAM-BRAIN-BRAIN`、`RAW`、`DAILY`、`BRAIN`、`PAM-DAILY-START/END` 是本项目正式名称，可以保留。

## 安装时处理私人值

安装流程在用户自己的环境中读取 project ID、Vault、Google Drive 和任务路径，并把它们写入本地私有配置。不得把这些值回写到公开 Skill、Git 提交或聊天示例中。

测试使用虚构内容和 `test_only: true`，并放在隔离目录。不要把测试内容路由到正式 Personal OS。

## 发布前

1. 在仓库根目录运行 `python skills/personal-os-diary-sync/scripts/privacy_scan.py .`。
2. 检查暂存文件和完整 Git 历史。
3. 检查图片、PDF 和视频画面，因为文本扫描器看不到其中的隐私。
4. 确认没有 `.env`、rclone 配置、credentials、logs、state、staging、backup 或 private 文件。
5. 如果凭据曾提交，先撤销凭据；只从最新提交删除不够。

隐私扫描通过只是防护，不等于绝对匿名。

