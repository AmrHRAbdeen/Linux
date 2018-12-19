#!/bin/bash

user1="Amr"
user1_pss="1234"
user2="Abdeen"
user2_pss="5678"

read -p "Please , Enter your name: " user
read -p "Please , Enter your password: " pass

if [ $user ==  $user1 ] && [ $pass == $user1_pss ] 
then 
	echo "Hi , $user"
elif [ $user == $user2 ] && [ $pass == $user2_pss ] 
then
	echo "Hi , $user"
else
	echo "Sorry! You are not listed"
fi
