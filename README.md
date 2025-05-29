[English](#english-version) | [中文](#中文-版本)

# 中文 版本

## 介绍

- 本仓库收录了武汉大学（**WHU**）2024–2025学年第二学期（**SP25**）“**Matlab**及其应用”课程的所有作业内容。所有内容均由笔者独立完成（尽管课程作业为小组形式）。

- 之所以只收录作业，是因为课程所用的 PPT 资料**过于老旧，内容杂乱**，且代码往往报错繁多。笔者的课程笔记大部分来源于老师讲授内容和 PPT，其中部分代码与数学公式直接照搬，精度与可读性均不佳。因此，将这些材料暂不纳入仓库；如日后有精力，或许会进行整理并补充说明。

- 本仓库共包括 9 次作业以及一次期末结课报告。最后一次作业因老师未提供数据且题目要求不够明晰，也未开放上传渠道，故未在此收录。但其余 8 次作业与结课报告**内容非常丰富**，完成后可基本掌握 Matlab 重要应用。笔者在完成过程中，发现部分题目思路不够直观、方向不易把握，甚至一些优化题目即使借助 AI 辅助，**也未必能得到最优结论**；但总体而言，**动手实践的收获远胜听课**。每份报告中均记录了题目描述、数据与详细代码思路，期望能帮助后续选修此课程的同学更快上手。也许在未来也能帮助到自己。

- 免责声明：报告里面所用方法并不一定正确或者最佳，代码也没有整理得很精炼，**请不要直接复制/抄袭**。

## 作业列表

1. **作业1：数据可视化**
2. **作业2：符号运算**
3. **作业3：最优化问题**
4. **作业4：插值和拟合问题**
5. **作业5：常微分方程数值解**
6. **作业6：数值积分**
7. **作业7：GUI 设计（笔者仿照GeoGebra写了一个app，感觉还挺有意思）**
8. **作业8：迭代和分形**
9. **结课报告：湖泊污染浓度计算（涉及常微分方程、拟合、处理噪声）**

> **说明**：第 9 次作业（原定）因缺少数据与明确要求，未在本仓库中收录。

完成上述内容后，可基本掌握 Matlab 在数据可视化、符号计算、优化、插值与拟合、常微分方程数值解、数值积分、GUI 开发以及图形迭代与分形等方面的主要应用。

## 使用说明

1. **下载与预览**

   * 克隆仓库至本地：

     ```bash
     git clone https://github.com/username/WHU-Matlab-SP25.git
     ```
   * 进入对应作业文件夹，可直接打开 PDF 报告与 `.m` 代码文件。
2. **依赖环境**

   * 应该没有要求？**Matlab R2022a** 及以上版本也许更好（部分函数可能与更高版本兼容更好）。笔者用到的是**Matlab R2024b**
   * 无额外第三方工具箱依赖，所有代码均基于 Matlab 内置函数实现。
3. **报告与代码说明**

   * 每个作业文件夹均包含：

     * `*.pdf`：作业报告，包含题目描述、代码思路、实验结果与分析。跑出来的图像。
     * `*code.m`：对应的 Matlab 源代码文件，可直接运行生成结果。
4. **致谢**
   特别感谢 WHU “Matlab及其应用”课程的任课老师与助教，及所有同学的讨论交流。若遇到疑问，欢迎在 Issues 中反馈，笔者将尽力解答。

---

# English Version

## Introduction

* This repository contains all assignments for the **Matlab and Its Applications** course offered by **Wuhan University (WHU)** in the **second semester of the 2024–2025 academic year (SP25)**. All content was independently completed by the author (despite the course being group-based).

* Only the assignments are included here because the lecture materials (PPTs) used in class were **too outdated, disorganized**, and often riddled with **error-prone code**. Most of the author’s notes come directly from the instructor’s lectures and slides; some of the code and math formulas were copied verbatim and may be inaccurate or hard to read. These were therefore not included in this repository. They may be organized and added later if time permits.

* This repository includes **8 regular assignments and 1 final project report** (out of a total of 9 expected assignments). The last regular assignment was excluded due to a lack of provided data and unclear instructions. There was also no channel opened for submission. Nevertheless, the remaining assignments and final report **cover a broad range of topics**, and by completing them, one can gain a solid grasp of most key Matlab applications.

* During the completion process, the author found some problems to be **non-intuitive and difficult to approach**, with multiple possible directions, and even **AI assistance couldn't always yield ideal results**. Nevertheless, **hands-on experience proved far more valuable than simply attending lectures**. Each report records the problem description, datasets, and code logic in detail—intended to help future students of this course get started more efficiently. Perhaps it may even benefit the author again someday.

* **Disclaimer**: The approaches used in these reports may not be the most accurate or optimal, and the code is not polished. **Please do not copy or plagiarize directly.**

## Assignment List

1. **Assignment 1: Data Visualization**
2. **Assignment 2: Symbolic Computation**
3. **Assignment 3: Optimization Problems**
4. **Assignment 4: Interpolation and Curve Fitting**
5. **Assignment 5: Numerical Solutions to ODEs**
6. **Assignment 6: Numerical Integration**
7. **Assignment 7: GUI Design** (The author created a GeoGebra-inspired app—pretty interesting!)
8. **Assignment 8: Iteration and Fractals**
9. **Final Report**: Pollution Concentration Modeling in Lakes (ODE, curve fitting, and noise processing)

> **Note**: The originally planned 9th assignment was not included due to lack of data and unclear requirements.

Completing these assignments provides practical experience in key Matlab applications such as data visualization, symbolic computing, optimization, interpolation/fitting, ODEs, numerical integration, GUI development, and graphical iteration/fractals.

## Usage Instructions

1. **Download and Preview**

   * Clone the repository:

     ```bash
     git clone https://github.com/username/WHU-Matlab-SP25.git
     ```

   * Navigate to any assignment folder to view the PDF report and `.m` code files.

2. **Environment Requirements**

   * No strict version requirements, but **Matlab R2022a or later** is recommended (for better compatibility). The author used **Matlab R2024b**.
   * No third-party toolboxes are needed—everything is based on built-in Matlab functions.

3. **Structure of Each Assignment Folder**

   * `*.pdf`: The assignment report, including problem statements, code logic, experimental results, and figures.
   * `*code.m`: The corresponding Matlab script that generates the results.

4. **Acknowledgements**

   Special thanks to the course instructor and teaching assistants of WHU’s “Matlab and Its Applications,” as well as to classmates for helpful discussions. If you have questions or find any issues, feel free to open an issue on GitHub. The author will try to respond.

---