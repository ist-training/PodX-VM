
  output "DC_ID1" {
  description = "id of vSphere Datacenter"
  value       = data.vsphere_datacenter.dc.id
}

output "my_ip_address" {
 value = "${vsphere_virtual_machine.vm.default_ip_address}"
}

output "VM_Name" {
  description = "VM Names"
  value       = vsphere_virtual_machine.vm.name
}

output "VM-uuid" {
  description = "UUID of the VM in vSphere"
  value       = vsphere_virtual_machine.vm.uuid
}

