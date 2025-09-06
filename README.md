# Gpprofiles (General Purpose Profiles)

（下の方に日本語あります）

Originally, this project was simply a bunch of personal configuration files—also known as dotfiles.

Now, we've taken it a step further by aiming to create a system that lets you quickly set up a comfortable computing environment.

While our primary targets are macOS and Ubuntu Linux, we're not doing anything overly special. This means it should be applicable to other Linux or Unix variants, and even Windows WSL or Cygwin.

------------------

## Features

### Proactive [XDG Base Directory](https://specifications.freedesktop.org/basedir-spec/latest/) Approach

Is your home directory overflowing with dotfiles?

- To maintain a simple home directory environment, GPP actively pushes dot files into the XDG Base Directory.
- Using various techniques, GPP forcibly moves dotfiles out of software that is not explicitly compatible with the XDG Base Directory (e.g., Vim). - Avoid using software that is incompatible with the XDG Base Directory (e.g., Vim).
- Avoid using XDG Base Directory incompatible software (whenever possible).

### Promote CLI!

Aliases & functions to make your zsh environment more convenient.

### Pretty cool helper programs.

#### jedid

Like modern OS switches GUI themes between day and night, this daemon switches CLI display color settings.

- [macOS] Detects change of GUI and switches the CLI display colors accordingly.
- [Linux] Derives latitude/longitude from the IP address and switches the CLI display colors based on the sunrise/sunset times for that day.

#### netlocd

A daemon for macOS that monitors changes in Wi-Fi SSID/BSSID and switches macOS network environments. Currently supports macOS 14 Sonoma and 15 Sequoia. No testing environment available for macOS 13 or earlier...

## Future Plans

- Expand the range of supported software
- Replace existing software with better alternatives
- Use Ansible and cloud-init to enable easy setup on both physical machines and virtual environments.

------------------------------------------------------

# Gpprofiles (General Purpose Profiles)

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

近年のOSのGUIは昼と夜で自動的にテーマが切り替わるようになっています。このデーモンはCLIの表示色の設定を切り替えるデーモンです。

- [macOS] GUIを監視し、切り替わったことを検知してCLIも切り替えます。
- [Linux] IPアドレスから緯度経度を割り出し、当日の日の出/日の入りの時刻によってCLIの表示色を切り替えます。

#### netlocd

macOS用のデーモンで、Wi-FiのSSID/BSSIDの変化を監視し、ネットワーク環境を切り替えるデーモンです。現在macOS 14 Sonomaと15 Sequoiaに対応。macOS 13以前は検証環境がないです…

## 今後の予定

- 収録対象のソフトウェアを増やす
- 収録済のソフトウェアもよりよいものに入れ替える
- Ansibleやcloud-initを使用し、実機も仮想環境も簡単にセットアップできるようにする。
