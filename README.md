"# modular_multicloud_lab_v1"

Hello, This is a modular terraform script that will allow you to create a multi-cloud and multi-region lab for testing. By removing the line comments on the individual modules, you can initiate and provision that module.

This version currently only supports Azure and AWS, but I will be adding GCP.  I also plan to add instructional videos for those not familiar with Terraform or the Public Cloud providers.

Here are the current modules.

1) azu_base_ms2022_region1
    This creates the vnet, subnet, NIC, Public IP, Network Security group (allowing RDP and http), and a windows server 2022 with IIS installed.  The IIS is installed and configured automatically using the custom data.  This is instantiated in a single region.

2) azu_base_ms2022_region2
    Same as above #1 but in a different region

3) azu_base_ubuntu_region1
    Similar to above (#1 and #2) but with Ubuntu and nginx.  The nginx is also automatically installed and configured.  The Network Security group allows https and ssh.  (I recommend specifying your IP as the only source for SSH).  This is instantiated in a single region.

3)  azu_base_ubuntu_region2
    Same as above #3 but in a different region

4) azu_base_transit_vnet_region1
   Create a transit VNET in region1.  It will peer with the existing MS2022 and Ubuntu vnets.  I will also bring up a VNET Gateway configured for IPSEC VPN.  It will use the output of the branch model below to configure the VPN connection.

5) azu_base_transit_vnet_region1
   Same as above #4 but in the other region

5) azu_branch1_region1
   Creates a branch with VYOS router and connects to the Transit VNET 

Work in progress.  Please use for testing only.  Not secure enough for production

I will be creating weekly content on cloud-guru.com for those not familiar with Terraform or the Public Cloud Providers.  We will also harden this configuration over time so that it may be used in production.  We will discuss clodu security, CASB, CWPP, CSPM, CNAPP and pen testing   
