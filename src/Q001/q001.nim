#[
与えられた上限値まで3または5で割り切れる正の整数の総和を計算して出力するプログラム
]#

import math, strutils,system

const THREE: uint = 3
const FIVE: uint = 5

echo "Upper limt(num): "
let upperLimit = readLine(stdin).parseUInt()
echo "upperLimit is ", $upperLimit

var sum: uint64 = 0

#[単純にやろうとすると、こうなるけど無駄な計算が多い
for i in 1..upperLimit:
    if i mod 3 == 0 or i mod 5 == 0:
        sum += i
]#

#3の倍数を限界までリストに加える
if upperLimit >= THREE:
  let divNum = upperLimit div THREE
  for i in 1..divNum:
    sum += uint(i) * THREE

#5の倍数を限界までリストに加える(3との公倍数は除く)
if upperLimit >= FIVE:
  let divNum = upperLimit div FIVE
  for i in 1..divNum:
    if i mod 3 == 0:
      continue
    sum += uint(i) * FIVE

echo $sum
