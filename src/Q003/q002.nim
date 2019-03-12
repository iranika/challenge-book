import math

proc gcd(a: uint, b: uint): uint =
  if b == 0:
    result = a
  else:
    result = gcd(b, a mod b)


echo $gcd(35,21)