terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.0.1"
    }
  }
  
  # Trying out github actions
  backend "remote" {
         # The name of your Terraform Cloud organization.
         organization = "ist-training"

         # The name of the Terraform Cloud workspace to store Terraform state files in.
         workspaces {
           name = "PodX-VM
         }
  }
}

provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server

  # if you have a self-signed cert
  allow_unverified_ssl = true
}


data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
    /*name = "IST_DC"*/
}

data "vsphere_datastore" "datastore" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_vm_portgroup
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vsphere_vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_folder" "folder" {
  path          =  var.vsphere_folder
  #datacenter_id = data.vsphere_datacenter.dc.id 
}

resource "vsphere_virtual_machine" "vm" {
  name             = var.vsphere_vm_name
  folder           = var.vsphere_folder
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.datastore.id
  wait_for_guest_ip_timeout = 0
  wait_for_guest_net_timeout = 0

  num_cpus = var.vsphere_vm_cpu #2
  memory   = var.vsphere_vm_memory #1024
  guest_id = var.vsphere_vm_guest #"other3xLinux64Guest"

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = var.vsphere_vm_disksize #20
    eagerly_scrub    = "${data.vsphere_virtual_machine.template.disks.0.eagerly_scrub}"
    thin_provisioned = "${data.vsphere_virtual_machine.template.disks.0.thin_provisioned}"
  }
  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"
  }

}

/*
#No more VM module because they want to customize, and I don't want that
module "vm" {
  source  = "Terraform-VMWare-Modules/vm/vsphere"
  version = "2.1.0"
  vmtemp        = var.vsphere_vm_template
  instances     = 1
  vmname        = var.vsphere_vm_name
  vmrp          = var.vsphere_resource_pool
  network = {
    "${var.vsphere_vm_portgroup}"  = ["", ""] # To use DHCP create Empty list ["",""]
  }
  dc        = var.vsphere_datacenter
  datastore = var.vsphere_datastore
}
*/
