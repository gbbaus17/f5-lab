BIG-IQCentral Manager and Logging node Lab setup
================================================

With F5® BIG-IQ® Centralized Management (CM), you can securely manage traffic to your applications in AWS by using what F5 calls a Service Scaling Group (SSG).

From a centralized view, you can monitor the health and statistics of your applications as well as devices that are load balancing traffic and hosting applications. You can also set up alert thresholds to immediately notify you of certain events.

This CloudFormation Template (CFT) creates  a BIG-IQ CM instance to configure and orchestrate instances of BIG-IP VE, and a BIG-IQ Data Collection Device (DCD) to store analytics data.  


Instructions 
------------

To deploy this CFT in AWS, complete the following steps.



1. To get a BIG-IQ trial license, go to [F5 Cloud Edition Trial](https://f5.com/products/trials/product-trials).

2. Subscribe and accept the Terms and Conditions :

   * [F5 BIG-IQ Virtual Edition - (BYOL)](https://aws.amazon.com/marketplace/pp/B00KIZG6KA)

3. In the CloudFormation Template (CFT), populate this information:

   * Stack name 
   * Subnets 
   * If you did not do it previously, accept the BIG-IQ and BIG-IP license terms by visiting the URLs specified,
   clicking **Continue to Subscribe**, and accepting terms
   * BIG-IQ CM License Key (from F5 trial **BIG-IQ Console Node**)
   * BIG-IQ DCD License Key (from F5 trial **BIG-IQ Data Collection Device**)
   * SSH Key (your AWS key pair name)
   
   *Expected time: ~5 min*

5. Open the [EC2 console](https://console.aws.amazon.com/ec2/v2/home) and wait until the BIG-IQ instances are fully deployed.

   * Instance State: running
   * Status Checks: 2/2 checks passed

   *Expected time: ~5 min*

6. Use admin user and your AWS SSH key to SSH into the BIG-IQ DCD instance, then execute the following commands:

   ```
   # bash
   # /config/cloud/setup-dcd-xxxxx.sh
   ```

  * Let the scripts finish before moving to the next step.

   *Expected time: ~7 min*

7. Use admin user and your AWS SSH key to SSH into the BIG-IQ CM instance, then execute the following commands:

   ```
   # bash
   # /config/cloud/setup-cm-xxxxx.sh
   ```

   * Let the scripts finish before moving to the next step.

   *Expected time: ~7 min*
   
