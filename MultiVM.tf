provider "nutanix" {
  username = "admin"
  password = "nx2Tech498!"
  endpoint = "172.21.30.199"
  insecure = true
  port     = 9440
}
locals{
  cluster1 = "000583da-5bbc-0a7f-0000-0000000177f7"
}
resource "nutanix_virtual_machine" "vm1" {
  count = 5
  name = "PR555B1WD${count.index}"
  num_vcpus_per_socket = 4
  num_sockets          = 1
  memory_size_mib      = 8096 
# Make absolutely certain that your disk image is sysprepped otherwise this will fail
  guest_customization_sysprep = [{
    install_type = "PREPARED"
    unattend_xml = "${base64encode("${replace("${file("path.xml")}", "REPLACE_ME", "PR555B1WD${count.index}")}")}"
  }]
    guest_customization_is_overridable=true  
  #power_state          = "OFF"
  cluster_reference = {
    kind = "cluster"
    uuid = "${local.cluster1}"
  }
  nic_list = [{
    # subnet_reference is saying, which VLAN/network do you want to attach here?
    subnet_reference = {
      kind = "subnet"
      uuid = "e3cbd3fd-814b-4a54-b62e-824457ebae4a"
    }}]
  disk_list = [{
    data_source_reference = [{
      kind = "image"
      uuid = "efa0b2c2-e897-4514-bab7-b89fbbb9bd60"
    }]
	}]
}
resource "nutanix_virtual_machine" "vm2" {
  count = 2
  name = "PR555B1CF${count.index}"
  num_vcpus_per_socket = 4
  num_sockets          = 1
  memory_size_mib      = 8096 
  guest_customization_sysprep = [{
    install_type = "PREPARED"
    unattend_xml = "${base64encode("${replace("${file("path.xml")}", "REPLACE_ME", "PR555B1CF${count.index}")}")}"
  }]
    guest_customization_is_overridable=true  
  #power_state          = "OFF"
  cluster_reference = {
    kind = "cluster"
    uuid = "${local.cluster1}"
  }
  nic_list = [{
    # subnet_reference is saying, which VLAN/network do you want to attach here?
    subnet_reference = {
      kind = "subnet"
      uuid = "e3cbd3fd-814b-4a54-b62e-824457ebae4a"
    }}]
  disk_list = [{
    data_source_reference = [{
      kind = "image"
      #Disk UUID of sysprepped VM
      uuid = "efa0b2c2-e897-4514-bab7-b89fbbb9bd60"
    }]
	}]
}




