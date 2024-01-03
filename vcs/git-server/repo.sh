#!/bin/bash

BASE_PATH=$(pwd)/projects

choice=$1
die () { echo "error:" $1 1>&2; exit 1; }

create_repo() {
  if [ -z $1 ]; then
    die "reponame is required."
  fi
  
  if ! [[ $1 =~ ^[a-zA-Z]+$ ]]; then
    die "invalid reponame; only characters are allowed."
  fi
  repo_path=$BASE_PATH/$1.git
  git init --bare $repo_path 
}

list_repo() {
  ls $BASE_PATH | awk -F '.git' '{print $1}'
}

delete_repo () {
  if [ -z $1 ]; then
    die "reponame is required."
  fi
  read -p "Are you sure? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

  rm -r $BASE_PATH/$1.git
}

case $choice in
  create)
    create_repo $2
    ;;
  list)
    list_repo $2
    ;;
  delete)
    delete_repo $2
    ;;

esac
