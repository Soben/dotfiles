#################################
# Project Specific
#################################

# MGHTY

## Mighty CLI https://github.com/the-mighty/cli
function mghty_jwt() {
  mighty token --wp_id 1 --role administrator | pbcopy
  print "Token fetch complete."
}

# OBM

## Middleware Google Cloud Platform GCP
alias obm_gcp_on="gcloud config configurations activate obm";
alias obm_gcp_off="gcloud config configurations activate default";