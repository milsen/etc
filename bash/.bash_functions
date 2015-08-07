#!/bin/bash --
# .bash_functions by Max Ilsen

backup_packages() {
  # create tmp-directory
  readonly TEMPDIR="/tmp/package-backup/"
  mkdir "${TEMPDIR}"

  # get package list and package status (auto or manual install)
  dpkg --get-selections | awk '!/deinstall|purge|hold/ {print $1}' > "${TEMPDIR}/packages.list.save"
  apt-mark showauto > "${TEMPDIR}/package-states-auto"
  apt-mark showmanual > "${TEMPDIR}/package-states-manual"

  # get package sources and keys
  find /etc/apt/sources.list* -type f -name '*.list' -exec bash -c 'echo -e "\n## $1 ";grep "^[[:space:]]*[^#[:space:]]" ${1}' _ {} \; > "${TEMPDIR}/sources.list.save"
  sudo cp /etc/apt/trusted.gpg "${TEMPDIR}/trusted-keys.gpg"
  sudo cp -R /etc/apt/trusted.gpg.d "${TEMPDIR}/trusted.gpg.d.save"

  # for ubuntu software center
  sudo cp /etc/apt/auth.conf "${TEMPDIR}/auth.conf"

  # zip files up and remove temporary directory
  zip -j "./package_backup.zip" "${TEMPDIR}/*"
  rm -r "${TEMPDIR}"
}

restore_packages() {
  if [ -f "$1" ]; then
    # create tmp-directory and extract files to it
    readonly TEMPDIR="/tmp/package-backup/"
    mkdir "${TEMPDIR}"
    unzip "$1" "${TEMPDIR}"

    # import keys and update
    sudo apt-key add "${TEMPDIR}/trusted-keys.gpg"
    sudo apt-get update

    # install packages and give them the right status
    xargs -a "${TEMPDIR}/packages.list" sudo apt-get install
    xargs -a "${TEMPDIR}/package-states-auto" sudo apt-mark auto
    xargs -a "${TEMPDIR}/package-states-manual" sudo apt-mark manual

    # remove temporary directory
    rm -r "${TEMPDIR}"
  else
    echo "'$1' is not a valid file to extract"
  fi
}


# most frequently used commands
mfu() {
  history | \
  awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " "  CMD[a]/count*100 "% " a;}' | \
  grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10
}


pretty_apt_search() {
    # filter apt-results for the actual word and print them out in columns
    apt-cache search "$@" | \
    grep --color=always "$@" | \
    sed -e "s/ - /\t/" | \
    column -s $'\t' -t;
}
