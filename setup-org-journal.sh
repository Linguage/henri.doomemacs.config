#!/bin/bash

# Org Journal 和 HTML 导出配置脚本
# 此脚本会创建必要的目录并下载 org-html-themes

set -e

NOTES_DIR="$HOME/Documents/EmacsNotes"
JOURNAL_DIR="$NOTES_DIR/Journal"
ROAM_DIR="$NOTES_DIR/roam"
THEMES_DIR="$NOTES_DIR/org-html-themes"

echo "🚀 开始设置 Org Journal 环境..."

# 创建基础目录
echo "📁 创建目录结构..."
mkdir -p "$JOURNAL_DIR"
mkdir -p "$ROAM_DIR"

# 创建日志文件（如果不存在）
create_journal_file() {
    local file=$1
    local title=$2
    
    if [ ! -f "$file" ]; then
        echo "📝 创建 $title..."
        cat > "$file" << EOF
#+TITLE: $title
#+STARTUP: overview
#+FILETAGS: :journal:

* $(date +%Y)

EOF
    fi
}

create_journal_file "$JOURNAL_DIR/diary.org" "个人日记"
create_journal_file "$JOURNAL_DIR/worklog.org" "工作日志"
create_journal_file "$JOURNAL_DIR/studylog.org" "学习日志"
create_journal_file "$JOURNAL_DIR/notes.org" "快速笔记"

# 下载 org-html-themes（如果不存在）
if [ ! -d "$THEMES_DIR" ]; then
    echo "🎨 下载 org-html-themes..."
    git clone https://github.com/fniessen/org-html-themes.git "$THEMES_DIR"
    echo "✅ org-html-themes 下载完成"
else
    echo "✅ org-html-themes 已存在"
fi

# 创建示例日记
EXAMPLE_FILE="$JOURNAL_DIR/example.org"
if [ ! -f "$EXAMPLE_FILE" ]; then
    echo "📖 创建示例文件..."
    cat > "$EXAMPLE_FILE" << 'EOF'
#+TITLE: Org Journal 示例
#+SETUPFILE: ~/Documents/EmacsNotes/org-html-themes/org/theme-readtheorg.setup
#+OPTIONS: toc:nil num:nil

* 欢迎使用 Doom Emacs Org Journal! 🎉

这是一个示例文件，展示如何使用日志系统。

** 快捷键

*** 创建日志
- ~SPC n j d~ - 创建个人日记
- ~SPC n j w~ - 创建工作日志  
- ~SPC n j s~ - 创建学习日志

*** 查看和管理
- ~SPC n j a~ - 打开 Agenda 视图
- ~SPC o A~ - Org Agenda (Doom 默认)

*** HTML 导出
- ~SPC n e h~ - 导出为 HTML 并在浏览器打开
- ~SPC n e t~ - 使用主题快速导出
- ~SPC n e a~ - 为当前文件应用 HTML 主题

** 日志模板

*** 个人日记模板
- 包含：今日要点、花销记录
- 标签：:journal:diary:

*** 工作日志模板  
- 包含：完成任务、问题和解决方案、明日计划
- 标签：:journal:work:

*** 学习日志模板
- 包含：主题与工作、要点笔记、资源链接
- 标签：:journal:study:

** HTML 导出预览

试试导出这个文件看看效果：

1. 按 ~SPC n e t~ 快速导出
2. 浏览器会自动打开显示美化后的 HTML

*** 代码示例

#+begin_src python
def hello_world():
    print("Hello from Org Journal!")
    return True
#+end_src

*** 表格示例

| 日期       | 任务     | 状态   |
|------------|----------|--------|
| 2025-11-21 | 配置Doom | 完成 ✅ |
| 2025-11-21 | 写日记   | 进行中 |

** 下一步

1. 按 ~SPC n j d~ 创建你的第一篇日记
2. 使用 ~SPC n j a~ 查看所有日志
3. 导出为 HTML 分享或归档

Happy journaling! 📝
EOF
fi

echo ""
echo "✅ 设置完成！"
echo ""
echo "📂 目录结构："
echo "   $NOTES_DIR"
echo "   ├── Journal/"
echo "   │   ├── diary.org     (个人日记)"
echo "   │   ├── worklog.org   (工作日志)"
echo "   │   ├── studylog.org  (学习日志)"
echo "   │   ├── notes.org     (快速笔记)"
echo "   │   └── example.org   (示例文件)"
echo "   ├── roam/             (Org-roam 笔记)"
echo "   └── org-html-themes/  (HTML 导出主题)"
echo ""
echo "🎯 快速开始："
echo "   1. 启动 Emacs"
echo "   2. 按 SPC n j d 创建日记"
echo "   3. 按 SPC n e t 导出为 HTML"
echo ""
echo "📚 查看示例："
echo "   emacs $EXAMPLE_FILE"
