#!/bin/bash

FILENAME="kubernetes.json"
DNSPREFIX="mycluster"
CLIENTID=""
CLIENTSECRET=""
SSHKEY=""
if [[ -f ~/.ssh/id_rsa.pub ]]; then
    SSHKEY=$(cat ~/.ssh/id_rsa.pub)
fi 

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -f|--file)
    FILENAME="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--dns-prefix)
    DNSPREFIX="$2"
    shift # past argument
    shift # past value
    ;;
    -c|--client-id)
    CLIENTID="$2"
    shift # past argument
    shift # past value
    ;;
    -s|--client-secret)
    CLIENTSECRET="$2"
    shift # past argument
    shift # past value
    ;;
    -k|--ssh-key)
    SSHKEY="$2"
    shift # past argument
    shift # past value
    ;;
    *)    # unknown option
    echo "Unknown argument $1"
    exit 1
    ;;
esac
done


[[ -z $CLIENTID ]] && echo "Please provide Client ID" && exit 1
[[ -z $CLIENTSECRET ]] && echo "Please provide Client Secret" && exit 1
[[ -z $SSHKEY ]] && echo "Please provide SSH Key" && exit 1

json=$(cat $FILENAME)

json=$(echo $json | jq ".properties.masterProfile.dnsPrefix = \"${DNSPREFIX}\"")
json=$(echo $json | jq ".properties.servicePrincipalProfile.clientId = \"${CLIENTID}\"")
json=$(echo $json | jq ".properties.servicePrincipalProfile.secret = \"${CLIENTSECRET}\"")
json=$(echo $json | jq ".properties.linuxProfile.ssh.publicKeys[0].keyData = \"${SSHKEY}\"")

echo $json