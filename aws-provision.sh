#!/bin/bash
counterfile=.counter
echo "Run this from your AWS Academy Learner Lab Terminal Window"
basename=learndatabases
if [ ! -f "$counterfile" ]; then
        # create counter
        echo "0" > $counterfile
fi
counter=`cat $counterfile`
counter=$((counter+1))
name=$basename$counter
echo "You are about to provision ${name} to AWS. Press ENTER to continue, CTRL+C to abort"
read
echo $counter > $counterfile
echo "Starting the provisioning process for $name"

echo "Creating Security Group"
aws ec2 create-security-group --description ${name} --group-name ${name}
aws ec2 authorize-security-group-ingress --group-name ${name}  --protocol tcp --port 22 --cidr "0.0.0.0/0"
echo "Creating Key Pair"
aws ec2 create-key-pair --key-name ${name} --query "KeyMaterial" --output text > ${name}.pem
chmod 600 ${name}.pem

echo "Launching Instance"
instanceid=`aws ec2 run-instances --image-id ami-0d4fb65189c3b8d49 --count 1 --instance-type t3.medium --key-name ${name} \
--block-device-mappings "[{\"DeviceName\":\"/dev/sda1\",\"Ebs\":{\"VolumeSize\":40,\"DeleteOnTermination\":true}}]" \
--security-groups ${name} --query Instances[0].InstanceId`
instanceid=`echo "$instanceid" | tr -d '"'`
echo "Instance Id: ${instanceid}"

#Wait until values are output, this should be on loop, then store instance ID
echo "Waiting for instance to start (This might take a couple of minutes)"
id=null
while [ $id != $instanceid ]
do
        sleep 5
        echo -n  .
        id=`aws ec2 describe-instance-status --filter Name=instance-status.reachability,Values=passed  --query InstanceStatuses[0].InstanceId`
	id=`echo "$id" | tr -d '"'`
done
echo ""
echo "Instance ID: ${instanceid} has started"

#Get IP: using instance ID
echo "Getting Public DNS Name for this instance"
dns=`aws ec2 describe-instances --filter Name=instance-id,Values=$instanceid --query Reservations[0].Instances[0].NetworkInterfaces[0].PrivateIpAddresses[0].Association.PublicDnsName`
dns=`echo "$dns" | tr -d '"'`
echo "DNS Name: ${dns}"
# ssh in using public IP
echo "Accessing instance via ssh"
ssh  -i "${name}.pem" -o "StrictHostKeyChecking no"  ubuntu@${dns} ' \
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; \
    sudo chmod +x /usr/local/bin/docker-compose; \
    sudo ln -s  /usr/local/bin/docker-compose /usr/bin/docker-compose; \
    git clone https://github.com/mafudge/learn-databases.git'

echo
echo "Setup is complete. To access this instance, type: "
echo ssh  -i "${name}.pem" ubuntu@${dns}

