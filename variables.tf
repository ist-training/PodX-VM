variable "vsphere_user" {
  type = string
  description = "the username for vsphere"
}
variable "vsphere_password" {
  type = string
  description = "The password for vsphere"
}
variable "vsphere_server" {
  type = string
  description = "the hostname or ip address of your vcenter server"
  default = "10.154.8.166"
}

variable "vsphere_datacenter" {
  type = string
  description = "the name of the datacenter"
  default = "IST_DC"
}

variable "vsphere_datastore" {
  type = string
  description = "the name of the datastore"
  default = "IST-DC-01"
}

variable "vsphere_vm_template" {
  type = string
  description = "the name of the vm template"
  default = "TerraformVM-template"
}

variable "vsphere_vm_name" {
  type = string
  description = "the name of the vm"
}

variable "vsphere_resource_pool" {
  type = string
  description = "the name of the resourcepool for examples: Cluster1/Resources " 
  default = "IST_CLUSTER/Resources"
}

variable "vsphere_vm_portgroup" {
  type = string
  description = "the name of the portgroup"
  default = "VM Network"
}

variable "vsphere_vm_cpu" {
  type = number
  description = "the number of vCpus"
  default = 1
}

variable "vsphere_vm_memory" {
  type = number
  description = "the amount of memory in MB"
  default = 512
}

variable "vsphere_vm_guest" {
  type = string
  description = "the name of the os type "
  default = "centos7_64Guest"
}

variable "vsphere_vm_disksize" {
  type = number
  description = "the size of the disk in GB"
  default = 20
}

variable "timeout" {
  description = "The timeout, in minutes, to wait for the virtual machine clone to complete."
  type        = number
  default     = 30
}

variable "linked_clone" {
  description = "Clone this virtual machine from a snapshot. Templates must have a single snapshot only in order to be eligible."
  default     = false
}

variable "vsphere_folder" {
  description = "vm folder"
  type = string
  #default    = false
}

