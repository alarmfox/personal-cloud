#!/bin/bash

BASE_PATH=/git/projects

die () { echo "error:" $1 1>&2; exit 1; }

help() {
  echo "usage: $(basename $0) command [...args]"
  echo "  list, -l                    list all repositories"
  echo "  create, -c \"repo_name\"      create a new repository"
  echo "  delete, -d \"repo_name\"      delete a repository"
  echo "  publish, -p \"repo_name\"     make a repo visible to everyone"
  echo "  unpublish, -u \"repo_name\"   make a repo private"
  echo "  help, -h                    display help"
  exit 0
}

create_repo() {
  echo $1
  if [ -z $1 ]; then
    die "reponame is required."
  fi
  
  if ! [[ $1 =~ ^[a-zA-Z]+$ ]]; then
    die "invalid reponame; only characters are allowed."
  fi

  git init --bare $BASE_PATH/$1.git
}


list_repo() {
  ls $BASE_PATH | awk -F '.git' '{print $1}'
}

delete_repo() {
  if [ -z $1 ]; then
    die "reponame is required."
  fi
  printf "Are you sure? (Y/N): "
  read -p  confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

  rm -r $BASE_PATH/$1.git
}

publish_repo() {
  if [ -z $1 ]; then
    die "reponame is required."
  fi
  mv $BASE_PATH/.private/$1.git $BASE_PATH/$1.git
}

unpublish_repo() {
  if [ -z $1 ]; then
    die "reponame is required."
  fi
  mv $BASE_PATH/$1.git $BASE_PATH/.private/$1.git 
}

main() {

  case $1 in
    create | -c)
      create_repo $2
      ;;
    list | -l)
      list_repo
      ;;
    delete | -d)
      delete_repo $2
      ;;
    publish | -p)
      publish_repo $2
      ;;
    unpublish | -u)
      unpublish_repo $2
      ;;
    help | -h | *)
      help
      ;;
    esac
}

main $@
