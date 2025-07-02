# Flutter Reader

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue.svg) ![License](https://img.shields.io/badge/License-MIT-green.svg) ![Platform](https://img.shields.io/badge/Platform-iOS%20%7C%20Android-lightgrey.svg)

一个使用 Flutter 构建的、开源的、跨平台的阅读应用。灵感来源于经典的安卓阅读应用 [hectorqin/reader](https://github.com/hectorqin/reader)。

**我们的愿景是：打造一款高性能、UI 精美、高度可定制的免费阅读工具。**

---

### ✨ 主要功能

*   **📚 书架管理**: 网格与列表模式自由切换，书籍更新实时提醒，支持书籍分组与置顶。
*   **🌐 强大的书源系统**:
    *   与 `Reader` 社区书源规则兼容。
    *   支持通过网络链接、本地文件导入书源。
    *   自由编辑、校验、管理你的书源。
*   **🔍 全局搜索**: 同时在多个书源中快速搜索你想要的书籍。
*   **📖 沉浸式阅读体验**:
    *   多种翻页动画（仿真、滚动、覆盖）。
    *   自定义主题、背景、字体、字号和间距。
    *   支持深色模式与护眼模式。
    *   阅读进度自动同步。
*   **🎧 扩展功能**: 支持 TTS 听书、内容净化（去广告）、WebDAV 备份与恢复。

---

### 🚀 技术栈

*   **框架**: Flutter
*   **语言**: Dart
*   **状态管理**: Riverpod
*   **网络请求**: Dio
*   **数据持久化**: Isar Database
*   **HTML/XPath 解析**: html / xpath_selector
*   **依赖注入**: get_it

---

### 🏁 快速开始

1.  **克隆项目**
    ```bash
    git clone https://github.com/xiongmao-p/freader.git
    cd freader
    ```

2.  **安装依赖**
    
    ```bash
    flutter pub get
    ```
    
3.  **运行代码生成器 (如果使用 Isar 等)**
    
    ```bash
    dart run build_runner build
    ```
    
4.  **运行应用**
    ```bash
    flutter run
    ```

---

### 🤝 贡献

我们欢迎任何形式的贡献！无论是提交 Bug、建议新功能还是直接贡献代码。请参考我们的 [**开发与贡献指南**](./CONTRIBUTING.md)。

---

### ⚠️ 免责声明

本应用是一个开源的阅读工具，旨在提供一个纯粹的阅读环境。**应用本身不提供任何书籍内容**。所有数据均来源于用户自行导入的书源，其内容合法性由书源提供方和用户自行负责。请在遵守当地法律法规的前提下使用本应用。
