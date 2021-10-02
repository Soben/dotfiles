#################################
# Wordpress Specific
#################################

# Wordpress Salt
alias wp_salt="curl -s https://api.wordpress.org/secret-key/1.1/salt/ | pbcopy"

# Allow quick connections to WPEngine SSH. `wpe {install}`
function wpe() {
  ssh "$1@$1.ssh.wpengine.net" -A
}

# Requires WP CLI

# @TODO Make this Docker switchable

# Import XML files in batch
function wpxmli () {
  # Make sure wordpress-importer is active
  docker-compose exec web wp plugin install wordpress-importer --activate --allow-root

  FILES="*.xml"

  for f in $FILES
  do
    echo "Processing $f file..."
      # take action on each file. $f store current file name
      docker-compose exec web wp import $f --authors=skip --skip=image_resize --allow-root 
  done
}