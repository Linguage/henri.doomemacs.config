# Doom Emacs 配置架构说明

## 📁 文件结构

```
~/.config/doom/
├── init.el              # 模块配置
├── config.el            # 个人配置
├── packages.el          # 额外包声明
├── custom.el            # 机器特定配置（不提交）
├── custom.el.example    # custom.el 模板
├── .gitignore          # Git 忽略规则
├── README.md           # 完整文档
├── QUICKSTART.md       # 快速入门
└── ARCHITECTURE.md     # 本文件
```

## 🏗️ 配置层次

### 1. init.el - 模块层
**作用**: 控制启用哪些 Doom 模块

**加载时机**: Doom 启动的第一步

**修改后**: 需要运行 `doom sync`

**示例结构**:
```elisp
(doom! :completion
       vertico           ; 启用 vertico 补全
       
       :ui
       doom              ; doom 主题系统
       treemacs          ; 文件树
       
       :editor
       (evil +everywhere) ; Vim 键绑定
       
       :tools
       (lsp +eglot)      ; LSP 支持
       magit             ; Git 客户端
       
       :lang
       (python +lsp)     ; Python 支持 + LSP
       (rust +lsp)       ; Rust 支持 + LSP
       
       :config
       (default +bindings +smartparens))
```

**模块标志**:
- `+flag` - 启用可选功能
- `-flag` - 禁用默认功能

### 2. packages.el - 包层
**作用**: 声明额外的包

**加载时机**: Doom 包管理器处理时

**修改后**: 需要运行 `doom sync`

**示例**:
```elisp
;; 从 MELPA 安装
(package! some-package)

;; 从 GitHub 安装
(package! another-package
  :recipe (:host github :repo "user/repo"))

;; 禁用包
(package! unwanted-package :disable t)

;; 固定版本
(package! pinned-package :pin "commit-hash")
```

### 3. config.el - 配置层
**作用**: 个人配置和定制

**加载时机**: Doom 启动的最后一步

**修改后**: 重启 Emacs 或 `M-x doom/reload`

**推荐结构**:
```elisp
;;; 基础设置
(setq user-full-name "Your Name"
      user-mail-address "email@example.com")

;;; UI 配置
(setq doom-theme 'doom-one
      doom-font (font-spec :family "JetBrains Mono" :size 14))

;;; 包配置
(after! package-name
  ;; 包的配置
  (setq package-variable value))

;;; 键绑定
(map! :leader
      :desc "Description" "key" #'function)

;;; 自定义函数
(defun my/custom-function ()
  "Documentation"
  (interactive)
  ;; function body
  )
```

### 4. custom.el - 机器特定层
**作用**: 机器特定的配置（不提交到版本控制）

**加载时机**: config.el 末尾

**用途**:
- 不同机器的字体大小
- 代理设置
- 工作相关的 API keys
- 特定项目路径

## 🔄 加载顺序

```
1. Doom 核心初始化
   ↓
2. init.el (模块声明)
   ↓
3. 模块加载
   ↓
4. packages.el (包安装/配置)
   ↓
5. 包加载
   ↓
6. config.el (用户配置)
   ↓
7. custom.el (机器特定配置)
   ↓
8. Emacs 就绪
```

## 🎯 配置原则

### DO ✅

1. **在 init.el 中**:
   - 启用/禁用模块
   - 使用模块标志 (`+flag`)
   - 保持简洁，主要是声明性的

2. **在 packages.el 中**:
   - 声明额外的包
   - 禁用不需要的包
   - 指定包来源（如果不在 MELPA）

3. **在 config.el 中**:
   - 使用 `after!` 包裹包的配置
   - 使用 `map!` 定义键绑定
   - 使用 `setq-default` 设置全局默认值
   - 创建自定义函数
   - 配置主题、字体等

4. **在 custom.el 中**:
   - 机器特定的配置
   - 敏感信息（使用环境变量）
   - 临时测试代码

### DON'T ❌

1. **不要在 config.el 中**:
   - 直接 `require` 包（使用 `after!` 或 `use-package!`）
   - 设置需要在包加载前的变量（放在 init.el）
   - 声明新包（放在 packages.el）

2. **不要在 init.el 中**:
   - 写复杂的配置逻辑
   - 设置变量（除了 Doom 变量）
   - 定义函数

3. **通用原则**:
   - 不要硬编码路径（使用 `expand-file-name` 和 `~`）
   - 不要在版本控制中存储敏感信息
   - 不要跳过 `doom sync`（模块/包更改后）

## 🔧 常见配置模式

### 1. 配置一个包
```elisp
(after! package-name
  (setq package-option value)
  (add-hook 'package-hook #'function))
```

### 2. 添加键绑定
```elisp
;; Leader 键绑定
(map! :leader
      :desc "Description" "k e y" #'function)

;; 模式特定绑定
(map! :after package
      :map package-mode-map
      :n "k" #'function)
```

### 3. 配置语言模式
```elisp
(after! language-mode
  (setq language-indent 4)
  (add-hook 'language-mode-hook #'my-setup-function))
```

### 4. 条件配置
```elisp
;; 基于操作系统
(when IS-MAC
  (setq mac-specific-option value))

;; 基于 Emacs 版本
(when (> emacs-major-version 28)
  (new-feature-enable))
```

### 5. 模块化配置
```elisp
;; 在 config.el 中加载额外文件
(load! "lisp/my-functions")
(load! "lisp/my-languages")
```

## 📝 最佳实践

### 1. 组织 config.el
按功能分组，使用清晰的注释：

```elisp
;;; Personal Information
;; ...

;;; UI Configuration
;; ...

;;; Editor Behavior
;; ...

;;; Programming
;; ...

;;; Language-specific
;; ...

;;; Custom Functions
;; ...
```

### 2. 使用 `after!`
确保配置在包加载后执行：

```elisp
;; 好 ✅
(after! magit
  (setq magit-diff-refine-hunk 'all))

;; 不好 ❌
(setq magit-diff-refine-hunk 'all)
```

### 3. 文档化自定义函数
```elisp
(defun my/custom-function ()
  "Clear documentation of what this does.
Can span multiple lines."
  (interactive)  ; 如果是命令
  ;; implementation
  )
```

### 4. 使用功能标志
利用 Doom 的模块标志而不是手动配置：

```elisp
;; 在 init.el 中
(python +lsp +pyright)  ; 而不是手动配置所有 LSP

;; 在 config.el 中只需微调
(after! python
  (setq python-indent-offset 4))
```

## 🔍 调试配置

### 1. 检查加载顺序
```elisp
;; 在配置中添加
(message "Loading my-config section")
```

### 2. 检查变量值
```
M-x describe-variable RET variable-name
```

### 3. 检查函数
```
M-x describe-function RET function-name
```

### 4. 重新加载配置
```
M-x doom/reload  ; 或 SPC h r r
```

### 5. 诊断问题
```bash
doom doctor
```

## 📚 扩展阅读

- [Doom Emacs 模块索引](https://docs.doomemacs.org/#/modules)
- [Doom Emacs API](https://docs.doomemacs.org/#/api)
- [Emacs Lisp 介绍](https://www.gnu.org/software/emacs/manual/html_node/eintr/)
