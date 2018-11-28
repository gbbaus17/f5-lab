# F5 AWS CloudFormation templates

# Introduction

This GitHub repository allows you to quickly create a Lab environment in AWS to run through the labs at https://clouddocs.f5.com/training/community/ 


The CFTs 'foundations' are from F5 and Community contributed sources. The CFT coupling and logic has been modified by me to allow a lab environment to be easily created [mailto: g.boniface AT f5.com]


For information on getting started using F5's CFT templates on GitHub, see [Amazon Web Services: Solutions 101](http://clouddocs.f5.com/cloud/public/v1/aws/AWS_solutions101.html) and the README files in each directory.  


**In brief:** Make sure you are logged into AWS, have AWS keys created and will need to agree to T&Cs on images before launch


Templates exists for  

0) Topology  (3 lab subnets - run first) 
1) Jumphost with utils (Sits on External vlan - this is the entry into Lab) 
2) Big-IP v13 or v14.0 (attaches to above topology) 
3) LAMP Server (Sits on Internal vlan) 
4) Big-IQ v6.0.1 (optional) 

**NOTE**

For the BigIP - Depending on the number of Elastic IPs available in your VPC, you may want to **delete the assigned EIPs** AFTER the BigIP has been created.

Same for the 'LAMP Server'. 
It only needs a public IP during creation time. After that you can delete the EIP and access from the Jumphost

********************************

Each template has an **OUTPUT** section of Template and the **EC2 Tags** in Dashboard gives connectivity info.  
 - (Tip: You can Modify the template in Designer before launch if you want to remove the final 'Output' info and can edit the Tags in EC2 console if you dont want that info to show - **put there for ease of use with Lab)**

Also default passwords **(f5DEMOs4u!)** are created and it is recommended you change these.

Before you begin you will need some demo/eval keys Big-IQ (x2:CM+DCD), and optionally Big-IP (x1 if not using PAYG) 


**Important**: You will have to select the **AWS region** (eg Sydney) in which you want to deploy after clicking the **Launch Stack** button
<bra><br>


- *Lab Setup* which includes an external IP address
  
  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/a.topology">**Topology**</a>, which builds 3 Subnets: Mngmt, external, Internal, inside a new VPC 
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=F5LabTopology--YourName&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/F5Lab-Toplogy-New-VPC-10-1-0-0-3subnet-IGW-latest.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>

  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/jumphost">**Jumphost**</a>, Linux RDP Jumphost with Utils for Labs 
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=Jumphost-YourName&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/f5lab-jumphost-latest.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>   
   
  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/bigip-3nic">**Big-IP**</a>, Standalone (3 nic) Big-IP with **Optional 10 EC2 addresses for VIPs** 
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=F5BigIP-YourName&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/F5Lab-Big-IP-3nic-latest.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>
   
  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/server1">**LAMPServer**</a>, Web Sites, Pool members, and ASM Attack Servers
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=UbuntuServer1-YourName&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/f5lab-server1-4IPs-latest.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>
 
  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/bigiq-cm-dcd">**Big-IQ_CM+DCD**</a>, Big-IQ Central Manager with a DCD for log collection 
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=F5BigIQ-60-YourName&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/F5Lab-Big-IQ-CM-DCD-Static-Mngmt-IP-RunScriptPairing-latest.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>
   
    - **NOTE: For Big-IQ, After launch you need to connect/ssh and run setup scripts on DCD then CM.**
   
---

- *Additional*
  - <a href="https://github.com/gbbaus17/F5-Lab/tree/master/bigip-3nic">**Big-IP 2**</a>, 2nd Standalone (3 nic) -Optional for testing
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=F5BigIP2-YourName&templateURL=https://s3.amazonaws.com/f5lab-gbbaus17/F5Lab-Big-IP-3nic-UNIT2-latest.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>
  
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
