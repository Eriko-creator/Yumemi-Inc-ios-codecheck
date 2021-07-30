# 株式会社ゆめみ iOS エンジニアコードチェック課題

エンジニアの方にコードレビューをしていただきながら行いました。

## 環境

- Swift5.1
- Xcode12.4.1
- 開発ターゲット
- サードパーティーライブラリ：SwiftPackageManagerでAlamofire, MarkdownView, Lottieを使用

## 機能

- 検索ワードからレポジトリを検索し、結果一覧をTableViewに表示させる
- 特定の結果を選択したら、該当リポジトリのリポジトリ名、オーナーアイコン、プロジェクト言語、Star数、Fork数、Watcher数、OpenIssue数、Readmeを表示
- リポジトリの詳細画面のNavigationBar上のボタンを選択すると、githubのwebページを表示

## 工夫した点

- MVCアーキテクチャを採用し、疎結合なコードにするためAPI通信部分をプロトコル化し依存性注入を行った

- ユーザー視点の動作：
  - Loadingしていることが分かるようにLoadingViewControllerを作りポップアップを表示するようにした
  - ReadmeをLoadingしている時は既に表示が終了している他の部分の邪魔をしないよう、ポップアップを表示するのではなくActivityIndicatorを採用した
  - ユーザーが解決できるエラー、そうではないエラーに分け、UIAlertControllerを表示してエラー処理を行った


以下、課題の原文です。

# 株式会社ゆめみ iOS エンジニアコードチェック課題

## 概要

本プロジェクトは株式会社ゆめみ（以下弊社）が、弊社に iOS エンジニアを希望する方に出す課題のベースプロジェクトです。本課題が与えられた方は、下記の概要を詳しく読んだ上で課題を取り組んでください。

## アプリ仕様

本アプリは GitHub のリポジトリーを検索するアプリです。

![動作イメージ](README_Images/app.gif)

### 環境

- IDE：基本最新の安定版（本概要作成時点では Xcode 11.4.1）
- Swift：基本最新の安定版（本概要作成時点では Swift 5.1）
- 開発ターゲット：基本最新の安定版（本概要作成時点では iOS 13.4）
- サードパーティーライブラリーの利用：オープンソースのものに限り制限しない

### 動作

1. 何かしらのキーワードを入力
2. GitHub API（`search/repositories`）でリポジトリーを検索し、結果一覧を概要（リポジトリ名）で表示
3. 特定の結果を選択したら、該当リポジトリの詳細（リポジトリ名、オーナーアイコン、プロジェクト言語、Star 数、Watcher 数、Fork 数、Issue 数）を表示

## 課題取り組み方法

Issues を確認した上、本プロジェクトを [**Duplicate** してください](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/duplicating-a-repository)（Fork しないようにしてください。必要ならプライベートリポジトリーにしても大丈夫です）。今後のコミットは全てご自身のリポジトリーで行ってください。

コードチェックの課題 Issue は全て [`課題`](https://github.com/yumemi/ios-engineer-codecheck/milestone/1) Milestone がついており、難易度に応じて Label が [`初級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A初級+milestone%3A課題)、[`中級`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3A中級+milestone%3A課題+) と [`ボーナス`](https://github.com/yumemi/ios-engineer-codecheck/issues?q=is%3Aopen+is%3Aissue+label%3Aボーナス+milestone%3A課題+) に分けられています。課題の必須／選択は下記の表とします：

|   | 初級 | 中級 | ボーナス
|--:|:--:|:--:|:--:|
| 新卒／未経験者 | 必須 | 選択 | 選択 |
| 中途／経験者 | 必須 | 必須 | 選択 |

課題が完成したら、リポジトリーのアドレスを教えてください。
