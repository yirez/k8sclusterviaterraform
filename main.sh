#!/bin/sh
set -e
set -o pipefail
################################################################################################
################################################################################################
# WARNING: You need to create key-val pair terraformec2.pem for access to your generated ec2 instances
# terraformec2.pem must be in the same folder as this sh
# WARNING: You need to create an IAM to generate your instances via tf
# expected file secret.tfvars in /terra folder
################################################################################################
################################################################################################

echo "**************************************"
echo "Creates k8s cluster EC2 instances "
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
   echo "Usage: $0 "
   echo "WARNING: You need to create an IAM to generate your instances via tf"
   echo "expected file secret.tfvars in /terra folder"
   echo "WARNING: You need to create key-val pair terraformec2.pem for access to your generated ec2 instances"
   echo "terraformec2.pem must be in the same folder as this sh"
   exit 1
}

################################################################################################

echo " "
echo "Install terraform"
echo "**************************************"
if ! rpm -qa | grep -i "terra"
then
  yum install -y yum-utils
  yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
  yum install -y terraform
fi


echo " "
echo "Generate cluster ec2 instances"
echo "**************************************"
if test -f terraformec2.pem
then
   echo "INFO: .pem found"
else
   echo "ERROR: Necessary server key file (.pem) missing"
   exit 1
fi

cd terra
terraform init \
&& terraform plan -var-file=secret.tfvars \
&& terraform apply -var-file=secret.tfvars -auto-approve


echo " "
echo "Run kubespray setup"
echo "**************************************"
m1_ip="$(terraform output instance_test_cluster_m1_ip)"
w1_ip="$(terraform output instance_test_cluster_w1_ip)"
w2_ip="$(terraform output instance_test_cluster_w2_ip)"
cd .. && echo "moving to $(pwd)"
sh ./spray_dem_kubes.sh "${m1_ip}" \
"${w1_ip}" \
"${w2_ip}"
