inspect_args

ACTIVATION=`/opt/ds_agent/dsa_query --cmd GetAgentStatus dsmCertHash`
status=$?
if [ $status -ne 0 ] || [ "$ACTIVATION" == "" ] || [ "$ACTIVATION" == *"couldn"* ]; then
    echo "Activation failed in Activation"
    exit 1
fi

COMPONENT_INFO=`/opt/ds_agent/dsa_query -c "GetComponentInfo"`
status=$?

if [ $status -ne 0 ] || [[ "$COMPONENT_INFO" != *"Component.AM.driverOffline: false"* ]]; then
    echo "Activation failed in Malware Driver"
    exit 1
else
    echo "Activation done"
    echo $COMPONENT_INFO
    echo $ACTIVATION
    exit 0
fi