#!/bin/bash
# SPDX-FileCopyrightText: 2026 祁潤宇
# SPDX-License-Identifier: BSD-3-Clause
#
# sparkline コマンドの回帰テスト。実行: bash ./test_sparkline.bash

ng () {
    echo "${1}行目のテスト失敗"
    res=1
}

res=0

### 1. 1から8まで（8段階すべてを使う） ###
out=$(seq 1 8 | ./sparkline)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "▁▂▃▄▅▆▇█" ] || ng "$LINENO"

### 2. 1から5まで（段階は飛ぶ） ###
out=$(seq 1 5 | ./sparkline)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "▁▂▄▆█" ] || ng "$LINENO"

### 3. すべて同じ値なら全部いちばん低い段階 ###
out=$(echo "5 5 5" | ./sparkline)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "▁▁▁" ] || ng "$LINENO"

### 4. 負の数も扱える ###
out=$(printf -- "-2\n-1\n0\n2\n" | ./sparkline)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "▁▂▄█" ] || ng "$LINENO"

### 5. 空白区切りでも読める ###
out=$(echo "1 2 3" | ./sparkline)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "▁▄█" ] || ng "$LINENO"

### 6. -l/-u で縮尺を固定できる ###
out=$(printf "0\n50\n100\n" | ./sparkline -l 0 -u 100)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "▁▄█" ] || ng "$LINENO"

### 7. 固定した範囲を超える値は最大の段階に丸める ###
out=$(echo 200 | ./sparkline -l 0 -u 100)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "█" ] || ng "$LINENO"

### 8. 値が1つなら1文字 ###
out=$(echo 7 | ./sparkline)
[ "$?" = 0 ] || ng "$LINENO"
[ "${out}" = "▁" ] || ng "$LINENO"

### 9. 空入力はエラー（終了ステータス1、標準出力なし） ###
out=$(echo -n "" | ./sparkline 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

### 10. 数値でない入力はエラー ###
out=$(echo "abc" | ./sparkline 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

### 11. エラーメッセージは標準エラーに出る ###
err=$(echo "abc" | ./sparkline 2>&1 >/dev/null)
[ -n "${err}" ] || ng "$LINENO"

### 12. 下限が上限以上ならエラー ###
out=$(echo 1 | ./sparkline -l 10 -u 0 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

### 13. -l のあとに数値がなければエラー ###
out=$(./sparkline -l 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"

### 14. --help は終了ステータス0で使い方を表示する ###
out=$(./sparkline --help)
[ "$?" = 0 ] || ng "$LINENO"
[ -n "${out}" ] || ng "$LINENO"

### 15. 不明なオプションはエラー ###
out=$(echo 1 | ./sparkline --unknown 2>/dev/null)
[ "$?" = 1 ] || ng "$LINENO"
[ "${out}" = "" ] || ng "$LINENO"

[ "${res}" = 0 ] && echo OK
exit $res
