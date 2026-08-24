#!/usr/bin/env bash
# self-learning-review 全局安装/更新脚本（macOS / Linux）
# 源 = 脚本所在目录；目标 = ~/.claude/skills/self-learning-review
# 用法：bash install.sh   （或 chmod +x install.sh && ./install.sh）

set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DST="$HOME/.claude/skills/self-learning-review"

if [ ! -f "$SRC/SKILL.md" ]; then
    echo "[错误] 未找到 SKILL.md，请确认脚本位于 self-learning-review 仓库根目录。"
    exit 1
fi

if [ -f "$DST/SKILL.md" ]; then
    ACTION="更新"
else
    ACTION="安装"
fi

echo "[信息] 源目录：$SRC"
echo "[信息] 目标目录：$DST"
echo "[信息] 操作：$ACTION (SKILL.md + templates + examples + references)"

mkdir -p "$DST"
cp "$SRC/SKILL.md" "$DST/SKILL.md"

for dir in templates examples references; do
    if [ -d "$SRC/$dir" ]; then
        rm -rf "$DST/$dir"
        cp -R "$SRC/$dir" "$DST/$dir"
    fi
done

echo ""
echo "[完成] self-learning-review 已${ACTION}到："
echo "       $DST"
echo ""
echo "下一步：新开一个 Claude Code 会话，输入 /self-learning-review 验证。"
