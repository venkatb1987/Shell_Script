#/bin/bash
#Program to do artimatic opreations

echo "enter two values "
read a b

c=`expr $a + $b`
echo "addition $a+$b=$c"

c=`expr $a - $b`
echo "subtraction $a-$b=$c"

c=`expr $a / $b`
echo "division $a/$b=$c"

c=`expr $a % $b`
echo "remainder $a%$b=$c"

exit 0
