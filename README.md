# F5 AWS CloudFormation templates

## Introduction

This GitHub repository allows you to quickly create a Lab environment in AWS to run through the labs at https://clouddocs.f5.com/training/community/

For information on getting started using F5's CFT templates on GitHub, see [Amazon Web Services: Solutions 101](http://clouddocs.f5.com/cloud/public/v1/aws/AWS_solutions101.html) and the README files in each directory.  


Templates exists for
0) Topology  (3 lab subnets) 
1) Jumphost with utils(External)
2) LAMP Server (Internal)
3) Big-IP v14.0 
4) Big-IQ v6.0.1

NOTE: Depending on the number of Elastic IPs avaliable in your VPC, ypu may want to delete some of the assigned Eips AFTER the Big-IP has benn created.

Each template has an OUTPUT section and the EC2 Tags also give connectvity info.
Also default passwords (f5DEMOs4u!) are created and it is recommended you change these.

Befor eyou begin you will need some demo/eval keys for Big-IP (x1) and Big-IQ (x2:CM+DCD) 


**Important**: You may have to select the AWS region in which you want to deploy after clicking the Launch Stack button
<br><br>


**Lab setup**
- *Existing Stack* which includes an external IP address (typical)
  
  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/a.topology">**Topology**</a>, which builds 3 Subnets: Mngmt, external, Internal, inside a new VPC 
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=BigIp-3nic-BYOL&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/F5Lab-Toplogy-New-VPC-10-1-0-0-3subnet-IGW-latest.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>
   
  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/jumphost">**Jumphost**</a>, Linux xRDP Jumphost with Utils for Labs 
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=BigIp-3nic-BYOL&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/f5lab-jumphost-latest.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>

  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/server1">**Jumphost**</a>, LAMP Server with Lab Utils
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=BigIp-3nic-BYOL&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/f5lab-jumphost-latest.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>
   
  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/bigip-3nic">**Big-IP**</a>, Standalone Big-IPwith 10 IPs for lab use 
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=BigIp-3nic-BYOL&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/F5Lab-Big-IP-BYOL-3nic-Static-Mngmt-IP-10ips-latest.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>
   
  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/bigiq-cm-dcd">**Big-IQ_CM+DCD**</a>, Big-IQ Central Manager with a DCD for log collection. <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=BigIp-3nic-BYOL&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/F5Lab-Big-IQ-CM-DCD-Static-Mngmt-IP-RunScriptPairing-latest.template"> 
  <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>
  NOTE: After launch you need to run setup scripts on DCD then CM
   
   
  
---


### License


## Apache V2.0

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and limitations
under the License.


## Contributor License Agreement

Individuals or business entities who contribute to this project must have
completed and submitted the F5 Contributor License Agreement