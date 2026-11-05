#!/bin/bash
# SPDX-License-Identifier: BSD-3-Clause

set -e

# 正常な入力のテスト
result=$(seq 5 | ./average)
[ "$result" = "3.0" ]

result=$(printf "10\n20\n30\n" | ./average)
[ "$result" = "20.0" ]

# 空入力のテスト
if echo -n "" | ./average 2>/dev/null; then
    echo "空入力のテスト失敗"
    exit 1
fi

# 不正な入力のテスト
if echo "abc" | ./average 2>/dev/null; then
    echo "不正入力のテスト失敗"
    exit 1
fi

echo "OK"
