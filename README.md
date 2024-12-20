# PTE_RS_助手 v1.0.4

一个用于辅助PTE口语练习的网页应用，专注于 Repeat Sentence 练习部分。采用 iOS 设计风格，提供流畅的动画效果和友好的用户交互体验。

## 最新更新 (v1.0.4)
- 优化整体页面布局，确保单页展示
- 改进用户数据统计系统
- 优化高级设置面板展示
- 改进移动端适配体验
- 优化 Logo 设计和动画效果
- 新增页脚版权信息
- 修复用户数据同步问题
- 优化文件历史记录功能
- 新增加星标记功能
- 优化按钮样式和交互效果
- 新增搜索功能
- 优化内存占用

### 系统优化
- 改进用户数据存储机制
- 优化文件历史记录
- 完善学习统计功能
- 增强设备识别准确性
- 改进数据同步逻辑
- 优化页面布局结构
- 优化内存管理
- 改进安全性

## 功能特点

### 1. 文件处理
- 支持 Excel 文件上传（.xlsx 格式）
- 支持拖拽上传
- 智能提取句子内容
- 文件指纹识别，自动恢复历史记录
- 文件大小限制检查

### 2. 练习功能
- 句子打卡系统
- 练习次数统计（右下角显示）
- 自动打卡（练习5次后）
- 加星标记功能
- 添加个人备注
- 双栏布局展示
- 支持移动端适配

### 3. 数据管理
- 本地数据持久化存储
- 多文件数据独立保存
- 文件识别与历史记录
- 打卡进度统计
- 支持清除打卡记录
- 学习时长统计
- 连续打卡天数记录
- 加星句子管理

### 4. 交互设计
- iOS 风格界面
- 响应式布局
- 流畅动画效果
- 猫咪助手交互
  - 眼睛跟随鼠标移动
  - 说话动画效果
  - 确认对话框动画
  - 成就提示气泡
- 高级设置面板
- 页脚版权信息

### 5. 搜索功能
- 实时搜索
- 关键词高亮
- 清除搜索记录
- 搜索结果筛选

## 使用说明

### 基本操作
1. 上传文件：
   - 点击上传区域选择文件
   - 或直接拖拽文件到上传区域
   - 支持历史记录自动恢复

2. 练习功能：
   - ✓ 按钮：标记完成/取消完成
   - ▶ 按钮：记录练习次数（累计5次自动打卡）
   - ⭐ 按钮：加星标记重要句子
   - 📝 按钮：添加个人备注

3. 数据筛选：
   - 全部句子：显示所有内容
   - 已打卡：仅显示完成项
   - 已加星：显示重要句子
   - 支持实时统计更新

### 高级设置
- 查看设备识别信息
- 浏览学习统计数据
- 查看文件上传历史
- 统计学习时长
- 记录连续打卡天数

### 移动端支持
- 自适应布局
- 触摸优化
- 安全区域适配
- 横屏模式支持

## 技术实现

### 前端技术
- HTML5
- CSS3 
  - 动画与过渡效果
  - Grid 布局
  - Flexbox 布局
  - 媒体查询适配
  - 玻璃态设计
  - 自适应布局
- JavaScript (ES6+)
  - Promise
  - Async/Await
  - LocalStorage 数据存储
  - 设备指纹识别
  - 文件处理
  - Web Crypto API

### 外部依赖
- XLSX.js：Excel 文件处理

### 设计规范
- iOS 设计风格
- 响应式设计
- 动效交互
- 移动端优化

## 版本历史
- v1.0.4 - 2024.01: 新增加星功能，优化内存和安全性
- v1.0.3 - 2024.01: 优化整体布局，改进用户系统
- v1.0.2 - 2024.01: 新增用户系统，添加高级设置
- v1.0.1 - 2024.01: 初始版本发布

## iOS版本
iOS版本请查看 [iOS_version.md](iOS_version.md) 获取详细信息。