Using ACS Engine with Azure Government
=======================================

This repository contains some notes and scripts for working with ACS Engine. The examples are particularly focused on making things work in Azure Government.

Prerequisites
-------------

Make sure you have the following installed

* Bash shell (Linux or Linux subsystem in Windows)
* Azure CLI 2.0
* jq
* git

Installing ACS Engine
---------------------

```bash
#Download binary
wget https://github.com/Azure/acs-engine/releases/download/v0.17.0/acs-engine-v0.17.0-linux-amd64.zip

#Unzip and copy to location in path
unzip acs-engine-v0.17.0-linux-amd64.zip
mkdir -p ~/bin
cp acs-engine-v0.17.0-linux-amd64/acs-engine ~/bin/
```

Resource Group And Service Principal
------------------------------------

```bash
subscription=$(az account show | jq -r .id)

#Name and Location
rgname=mykubernetes
loc=usgovvirginia

#Create Group
rg=$(az group create --name $rgname --location $loc)
rgid=$(echo $rg | jq -r .id)

#Create the Service Principal and assign as contributor on group
sp=$(az ad sp create-for-rbac --role contributor --scopes $rgid)
```

Convert API Template
--------------------

There are a number of example templates available in the [acs-engine project](https://github.com/Azure/acs-engine) and you can find some in the [api-models](api-models/) folder. They all need to have service principal details, SSH keys and DNS prefix added. In this repository, there is a [script](scripts/convert-api.sh) for that. You can use it like this:

```bash
./scripts/convert-api.sh -c $(echo $sp | jq -r .appId) \
-s $(echo $sp | jq -r .password) -f kubernetes.json \
-d myClusterDns | jq -M . > converted.json
```

This will take the file `kubernetes.json` and convert it to `converted.json` with the details added. 

Deploying the cluster
---------------------

Last step is to deploy the cluster (per the `converted.json` definition):

```bash
acs-engine deploy --api-model converted.json \
--subscription-id $subscription --resource-group $rgname \
--location $loc --azure-env AzureUSGovernmentCloud
```

You will be prompted to perform device login with a browser. After authentication, the ARM deployment will start.