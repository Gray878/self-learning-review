# self-learning-review

**把过程沉淀成经验。**

一个 Claude Code Skill：在功能开发完成或 bug 解决之后，自动把开发过程转化为结构化复盘——时间线、5 Whys 根因链、失败尝试、行动项、自我检验。

## 为什么需要它

用 AI 写代码的典型一天：

> 提需求 → AI 给方案 → 报错 → 换个问法 → 又报错 → 终于好了 → 下一个需求

问题不在效率，在于**经验随会话蒸发**：折腾两小时才解决的 bug，三个月后遇到同类的，还是从零开始。

学生时代对付这个问题的办法是错题本：做错的题记下来、定期重看。这个 skill 就是 AI Coding 的错题本——而且不只抄题，还帮你挖根因、留自测题。

## 生成什么

一篇 6 节的 Markdown 复盘（深度模式，默认；另有快速模式的一页卡片）：

| 环节 | 内容 |
|---|---|
| 时间线 | 🔵 推进 / 🟡 绕路 / 🔴 卡点——一眼看清时间耗在哪 |
| 根因链 | 5 Whys 追问到"值得修的那一层"，拒绝"改了就好了" |
| 尝试记录 | 失败的尝试也入表，弯路同样是资产 |
| 关键学习点 | 用自己的话提炼几条可迁移的概念 / 规则 |
| 行动项 | "下次遇到 X，就做 Y"——带触发条件才可执行 |
| 自我检验 | AI 出题留白，你盲答——能讲清楚才算学会 |

完整示例见 [examples/example-review.md](examples/example-review.md)。

## 两分钟看个例子

"本地好好的，部署到 Docker 就报 `ModuleNotFoundError`"——复盘后的根因链长这样：

```
表象：容器内调用 to_excel() 报缺 openpyxl
为什么 → 镜像里没有安装 openpyxl
为什么 → requirements.txt 没有声明它，镜像按清单构建
为什么 → 本地 pip install 后没有同步依赖清单的习惯
根因：依赖变更只存在于"环境实例"，从未进入"环境定义"
```

对应的行动项：

| 触发条件 | 动作 |
|---|---|
| 下次本地装新包 | 装完立即同步进 requirements.txt |
| 下次"本地正常、部署报错" | 第一步先对比两端依赖清单，不先装包 |

## 安装

### Windows

双击 `install.bat`。

### macOS / Linux

```bash
bash install.sh
```

（macOS 双击 .sh 默认用编辑器打开；要双击运行就先 `chmod +x install.sh`。）

### 手动安装

把 `SKILL.md`、`templates/`、`examples/`、`references/` 复制到 `~/.claude/skills/self-learning-review/`（Windows 为 `%USERPROFILE%\.claude\skills\self-learning-review\`），文件夹名必须与 skill 同名。

**更新**：重跑一遍安装脚本即可。检测到已安装会自动进入更新模式并镜像同步——仓库里删掉的文件也会从安装目录清理。脚本本身和 `.git` 不会被复制。

## 使用

新开一个 Claude Code 会话，任选其一：

- 输入 `/self-learning-review`
- 直接说："帮我复盘一下刚才的开发过程" / "整理一下这个 bug"

它会：还原时间线 → 挖根因 → 提炼知识 → 生成复盘 → 问你保存到哪（Obsidian 笔记库或项目 `reviews/`）并登记索引。

## 连入 Obsidian

复盘是带 YAML frontmatter 的标准 Markdown，写进 Obsidian vault 即自动集成（标签检索、勾选框、双向链接图谱），无需插件或 API。

**一次性配置（三步）**：

1. 装 Obsidian 并建好 vault（一个文件夹，比如 `D:\Notes`）
2. 在 Claude Code 里做第一次复盘，说"存到 Obsidian"——skill 会自动读 Obsidian 配置列出你的 vault 让你选（读不到就让你直接贴路径）
3. 选完即记下，路径存在 `~/.claude/skills/self-learning-review/config.md`，以后每次复盘自动用、不重选

**换 vault**：编辑那个 `config.md` 改 `vault:` 这行，或在对话里说"换 vault 到 …"。

**复盘落在哪**：`<你的 vault>/<当前项目名>/`，每篇一个 `.md`，外加一个 `INDEX.md` 用 `[[双向链接]]` 串起所有复盘——同一项目的复盘聚在一起，Obsidian 关系图谱里按项目成簇。

> 安装脚本升级时只镜像 SKILL.md 和三个子目录，不会动 `config.md`，配置不会丢。
>
> 不装 Obsidian 也能用：默认存当前项目 `reviews/`，frontmatter 和 wikilink 仍是合法 Markdown，不影响阅读。

## 和"让 AI 总结一下会话"有什么不同

| 普通会话总结 | self-learning-review |
|---|---|
| 总结改了哪些代码 | 总结为什么这么改、下次怎么更快 |
| AI 替你写结论 | 关键结论留白，你先盲答再对照 |
| 看完即忘 | 附自测题，先盲答再看 |
| 只挑毛病 | 无责复盘：对事不对人，不指责用户或 AI |

## 设计依据

不是拍脑袋的模板，每个环节都有出处（详见 [references/methodology.md](references/methodology.md)）：

- 无责复盘与行动项 —— Google SRE Postmortem Culture
- 15 分钟反思胜过多练 15 分钟（绩效提升约 20%）—— Di Stefano 等，HBS
- 根因链 —— 5 Whys（丰田生产系统）
- 自测留白 —— 自我解释效应 / 费曼技巧

## 目录结构

```
self-learning-review/
├── SKILL.md                       # 主工作流
├── install.bat / install.sh       # 安装脚本
├── templates/
│   ├── review-template.md         # 深度复盘模板（6 节）
│   └── quick-review-template.md   # 快速复盘模板（一页）
├── examples/
│   └── example-review.md          # 完整示例（Docker 依赖排查案例）
└── references/
    └── methodology.md             # 设计依据与出处
```
