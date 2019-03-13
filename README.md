# terraform-provider-nutanix
Nutanix Terraform Provider - Examples with Windows VMs, Dynamic Rename &amp; Domain Join

1) Modify your path.xml to reflect your domain join creds
2) Modify your MultiVM.tf to reflect the number of VMs, Cluster information, UUIDs, and naming scheme
3) Make certain your source disk image has been properly sysprepped, otherwise they won't get joined to AD

This example was prepared on a Nutanix POC and leverage the AutoDC2 DC, so can easily be reproduced in an HPOC for bootcamp.
