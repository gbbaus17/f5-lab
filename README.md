# F5 AWS CloudFormation templates

## Introduction

This GitHub repository allows you to quickly create a Lab environment in AWS to run through the labs at https://clouddocs.f5.com/training/community/

For information on getting started using F5's CFT templates on GitHub, see [Amazon Web Services: Solutions 101](http://clouddocs.f5.com/cloud/public/v1/aws/AWS_solutions101.html) and the README files in each directory.  


Templates exsit for
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




**Standalone BIG-IP VE - 3 NICs**
- *Existing Stack* which includes an external IP address (typical)
  - <a href="https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/standalone/3nic/existing-stack/payg">**Hourly**</a>, which uses pay-as-you-go hourly billing 
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=BigIp-3nic-PAYG&templateURL=https://s3.amazonaws.com/f5-cft/f5-existing-stack-payg-3nic-bigip.template">  
   <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>
  - <a href="https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/standalone/3nic/existing-stack/byol">**BYOL**</a> (bring your own license), which allows you to use an existing BIG-IP license.  
    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=BigIp-3nic-BYOL&templateURL=https://s3.amazonaws.com/f5-cft/f5-existing-stack-byol-3nic-bigip.template">
    <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>
  - <a href="https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/standalone/3nic/existing-stack/bigiq">**BIG-IQ for licensing**</a>, which allows you to launch the template using an existing BIG-IQ device with a pool of licenses to license the BIG-IP VE(s).  <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=BigIp-3nic-BIGIQ&templateURL=https://s3.amazonaws.com/f5-cft/f5-existing-stack-bigiq-3nic-bigip.template">  
    <img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a>




- *Frontend via DNS*
    - <a href="https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/autoscale/waf/via-dns/1nic/existing-stack/payg">**Hourly**</a>, which uses pay-as-you-go hourly billing   
      <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=F5-Hourly-BIGIP-WAF-Autoscale-Dns&templateURL=https://s3.amazonaws.com/f5-cft/f5-payg-autoscale-bigip-waf-dns.template"><img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png"/></a> 
    - <a href="https://github.com/F5Networks/f5-aws-cloudformation/tree/master/supported/autoscale/ltm/via-dns/1nic/existing-stack/bigiq">**BIG-IQ for licensing**</a>, which allows you to launch the template using an existing BIG-IQ device with a pool of licenses to license the BIG-IP VE(s).    <a href="https://console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/new?stackName=F5-BYOL-BIGIP-WAF-Autoscale-Dns&templateURL=https://s3.amazonaws.com/f5-cft/f5-bigiq-autoscale-bigip-waf-dns.template">  
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