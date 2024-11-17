# PTE_RS_助手 iOS 版本 v1.0.4

## 项目结构

## 主要功能

### 1. 数据管理
- 用户数据持久化
- 文件处理与存储
- 学习进度统计
- 设备识别

### 2. 用户界面
- iOS 原生设计
- SwiftUI 实现
- 流畅动画
- 触觉反馈

### 3. 交互设计
- 猫咪助手
- 进度提示
- 手势操作
- 实时搜索

### 4. 系统集成
- iCloud 同步
- 本地存储
- 文件处理
- 设备识别

## 技术特性

### 1. SwiftUI 特性
- 声明式 UI
- 组件化设计
- 状态管理
- 动画系统

### 2. 性能优化
- 延迟加载
- 内存管理
- 缓存策略
- 动画性能

### 3. 安全特性
- 数据加密
- 安全存储
- 设备验证
- 错误处理

## 开发规范

### 1. 代码组织
- MVVM 架构
- 组件化设计
- 职责分离
- 代码复用

### 2. 文档规范
- 代码注释
- API 文档
- 使用说明
- 版本记录

## 后续计划
- Widgets 支持
- 快捷指令
- 语音识别
- iPad 优化

## 文件说明

### App 目录
- `PTE_RS_iOSApp.swift`: 应用程序入口点，配置环境对象
- `AppDelegate.swift`: 应用程序代理，处理生命周期事件

### Views 目录
- `ContentView.swift`: 主界面布局和导航结构
- `HeaderView.swift`: 顶部导航栏和标题区域
- `StatsView.swift`: 学习统计和进度显示
- `SearchBarView.swift`: 搜索功能实现
- `SentenceListView.swift`: 句子列表展示
- `SettingsView.swift`: 设置面板界面

### Components 目录
- `LogoView.swift`: 应用图标组件
- `CatView.swift`: 猫咪助手动画组件
- `SentenceItemView.swift`: 句子卡片组件
- `AssistantBubble.swift`: 助手提示气泡
- `FilterButton.swift`: 筛选按钮组件
- `FilterButtonGroup.swift`: 筛选按钮组组件
- `StatItem.swift`: 统计数据显示组件
- `SettingsButton.swift`: 设置按钮组件

### Models 目录
- `UserManager.swift`: 用户数据管理
- `StorageManager.swift`: 本地存储管理
- `SentenceItem.swift`: 句子数据模型
- `UserInfo.swift`: 用户信息模型
- `AssistantManager.swift`: 助手功能管理
- `FileProcessor.swift`: 文件处理逻辑

### Utils 目录
- `Constants.swift`: 全局常量定义
- `Extensions.swift`: Swift 扩展方法
- `HapticManager.swift`: 触觉反馈管理
- `ViewModifiers.swift`: 自定义视图修饰器
- `PreviewHelpers.swift`: SwiftUI 预览工具

### Resources 目录
- `Assets.xcassets`: 图片和颜色资源
- `Info.plist`: 应用配置信息

## 开发环境
- Xcode 15.0+
- iOS 15.0+
- Swift 5.9+
- SwiftUI 4.0+

## 构建说明
1. 克隆项目到本地
2. 使用 Xcode 打开 PTE_RS_iOS.xcodeproj
3. 选择目标设备或模拟器
4. 点击运行按钮开始构建

## 注意事项
- 确保 Xcode 版本兼容
- 检查所有依赖项是否正确安装
- 遵循 SwiftUI 和 iOS 设计规范
- 保持代码风格统一