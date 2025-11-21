# My Doom Emacs Configuration

这是我基于 [Doom Emacs](https://github.com/doomemacs/doomemacs) 的个人配置。

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
git clone <your-repo-url> ~/.config/doom

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
- ✨ Pretty symbols
- 📅 Agenda

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

## 许可

MIT License
