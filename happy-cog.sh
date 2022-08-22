#################################
# Company Specific
#################################

# Vault
export VAULT_ADDR="https://vault.vmgdev.com:23387"
alias vmg-auth="vault auth -method=github && cat ~/.ssh/id_rsa.pub | vault write -field=signed_key ssh/sign/dev-role public_key=- > ~/.ssh/id_rsa-cert.pub"

VPN_IP=172.93.15.150
IP_CHECK_COUNT=0
SECONDS_TO_CHECK=30

# Connect/Disconnect from HC VPN:
function vpn () {
  echo "${COLOR_YELLOW}Connecting to the VPN${COLOR_DEFAULT}"
	networksetup -connectpppoeservice "Happy Cog"

	while [ "$(curl -s 'http://icanhazip.com/')" != $VPN_IP ]; do
		if (( IP_CHECK_COUNT > SECONDS_TO_CHECK )); then
			echo "${COLOR_RED}VPN didn't connect after $(echo $SECONDS_TO_CHECK) seconds. Exiting.${COLOR_DEFAULT}"
			exit 1
		fi
			
		echo "...waiting"
		IP_CHECK_COUNT=$(($IP_CHECK_COUNT+1))
		sleep 1
	done
	echo "${COLOR_GREEN}You're connected to the VPN! Your IP is $(echo $VPN_IP).${COLOR_DEFAULT}"
}
function dvpn () {
  echo "${COLOR_YELLOW}Disconnecting from the VPN${COLOR_DEFAULT}"
  networksetup -disconnectpppoeservice "Happy Cog"

  while [ "$(curl -s 'http://icanhazip.com/')" = $VPN_IP ]; do
		if (( IP_CHECK_COUNT > SECONDS_TO_CHECK )); then
			echo "${COLOR_RED}VPN didn't disconnect after $(echo $SECONDS_TO_CHECK) seconds. Exiting.${COLOR_DEFAULT}"
			exit 1
		fi
			
		echo "...waiting"
		IP_CHECK_COUNT=$(($IP_CHECK_COUNT+1))
		sleep 1
	done
	echo "${COLOR_GREEN}You've disconnected from the VPN!${COLOR_DEFAULT}"
}

# Sauce Labs
# Proxy Client
export PATH=/Users/chris/Shell/sauce-labs/bin:$PATH
# Connect
function hc-sauce-labs () {
  sc -u "hc_ben" -k "${SAUCELABS_KEY}"
}


# Connect to a Happy Cog Staging environment
function vmg() {
  ssh "$1@test.vmgdev.com" -A
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