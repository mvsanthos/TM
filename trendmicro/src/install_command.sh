inspect_args

os=${args[--os-name]}
os_version=${args[--os-version]}

if [ "$os" == "Debian" ] || [ "$os" == "Ubuntu" ]; then
        OS_PACKAGE_TYPE="deb"
        CERT_DIR="/usr/local/share/ca-certificates/"
        OS=$os\_${os_version}
elif [ "$os" == "SUSE" ]; then
        OS_PACKAGE_TYPE="rpm"
        CERT_DIR="/usr/share/pki/trust/anchors/"
        OS_NAME="SuSE"
        OS=$OS_NAME\_${os_version}
elif [ "$os" == "RedHatEnterprise" ]; then
        OS_PACKAGE_TYPE="rpm"
        CERT_DIR="/usr/share/pki/ca-trust-source/anchors/"
        OS_NAME="RedHat_EL"
        OS=$OS_NAME${os_version}
elif [ "$os" == "Amazon" ]; then
        OS_PACKAGE_TYPE="rpm"
        CERT_DIR="/usr/share/pki/ca-trust-source/anchors/"
        OS_NAME="amzn"
        OS=$OS_NAME${os_version}
else
        OS_PACKAGE_TYPE="rpm"
        CERT_DIR="/etc/pki/ca-trust/source/anchors/"
fi

echo "Operational System: ${os}"
echo "Package Type: ${OS_PACKAGE_TYPE}"
echo "Certificate Directory: ${CERT_DIR}"

echo "Download agent"
wget_output=$(wget -q -P /tmp/ -c https://virusprotection.it-solutions.atos.net:4455/software/agent/$OS/x86_64/agent.$OS_PACKAGE_TYPE)
if [ $? -ne 0 ]; then
        echo "Failed to download TrendMicro Agent"
        exit 1
fi

echo "Install agent"
if [ "$OS_PACKAGE_TYPE" == "deb" ]; then
    dpkg -i /tmp/agent.deb
elif [ "$OS_PACKAGE_TYPE" == "rpm" ]; then
    rpm -ivh /tmp/agent.rpm
fi
echo "Start and enable ds_agent service"
systemctl start ds_agent
systemctl enable ds_agent