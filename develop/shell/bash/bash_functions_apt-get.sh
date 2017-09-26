#!/bin/bash --
#
# "XDG_CONFIG_HOME"/bash/bash_functions_apt-get.sh by milsen
#

backup_packages() {
  # create tmp-directory
  readonly TEMPDIR="/tmp/package-backup/"
  mkdir "${TEMPDIR}"

  # get package list and package status (auto or manual install)
  dpkg --get-selections | awk '!/deinstall|purge|hold/ {print $1}' \
    > "${TEMPDIR}packages.list.save"
  apt-mark showauto > "${TEMPDIR}package-states-auto"
  apt-mark showmanual > "${TEMPDIR}package-states-manual"

  # get package sources and keys
  find /etc/apt/sources.list* -type f -name '*.list' -exec bash -c \
    'echo -e "\n## $1 ";grep "^[[:space:]]*[^#[:space:]]" ${1}' _ {} \; \
    > "${TEMPDIR}sources.list.save"
  sudo cp /etc/apt/trusted.gpg "${TEMPDIR}trusted-keys.gpg"
  sudo cp -R /etc/apt/trusted.gpg.d "${TEMPDIR}trusted.gpg.d.save"

  # for software gotten via ubuntu software center
  if [[ -r "/etc/apt/auth.conf" ]]; then
    sudo cp /etc/apt/auth.conf "${TEMPDIR}auth.conf"
  fi

  # zip files up and remove temporary directory
  zip -j "./package_backup.zip" "${TEMPDIR}"*
  rm -r -f "${TEMPDIR}"
}


# takes a zip-archive as an argument that was created using backup_packages()
restore_packages() {
  if [ -f "$1" ]; then
    # create tmp-directory and extract files to it
    readonly TEMPDIR="/tmp/package-backup/"
    mkdir "${TEMPDIR}"
    unzip "$1" "${TEMPDIR}"

    # import keys and update
    sudo apt-key add "${TEMPDIR}trusted-keys.gpg"
    sudo apt-get update

    # install packages and give them the right status
    xargs -a "${TEMPDIR}packages.list" sudo apt-get install
    xargs -a "${TEMPDIR}package-states-auto" sudo apt-mark auto
    xargs -a "${TEMPDIR}package-states-manual" sudo apt-mark manual

    # remove temporary directory
    rm -r -f "${TEMPDIR}"
  else
    echo "'$1' is not a valid zip-archive."
  fi
}


# remove all config files of removed packages
purge_config_files() {
  dpkg --list | egrep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge
}


# show apt-cache search results in columns using less
pretty_apt_search() {
  apt-cache search "$1" | \
    sed -e "s/ - /\t/" | \
    column -s $'\t' -t | \
    sort | \
    egrep -i --color=always "$1|$" | \
    less -R
}


# get history of apt-commands
apt-history(){
  case "$1" in
    install|upgrade|remove)
      cat /var/log/{dpkg.log,dpkg.log.1} | sort | grep "$1 "
          ;;
    rollback)
      cat /var/log/{dpkg.log,dpkg.log.1} | sort | grep upgrade | \
              grep "$2" -A10000000 | \
              grep "$3" -B10000000 | \
              awk '{print $4"="$5}'
          ;;
    *)
      cat /var/log/{dpkg.log,dpkg.log.1} | sort | less
          ;;
  esac
}
