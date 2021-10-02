#################################
# Company Specific
#################################

# Vault
export VAULT_ADDR="https://vault.vmgdev.com:23387"
alias vmg-auth="vault auth -method=github && cat ~/.ssh/id_rsa.pub | vault write -field=signed_key ssh/sign/dev-role public_key=- > ~/.ssh/id_rsa-cert.pub"

# Connect/Disconnect from HC VPN:
function vpn () {
  networksetup -connectpppoeservice "Happy Cog"
}
function dvpn () {
  networksetup -disconnectpppoeservice "Happy Cog"
}

# Sauce Labs
# Proxy Client
export PATH=/Users/chris/Shell/sauce-labs/bin:$PATH
# Connect
function hc-sauce-labs () {
  sc -u "hc_ben" -k "${SAUCELABS_KEY}"
}

# Connect to a Happy Cog Staging environment
# $ hc medlink
function hc() {
  ssh "$1@test.happycogdev.com" -A
}
# Sudo access to server
function hc-sudo() {
  ssh "ec2-user@test.happycogdev.com" -A
}
function hc-vault() {
  vault ssh -mode=ca -role=dev-role "$1@test.happycogdev.com"
}

# Re-Login to the AWS account (pulling down Docker images from our host, for instance)
function hc-aws() {
  aws ecr get-login-password | docker login --username AWS --password-stdin "${HC_AWS_STORAGE}"
}

# GitHub - Public and Private Keys | Used for GitHub Actions for WPEngine
# Keys were generated normally using https://wpengine.com/support/ssh-keys-for-shell-access/#Generate_New_SSH_Key instructions
function gh-public() {
  cat ~/.ssh/github.pub | pbcopy
}
function gh-private() {
  cat ~/.ssh/github | pbcopy
}