#!/bin/bash
read -p "Please Enter val1 = " var1
read -p "Please Enter val2 = " var2
read -p "Please Enter + , - , / or * = " op

case $op in
	'+') echo $[$var1 + $var2] ;; # Addition operation
	'-') echo $[$var1 - $var2] ;; # Subtraction Operation
	'*') echo $[$var1 * $var2] ;; # Mul operation
	'/') echo $[ $var1 / $var2] ;; # Diision Operation
	*)
		echo "Invalid!Operation"
esac
