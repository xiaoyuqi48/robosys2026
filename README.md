# robosys2026

標準入力から受け取った数値を合計して、標準出力に表示するプログラムです。

## 使用方法

## average コマンド

標準入力から受け取った数値の平均値を計算して、標準出力に表示します。

使用例：

    seq 5 | ./average

実行結果：

    3.0

複数の数値も入力できます。

    printf "10\n20\n30\n" | ./average

実行結果：

    20.0

不正な入力や空入力の場合は、エラーメッセージを標準エラーに出力します。

Python 3 がインストールされた Linux 環境で実行できます。

    seq 5 | ./plus

実行結果：

    15

この例では、1から5までの数値を合計しています。

## テスト

GitHub Actions を利用して、プログラムのテストを自動実行します。

![test](https://github.com/xiaoyuqi48/robosys2026/actions/workflows/test.yml/badge.svg)

ローカル環境では、以下のコマンドでテストできます。

    bash ./test.bash

## 必要な環境

- Ubuntu Linux
- Python 3
- Bash

## ライセンス

- このソフトウェアパッケージは、3条項BSDライセンスの下、再頒布および使用が許可されています。
- このパッケージのコードは、下記のスライド（CC BY-SA 4.0 by Taro Suzuki）のものを著作としたものです。
  - https://github.com/tarolab-cit/lectures/tree/main/robosys2026
- © 2026 祁潤宇# robosys2026
