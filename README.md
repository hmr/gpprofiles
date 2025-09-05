# Gpprofile(General Purpose Profiles)

もともとこのプロジェクトは私的な設定ファイルの集合で、つまりはよくあるDotfilesでした。

現在では一歩進め、快適なコンピューティング環境を短時間でセットアップすることが可能な仕組みを目指しています。

ターゲットはmacOSとUbuntu Linuxですが、それほど特殊なことをしているわけではないので、その他のLinuxやUnix類はもちろん、WindowsのWSLやCygwinまで適用可能ではないかなと思っています。

------------------

## 特徴

### 積極的[XDG Base Directory](https://wiki.archlinux.jp/index.php/XDG_Base_Directory)主義

ホームディレクトリがドットファイルだらけになっていませんか？

- シンプルなホームディレクトリ環境を保つため、gppでは積極的に[XDG Base Directory](https://specifications.freedesktop.org/basedir-spec/latest/)にドットファイル群を追い出しています。
- XDG Base Directoryに直接的に対応していないソフトウェア(例えばVim)も、各種の技を駆使してむりやり移動。
- 対応していないソフトウェアはなるべく使わない。

### CLI推進！

zsh環境を便利にするエイリアス＆関数群。

### ないものは作る。気が利くヘルパープログラムたち

#### jedid

近年のOSのGUIは昼と夜によってテーマが切り替わるようになっています。それに呼応してCLIでも表示色の設定を切り替えるデーモンです。

- [macOS] GUIを監視し、切り替わったことを検知してCLIも切り替えます。
- [Linux] IPアドレスから緯度経度を割り出し、当日の日の出/日の入りの時刻に合わせてCLIの表示色を切り替えます。

#### netlocd

Wi-FiのBSSIDの変化を監視し、macOSのネットワーク環境(というOSの機能)を切り替えるデーモンです。現在macOS 14 Sonomaと15 Sequoiaに対応。macOS 13以前は検証環境がないです…

## 今後の予定

- 収録対象のソフトウェアを増やす
- 収録済のソフトウェアもよりよいものに入れ替える
- Ansibleやcloud-initを使用し、実機も仮想環境も簡単にセットアップできるようにする。
