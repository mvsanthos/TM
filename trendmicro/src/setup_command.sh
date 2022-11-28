inspect_args

os=${args[--os-name]}

if [ "$os" == "Debian" ] || [ "$os" == "Ubuntu" ]; then
        OS_PACKAGE_TYPE="deb"
        CERT_DIR="/usr/local/share/ca-certificates/"
        OS_NAME=$os
elif [ "$os" == "SUSE" ]; then
        OS_PACKAGE_TYPE="rpm"
        CERT_DIR="/usr/share/pki/trust/anchors/"
        OS_NAME="SuSE"
elif [ "$os" == "RedHatEnterprise" ]; then
        OS_PACKAGE_TYPE="rpm"
        CERT_DIR="/usr/share/pki/ca-trust-source/anchors/"
        OS_NAME="RedHat_EL"
elif [ "$os" == "Amazon" ]; then
        OS_PACKAGE_TYPE="rpm"
        CERT_DIR="/usr/share/pki/ca-trust-source/anchors/"
        OS_NAME="amzn"
else
        OS_PACKAGE_TYPE="rpm"
        CERT_DIR="/etc/pki/ca-trust/source/anchors/"
fi

echo "Operational System: ${os}"
echo "Package Type: ${OS_PACKAGE_TYPE}"
echo "Certificate Directory: ${CERT_DIR}"

openssl x509 -inform PEM -in certificates/trendmicroAtosSelfSigned.pem -out $CERT_DIR/trendmicroAtosSelfSigned.pem

if [ "$OS_NAME" = "Debian" ] || [ "$OS_NAME" = "Ubuntu" ]; then
    gpg --import certificates/new_agent.asc
    gpg --import certificates/new_agent.gpg

    echo "Trying to use update-ca-certificates..." && update-ca-certificates
else
    rpm --import certificates/new_agent.asc
    rpm --import certificates/new_agent.gpg
    
    echo "Trying to use update-ca-trust..." && update-ca-trust
fi;