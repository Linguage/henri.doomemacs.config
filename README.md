# My Doom Emacs Configuration

这是我基于 [Doom Emacs](https://github.com/doomemacs/doomemacs) 的个人配置。

**仓库地址**: https://github.com/Linguage/henri.doomemacs.config

## 安装

### 1. 安装 Emacs
```bash
brew install --cask emacs
```

### 2. 安装 Doom Emacs
```bash
git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
```

### 3. 使用此配置
```bash
# 备份原有配置（如果有）
mv ~/.config/doom ~/.config/doom.bak

# 克隆此配置仓库
git clone https://github.com/Linguage/henri.doomemacs.config.git ~/.config/doom

# 同步配置
~/.config/emacs/bin/doom sync
```

### 4. 添加到 PATH（可选）
```bash
echo 'export PATH="$HOME/.config/emacs/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

## 配置文件说明

- **init.el**: 模块配置，控制启用哪些 Doom 模块
- **config.el**: 个人配置，设置主题、键绑定、语言特定配置等
- **packages.el**: 额外的包声明
- **custom.el**: 机器特定的配置（不应提交到版本控制）

## 已启用的主要功能

### UI
- 🎨 Doom One 主题
- 🌲 Treemacs 项目浏览器
- 📊 相对行号
- ✨ 连字符支持
- 🎯 窗口选择

### 编辑器
- 👿 Evil 模式（Vim 键绑定）
- 📝 自动格式化（保存时）
- 🔄 多光标编辑
- 📋 代码片段

### 编程语言支持
- 🐍 Python (LSP + Pyright)
- 🦀 Rust (LSP)
- 🐹 Go (LSP)
- 📜 JavaScript/TypeScript (LSP)
- ☕ Java (LSP)
- 🌐 Web (HTML/CSS/JS)
- 📊 JSON/YAML
- 📄 Markdown
- 🎓 LaTeX
- 🔧 C/C++

### 工具
- 🔍 LSP (Eglot)
- 🌳 Tree-sitter
- 🐙 Magit (Git 客户端)
- 🐳 Docker 支持
- 📦 Direnv
- 🔨 Make 支持
- 📄 PDF 查看

### Org Mode
- 📝 Org Roam（笔记管理）
- 📓 Org Journal（日记/工作日志/学习日志系统）
- 📅 Agenda（自定义日志视图）
- 🌐 HTML 导出（org-html-themes 支持）
- ✨ Pretty symbols

## 常用命令

### Doom 命令
```bash
doom sync          # 同步配置更改
doom upgrade       # 升级 Doom 和包
doom doctor        # 诊断配置问题
doom env           # 更新环境变量
```

### Emacs 内快捷键（Evil 模式）

| 快捷键 | 功能 |
|--------|------|
| `SPC f f` | 查找文件 |
| `SPC f r` | 最近文件 |
| `SPC SPC` | 在项目中查找文件 |
| `SPC p p` | 切换项目 |
| `SPC b b` | 切换 buffer |
| `SPC s s` | 在 buffer 中搜索 |
| `SPC s p` | 在项目中搜索 |
| `SPC 0` | 切换 Treemacs |
| `SPC g g` | 打开 Magit |
| `SPC c d` | 查看文档 |
| `SPC c a` | 代码操作 |
| `g d` | 跳转到定义 |
| `g r` | 查找引用 |

## Org Journal 使用指南

### 初始化
```bash
# 运行设置脚本创建目录和下载主题
~/.config/doom/setup-org-journal.sh
```

### 快捷键

**创建日志**
- `SPC n j d` - 创建个人日记
- `SPC n j w` - 创建工作日志
- `SPC n j s` - 创建学习日志
- `SPC n j a` - 打开 Agenda 视图

**HTML 导出**
- `SPC n e h` - 导出为 HTML 并在浏览器打开
- `SPC n e t` - 使用 ReadTheOrg 主题导出（推荐）
- `SPC n e a` - 为当前文件应用 HTML 主题

### 日志模板

**个人日记** (diary.org)
- 今日要点
- 花销记录表格

**工作日志** (worklog.org)
- 完成任务
- 问题和解决方案
- 明日计划

**学习日志** (studylog.org)
- 主题与工作
- 要点笔记
- 资源链接

### Agenda 视图

在 Agenda 中按下列键查看不同视图：
- `j` - 日志概览（所有日志）
- `d` - 个人日记
- `w` - 工作日志
- `s` - 学习日志

### HTML 导出示例

查看示例文件：
```bash
emacs ~/Documents/EmacsNotes/Journal/example.org
```

然后按 `SPC n e t` 导出并预览。

## 定制化

### 修改主题
编辑 `config.el`:
```elisp
(setq doom-theme 'doom-gruvbox)  ; 或其他主题
```

### 添加新包
1. 在 `packages.el` 中声明包
2. 在 `config.el` 中配置包
3. 运行 `doom sync`

### 语言支持
在 `init.el` 中启用/禁用语言模块，然后运行 `doom sync`。

### 机器特定配置
复制 `custom.el.example` 到 `custom.el` 并编辑。这个文件不会被版本控制。

## 依赖

### 必需
- Emacs 29.1+
- Git
- ripgrep (搜索)

### 推荐
- fd (文件查找)
- shellcheck (shell 脚本检查)
- 各语言的 LSP server
  - Python: `pip install python-lsp-server`
  - Rust: 通过 rustup 自动安装
  - Go: `go install golang.org/x/tools/gopls@latest`
  - JavaScript: `npm i -g typescript-language-server`

## 故障排除

### 包安装失败
```bash
doom sync -u    # 强制更新所有包
```

### 字体显示问题
确保已安装 JetBrains Mono 字体：
```bash
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono
```

### LSP 不工作
```bash
doom doctor     # 检查诊断信息
```

## 资源

- [Doom Emacs 文档](https://docs.doomemacs.org/)
- [Doom Emacs Discord](https://discord.gg/doom-emacs)
- [Evil 模式指南](https://github.com/emacs-evil/evil)

## 作者

**Henri Pogat** ([@Linguage](https://github.com/Linguage))

## 许可

MIT License
