# Doom Emacs 快速入门指南

> 配置仓库: https://github.com/Linguage/henri.doomemacs.config

## 🚀 立即开始

### 启动 Emacs
```bash
emacs
```

### 第一次使用
首次启动会看到 Doom 的欢迎界面。按 `?` 查看帮助。

## 📚 基础知识

### Leader 键
- **Normal 模式**: `SPC` (空格键)
- **Insert 模式**: 无 leader 键，需先按 `ESC` 回到 Normal 模式

### 退出 Emacs
- `SPC q q` - 退出
- `SPC q Q` - 强制退出（不保存）

## 🎯 最重要的 10 个快捷键

| 快捷键 | 功能 | 说明 |
|--------|------|------|
| `SPC h d h` | Doom 手册 | 查看 Doom 文档 |
| `SPC f f` | 查找文件 | 在当前目录查找 |
| `SPC SPC` | 项目文件 | 在项目中快速查找文件 |
| `SPC p p` | 切换项目 | 在多个项目间切换 |
| `SPC b b` | 切换 buffer | 切换已打开的文件 |
| `SPC .` | 浏览文件 | 使用 dired 浏览 |
| `SPC s s` | 搜索 buffer | 在当前文件搜索 |
| `SPC s p` | 搜索项目 | 在整个项目搜索 |
| `SPC g g` | Magit | 打开 Git 界面 |
| `SPC 0` | Treemacs | 显示/隐藏文件树 |

## 📝 编辑文件流程

1. **打开项目**
   ```
   SPC p p  → 选择项目
   ```

2. **查找文件**
   ```
   SPC SPC  → 输入文件名 → Enter
   ```

3. **编辑**
   - 按 `i` 进入 Insert 模式
   - 编辑内容
   - 按 `ESC` 回到 Normal 模式

4. **保存**
   ```
   SPC f s  或  :w
   ```

5. **关闭文件**
   ```
   SPC b d  或  :q
   ```

## 🔧 代码编辑

### 跳转
- `g d` - 跳转到定义
- `g r` - 查找引用
- `g D` - 跳转到实现
- `C-o` - 返回上一位置
- `C-i` - 前进到下一位置

### 代码操作
- `SPC c d` - 查看文档
- `SPC c a` - 代码操作（重构、修复等）
- `SPC c r` - 重命名符号
- `SPC c f` - 格式化代码

### 自动补全
- 输入代码时自动弹出补全
- `Tab` 或 `C-n` - 下一个选项
- `Shift-Tab` 或 `C-p` - 上一个选项
- `Enter` - 确认选择

## 🌳 项目管理

### Treemacs（文件树）
```
SPC 0        - 打开/关闭
在 Treemacs 中:
  h/j/k/l    - 导航
  RET        - 打开文件
  c          - 创建文件
  d          - 删除
  R          - 重命名
```

### Projectile（项目管理）
```
SPC p p      - 切换项目
SPC p f      - 查找文件
SPC p s      - 搜索项目
SPC p c      - 编译项目
SPC p r      - 运行项目
```

## 🐙 Git 操作（Magit）

```bash
SPC g g      # 打开 Magit status
```

在 Magit 中:
- `s` - Stage 文件/更改
- `u` - Unstage 文件/更改
- `c c` - Commit（输入消息后 `C-c C-c` 确认）
- `P p` - Push
- `F p` - Pull
- `b b` - 切换分支
- `b c` - 创建分支
- `q` - 退出

## 🪟 窗口管理

### 分割窗口
```
SPC w v      - 垂直分割
SPC w s      - 水平分割
SPC w d      - 删除当前窗口
SPC w o      - 只保留当前窗口
```

### 窗口导航
```
C-h          - 左边窗口
C-j          - 下边窗口
C-k          - 上边窗口
C-l          - 右边窗口
```

## 🔍 搜索和替换

### 搜索
```
SPC s s      - 在 buffer 中搜索
SPC s p      - 在项目中搜索
SPC s d      - 在目录中搜索
/            - 向下搜索（Vim 风格）
?            - 向上搜索（Vim 风格）
```

### 替换
```
SPC s r      - 在项目中替换
:%s/old/new/g  - Vim 风格替换（在当前文件）
```

## 📋 Org Mode 基础

### 创建笔记
```
SPC n n      - 查找/创建 Org-roam 笔记
SPC n i      - 插入笔记链接
SPC n c      - 快速捕获
```

### Org 编辑
- `Tab` - 折叠/展开标题
- `SPC m h` - 插入标题
- `SPC m t` - 切换 TODO 状态
- `SPC m s` - 排序
- `SPC m l` - 插入链接

## 🛠️ 实用工具

### 终端
```
SPC o t      - 打开终端（vterm）
SPC o T      - 打开终端（新窗口）
```

### 文件管理（Dired）
```
SPC .        - 打开 Dired
在 Dired 中:
  j/k        - 上下移动
  RET        - 打开文件/目录
  +          - 创建目录
  C          - 复制
  R          - 重命名/移动
  D          - 删除
  q          - 退出
```

## 🎨 主题和外观

### 切换主题
```
SPC h t      - 选择主题
```

### 字体大小
```
SPC t b      - 切换大字体模式
```

## 🆘 获取帮助

```
SPC h d h    - Doom 手册
SPC h d m    - Doom 模块文档
SPC h f      - 查找函数文档
SPC h v      - 查找变量文档
SPC h k      - 查看键绑定
K            - 查看光标下符号的文档
```

## 💡 提示

1. **不知道快捷键？** 按 `SPC` 然后等待，会出现提示菜单
2. **忘记命令？** 按 `SPC :` 或 `M-x` 可以搜索命令
3. **查看所有键绑定** `SPC h b b`
4. **恢复到之前的状态** Doom 会自动保存工作区，重启后恢复
5. **配置出问题？** 运行 `doom doctor` 诊断

## 📚 下一步学习

1. 阅读完整的 [README.md](README.md)
2. 浏览 [Doom 文档](https://docs.doomemacs.org/)
3. 学习 [Evil 模式](https://github.com/emacs-evil/evil)（Vim 键绑定）
4. 探索 [Magit 教程](https://magit.vc/)
5. 深入 [Org-mode](https://orgmode.org/)

## 🐛 遇到问题？

```bash
# 运行诊断
doom doctor

# 重新同步配置
doom sync

# 升级所有包
doom upgrade
```

祝你使用愉快！🎉
