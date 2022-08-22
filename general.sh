#################################
# General Config
#################################

export COLOR_DEFAULT="\033[0m" # No Color
export COLOR_RED="\033[0;31m"
export COLOR_GREEN="\033[0;32m"
export COLOR_YELLOW="\033[0;33m"

export APPLICATION_ENV="development"

export DOCK_UID=503
export DOCK_GID=20

#
# FUNCTIONS
#

# dns.toys shorthand
function dy ()
{
    dig +noall +answer +additional "$1" @dns.toys;
}

# Generate a new password, 45 characters long, of random characters, and send to pastebin
function pw ()
{
    opgen characters --length=45 --require=uppercase,lowercase,digits,symbols | pbcopy
}

# Generate a new password, using readable words, and send to pastebin
function pww ()
{
    opgen words | pbcopy
}

# Check the SSL Status of a URL
# $ sslcheck https://happycog.com
function sslcheck() {
    curl -vI "$@"
}

# Check the HTTP Status and Headers of a URL
# $ header happycog.com
function header() {
    curl -IL "$@"
}

# Determine the mimetype that's returned for a file
# $ mime robots.txt
function mime() {
  file --mime-type -b "$@"
}

function port() {
    lsof -i ":$@"
}

# Search a CSV in meaningful format
# https://til.simonwillison.net/sqlite/one-line-csv-operations?utm_source=tldrnewsletter
function csvs() {
    USAGE="$0 <file> <query> --mode=<mode>${NC}"

    if [ "$#" -lt "2" ]; then 
        echo -e $USAGE;
    else
        # Check File
        if [[ ! -f "$1" ]]; then
            echo -e "${RED}Invalid file.${NC}"
        else
            # Run Query
            sqlite3 :memory: -cmd ".mode column" -cmd ".import $1 temp" "$2"
        fi
    fi
}

# Remove all node_modules folders, recursively, from the folder you're in
# Be careful to not use this at too high of a system level. Can screw up
#    your global Node/Yarn.
function npm_clean {
    find . -name node_modules -exec rm -rf '{}' +
}

# Update Composer
function update_composer() {
    sudo /usr/local/bin/composer self-update && printf "${COLOR_GREEN}[ Composer has been updated! ]\n"
}

# Update WP-CLI
function update_wpcli() {
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && sudo mv wp-cli.phar /usr/local/bin/wp && printf "${COLOR_GREEN}[ WP-CLI has been updated! ]\n"
}

#
# ALIAS
#

# Find out what my IP address is.
alias ip="curl ifconfig.me/ip"
# Grab that IP and copy it to the pastebin.
alias ipc="curl ifconfig.me/ip | pbcopy"

# Displays, include color.
alias ls="ls -h"
alias ll="ls -al"

# Easy refresh
alias rp="source ~/.zshrc"

# Play some TRON: Cycle
alias tron="ssh sshtron.zachlatta.com"

#
# OTHER
#

# Z-Lib, making it find-able to package installers.
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"