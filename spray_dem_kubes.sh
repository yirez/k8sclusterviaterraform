#!/bin/sh
set -e
set -o pipefail
################################################################################################
################################################################################################
# WARNING: You need to create key-val pair terraformec2.pem for access to your generated ec2 instances
# terraformec2.pem must be in the same folder as this sh
################################################################################################
################################################################################################

echo "**************************************"
echo "Creates k8s cluster using kubespray with a master node and 2 worker nodes"
echo "**************************************"
echo ""
echo ""

################################################################################################
# Default Help bits
#####################
# Exit script after printing help
helpFunction()
{
   echo ""
   echo "Usage: $0 masternode_public_ip workernode_public_ip workernode2_public_ip"
   echo "WARNING: You need to create key-val pair terraformec2.pem for access to your generated ec2 instances"
   echo "terraformec2.pem must be in the same folder as this sh"
   exit 1
}

# Begin script in case all parameters are correct
# TODO: read an array of nodes for both masters and workers
echo "master: $1"
echo "node1: $2"
echo "node2: $3"

masternode_public_ip=$1
workernode_public_ip=$2
workernode2_public_ip=$3
cluster_name="k8s_aws_group"

# Print helpFunction in case parameters are empty
if [ -z "$masternode_public_ip" ] || [ -z "$workernode_public_ip" ] || [ -z "$workernode2_public_ip" ]
then
   echo "Missing parameters";
   helpFunction
fi

################################################################################################

echo " "
echo "Checking if .pem exist in terra/terraformec2.pem folder"
echo "**************************************"
if test -f terraformec2.pem
then
   echo "INFO: .pem found"
   cp terraformec2.pem kubespray/terraformec2.pem
else
   echo "ERROR: Necessary server key file (.pem) missing"
   exit 1
fi

echo " "
echo "Grabbing kubespray from git repo"
echo "**************************************"
rm -rf kubespray
git clone https://github.com/kubernetes-sigs/kubespray.git \
&& cd kubespray

echo " "
echo "Installing kubespray requirements"
echo "**************************************"
if pip3 install -r requirements.txt
then
   echo "kubespray requirements installed"
else
   yum -y install python3 && yum -y install python3-pip && pip3 install -r requirements.txt
fi

echo " "
echo "Copy inventory/sample to our cluster config folder"
echo "**************************************"
cp -rfp inventory/sample inventory/${cluster_name}

echo " "
echo "Update Ansible inventory file with inventory builder "
echo "**************************************"
declare -a IPS=(${masternode_public_ip} ${workernode_public_ip} ${workernode2_public_ip})
CONFIG_FILE=inventory/${cluster_name}/hosts.yaml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

#TODO add sed to modify below files
echo " "
echo "Review and change parameters under inventory/$cluster_name"
echo "**************************************"
vi inventory/${cluster_name}/group_vars/all/all.yml \
&& vi inventory/${cluster_name}/group_vars/k8s_cluster/k8s-cluster.yml \
&& vi inventory/${cluster_name}/inventory.ini \
&& vi inventory/${cluster_name}/hosts.yaml

echo " "
echo "Run kubespray playbook"
echo "**************************************"
read -p "Ready? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
ansible-playbook -i inventory/${cluster_name}/hosts.yaml  --private-key=terraformec2.pem --become --become-user=root --user=ec2-user cluster.yml
