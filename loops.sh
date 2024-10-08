#!/bin/bash

USERID=$(id -u)

CHECk_ROOT(){
  if [ $USERID -ne 0 ]
  then
    echo "Please run the script with root previlages"
    exit 1
  fi
}
CHECk_ROOT
VALIDATE(){
  if [ $1 -ne 0]
  then
    echo "$2 is success"
  else
    echo "$1 is failure"
  fi
}

for package in $@
do
  dnf list installed package
  if [ $? -ne 0 ]
  then
    echo "$package is not installed, going to install"
    dnf install $package -y
    VALIDATE $? "Install $package"
  else
    echo "$package is already installed"
  fi
done