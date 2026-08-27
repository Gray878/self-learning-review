# 方法论依据

本 skill 的设计决策及其来源。执行 SKILL.md 不需要读本文；本文用于回答"为什么这样设计"，以及后续迭代时保持方法论一致。

## Contents

- 精简历史（v3）
- 无责复盘（blameless）
- 反思的学习价值
- 5 Whys 根因分析
- 自我解释与费曼技巧
- Skill 工程规范

## 精简历史（v3）

基于真实使用反馈（"内容太多太杂"），从深度模板裁掉：

- **做得好（what went well）**：原用于强化自我效能感，但用户觉得冗余——自我检验节已承担"确认掌握"的职责
- **Debug 方法总结**：与关键学习点中的排查规则重复，并入关键学习点
- **复习计划（3 天 / 1 周 / 1 月）**：间隔复习的文献依据仍成立，但用户不要固定排期——改由自我检验的盲答承担即时自测
- **AI 协作复盘**：评析本次 Prompt 质量对个人沉淀价值有限，已移除；曾替换为"待确认"节，后因用户不需要也一并移除——不确定的点改为生成时直接向用户追问，不落盘成独立节

保留：时间线、根因链、尝试记录、关键学习点、行动项、自我检验——这是"把过程沉淀成经验"的最小必要集。

**v3.1 补充**（同一轮反馈的收尾）：

- **确认记录范围**：不再自动记录会话中的全部问题。还原时间线后先摆候选问题清单（每条附一句"为什么值得记"），让用户确认保留哪些；只对确认的问题挖根因、写文档，未确认的一律不落盘——延续 v3 的"不确定的点直接追问、不落盘成独立节"的做法
- **关键学习点进一步精简**：3-5 条 → 2-3 条，每条一句话，只留能直接迁移的规则

## 无责复盘（blameless）

**来源**：Google SRE Book, [Postmortem Culture](https://sre.google/sre-book/postmortem-culture/)；[Example Postmortem](https://sre.google/sre-book/example-postmortem/)；[postmortem-templates 合集](https://github.com/dastergon/postmortem-templates)

**核心**：假设所有参与者在当时的信息下都做了合理决策，复盘针对系统性原因而非个人过失。

**在本 skill 中的应用**：

- 写作铁律之二（不指责用户、不指责 AI）
- "下次更早发现的信号"：把"为什么当时没想到"转化为预警信号——源自 postmortem 的 action items 理念
- 行动项"触发条件 → 动作"格式：对应 postmortem action items 必须可执行可检查的要求

## 反思的学习价值

**来源**：Di Stefano, Gino, Pisano & Staats, *Learning by Thinking: How Reflection Aids Performance*（[HBS 页面](https://www.hbs.edu/faculty/Pages/item.aspx?num=63487)，[Farnam Street 摘要](https://fs.blog/learning-by-thinking/)）

**核心**：现场实验中，每天末尾花约 15 分钟做书面反思的组，绩效显著优于把同等时间用于继续练习的组（提升约 20%，以自我效能感为中介）。

**在本 skill 中的应用**：

- 整个 skill 的价值论据：复盘不是"额外开销"，是高杠杆学习行为
- 自我效能感是中介机制 → 复盘写作语气不刻意只挑错（v3 移除了独立的"做得好"节，但无责原则保留，避免变成自我批评）

## 5 Whys 根因分析

**来源**：丰田生产系统起源的 RCA 技术；开发者向介绍见 [freeCodeCamp](https://www.freecodecamp.org/news/from-symptoms-to-root-cause-how-to-use-the-5-whys-technique/)、[Sologic](https://www.sologic.com/en-us/resources/learning/what-are-the-5-whys)

**核心**：从表象连续追问"为什么"，直到落在值得修的那一层。

**在本 skill 中的应用**：

- "根因链"字段：表象 → 为什么 → … → 根因
- 两条防走偏规则：① 不硬凑 5 层，到"值得修"即停（再往上就变成无法行动的"人为何犯错"）；② 因果不唯一时允许多链并行——这是 5 Whys 已知的单链偏差问题
- 质量自检中的"根因测试"：读根因时能否推出"下次在哪预防"

## 自我解释与费曼技巧

**来源**：自我解释效应（Chi 等）；学习式教学 / protégé effect（Nestojko 等，2014：预期要教别人会提升学习）；费曼技巧综述见 [Farnam Street](https://fs.blog/feynman-learning-technique/)、[memo.cards](https://www.memo.cards/blog/feynman-technique)；反面提醒见 [The Danger of the Feynman Technique](https://zhighley.com/article/feynman/)

**核心**：自己产出解释才能暴露"熟悉感"和"能讲清楚"之间的差距；但错误应用（只写摘要、过度简化）会给出虚假的掌握感。

**在本 skill 中的应用**：

- 第 6 节"自我检验"：AI 出题、**留白给用户盲答**，答完对照第 3、4 节订正——这是本 skill 与"AI 替你总结"的本质区别
- "关键学习点用自己的话写，不搬 AI 原话"
- 针对反面提醒：要求"答完对照订正"，防止自说自话的虚假掌握
- v3 移除了独立的四级理解标尺（L1-L4），改为靠"能否盲答自测题"来检验掌握度——更直接

## Skill 工程规范

**来源**：[Anthropic 官方 Skill 编写最佳实践](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices)

**在本 skill 中的应用**：

- SKILL.md 精炼（<500 行），方法论细节放本文件按需加载（渐进式披露，一级引用不嵌套）
- description 含"做什么 + 何时触发"及关键词
- 工作流用可复制的 checklist；输出前跑质量自检反馈环（不通过→修→重审）
- 双模式给默认值（深度）+ 逃生口（快速），不提供过多并列选项
- 术语全程一致：复盘 / 时间线 / 根因链 / 尝试记录 / 关键学习点 / 行动项 / 自我检验
- 基于真实使用反馈持续做减法（v3 精简），而非一味加功能

## 间隔复习（仅作背景）

**来源**：遗忘曲线（Ebbinghaus）与间隔重复；实用节奏见 [1-3-7-14-30 天法](https://www.lexielearn.com/guides/spaced-repetition-study-method)、[BCU 2357 法](https://www.bcu.ac.uk/exams-and-revision/best-ways-to-revise/spaced-repetition)

**说明**：v3 起不再设固定复习排期（原 3 天 / 1 周 / 1 月三档已移除，用户反馈内容过重）。间隔复习的核心理念由"自我检验"节的盲答承担——即时检索练习仍是本 skill 的留存机制；固定日历排期留待用户自己在 Obsidian 任务里按需设置。
