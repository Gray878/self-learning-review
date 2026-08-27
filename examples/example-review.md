---
date: 2026-08-24
tags: [docker, 依赖管理, 部署, 排错]
---

# Coding Session Review

> 主题：FastAPI 报表服务新增 Excel 导出 + Docker 部署缺依赖排查
> 项目 / 技术栈：FastAPI + pandas（openpyxl）+ Docker（python:3.11-slim）

## 1. 任务概览

**目标**：为 FastAPI 报表服务新增"导出 Excel"接口，部署到服务器供业务方使用。

**完成内容**：Excel 导出接口完成，本地与 Docker 部署环境均正常。
绕路：中途一度改为 CSV 导出规避依赖，已回退。

## 2. 时间线

| 阶段 | 做了什么 | 结果 | 性质 |
|---|---|---|---|
| 1 | 用 pandas `to_excel()` 实现导出接口 | 本地一次跑通 | 🔵 |
| 2 | 部署到 Docker 服务器，调用接口 | 500：`ModuleNotFoundError: No module named 'openpyxl'` | 🔴 |
| 3 | 按 AI 建议在宿主机 `pip install openpyxl` | 无效，错误依旧 | 🟡 |
| 4 | `docker exec` 进容器安装 | 当时生效，容器重建后复发 | 🟡 |
| 5 | 改成导出 CSV 绕开依赖 | 可用，但下游只收 Excel，回退 | 🟡 |
| 6 | requirements.txt 补声明 + 重建镜像 | 解决 | 🔵 |

## 3. 遇到的问题

### 问题 1：本地正常，Docker 部署后报 `ModuleNotFoundError: No module named 'openpyxl'`

**问题**：本地调用导出接口正常；部署后调用返回 500，日志报缺 openpyxl。排查加绕路合计约 1 小时。

**根因链**：

```
表象：容器内调用 to_excel() 报缺 openpyxl
为什么 → 镜像里没有安装 openpyxl
为什么 → requirements.txt 没有声明它，镜像按清单构建
为什么 → 本地 pip install 后没有同步依赖清单的习惯
根因：依赖变更只存在于"环境实例"（本地 venv），从未进入"环境定义"（requirements.txt）
```

**解决方案**：requirements.txt 声明 openpyxl，重新 build 镜像。有效原因：容器环境的依赖必须落在"环境定义"上，重建才可复现。

**尝试记录**：

| 尝试 | 结果 | 为什么 |
|---|---|---|
| 宿主机 `pip install openpyxl` | ❌ 失败 | 报错发生在容器内，装到宿主机 Python 环境不影响容器 |
| `docker exec` 进运行中的容器安装 | ⚠️ 当时生效，重建后复发 | 包只进了当前容器实例的可写层，没进镜像 |
| 改为导出 CSV | ⚠️ 可用但回退 | 下游只接受 Excel，绕路不满足真实需求 |
| requirements.txt 声明 + 重建镜像 | ✅ 成功 | 依赖进入镜像定义，每次重建都自带 |

**下次更早发现的信号**："本地正常、部署报错"出现的第一秒就该问：报错的环境和正常运行的环境是同一个吗？缺模块类报错先查依赖清单差异，再动手装包。

## 4. 关键学习点

- pandas 的 `to_excel()` 不自带 Excel 写引擎，`.xlsx` 走 openpyxl——装了 pandas 不等于能导 Excel
- Docker 镜像是"环境定义"，运行中的容器是"定义 + 可写层"；`docker exec pip install` 只改可写层，重建即丢
- "本地正常、部署报错"先确认报错发生在哪个环境，再修那个环境

## 5. 行动项

| 触发条件 | 动作 |
|---|---|
| 下次本地 `pip install` 新包 | 装完立即同步进 requirements.txt，再提交代码 |
| 下次遇到"本地正常、部署报错" | 第一步先对比两端依赖清单，不先装包 |
| 下次想 `docker exec` 进容器改东西 | 停——改为改定义文件后重建，热补丁只用于临时止血并要记下来 |

## 6. 自我检验

先不看上文，用自己的话回答（答完再对照第 3、4 节订正）：

1. 为什么 `docker exec` 进容器装了包、容器重建后就没了？
2. 装了 pandas 为什么导出 Excel 还需要 openpyxl？
