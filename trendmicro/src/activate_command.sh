inspect_args

cloud_provider=${args[--cloud-provider]}
proxy=${args[--proxy]}

if [ $cloud_provider == "aws" ]; then
    TOKEN=`curl -s -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
    account_id=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document | jq -r .accountId`
    hostname=`curl -s -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/meta-data/hostname`
fi

if [ $cloud_provider == "azure" ]; then
    account_id=`curl -s -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | jq -r .compute.subscriptionId`
    hostname=`curl -s -H Metadata:true --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | jq -r .compute.name`
fi

if [ $cloud_provider == "gcp" ]; then
    account_id=`curl -s -H Metadata-Flavor:Goole --noproxy "*" "http://metadata.google.internal/computeMetadata/v1/project/project-id"`
    hostname=`curl -s -H Metadata-Flavor:Goole --noproxy "*" "http://metadata.google.internal/computeMetadata/v1/instance/hostname"`
fi

if [[ $proxy != "" ]];then
    echo "Configuring proxy: ${proxy}"
    /opt/ds_agent/dsa_control -x dsm_proxy://$proxy/
    /opt/ds_agent/dsa_control -y relay_proxy://$proxy/
fi

echo "Activating agent..."
/opt/ds_agent/dsa_control -a $ACTIVATION_DSM \
    tenantID:$TENANT_ID \
    tenantPassword:$TENANT_PW \
    policyid:$POLICY_ID \
    description:$account_id \
    displayname:$hostname

