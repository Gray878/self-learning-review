# self-learning-review

学习陪练 / Vibe Coding 复盘生成器：把一次 AI Coding（Claude Code / Cursor / ChatGPT 等）开发或 Debug 过程，转化为结构化学习复盘——时间线、5 Whys 根因链、失败尝试记录、AI 协作复盘、行动项与复习计划。

核心闭环：**AI Coding → 问题解决 → 自动复盘 → 沉淀经验 → 下次更快解决类似问题。**

## 安装

### Windows

双击仓库根目录的 `install.bat`。

### macOS / Linux

终端执行：

```bash
bash install.sh
```

（macOS 下 .sh 双击默认会用编辑器打开；如需双击运行，先 `chmod +x install.sh` 并在"显示简介 → 打开方式"里设为终端。）

### 手动安装

把以下内容复制到 `~/.claude/skills/self-learning-review/`（Windows 为 `%USERPROFILE%\.claude\skills\self-learning-review\`），文件夹名必须与 skill 同名：

```
SKILL.md
templates/    （review-template.md、quick-review-template.md）
examples/     （example-review.md）
references/   （methodology.md）
```

## 更新语义

脚本检测到目标已存在时自动进入"更新"模式：覆盖 `SKILL.md`，并对 `templates/` `examples/` `references/` 做镜像同步——仓库里已删除的文件也会从安装目录清掉。脚本本身和 `.git` 不会被复制。

## 验证

新开一个 Claude Code 会话：

- 输入 `/self-learning-review` 手动触发
- 或直接说"帮我复盘一下刚才的开发过程"，Claude 会按 description 自动加载

## 目录结构

```
self-learning-review/
├── SKILL.md                       # 主工作流（155 行）
├── install.bat / install.sh       # 安装脚本
├── templates/
│   ├── review-template.md         # 深度复盘模板（10 节）
│   └── quick-review-template.md   # 快速复盘模板（一页）
├── examples/
│   └── example-review.md          # 完整示例（Docker 依赖排查案例）
└── references/
    └── methodology.md             # 设计依据与出处
```
