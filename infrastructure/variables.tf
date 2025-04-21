variable "resource_group_name" {
  description = "Name of the resource group to create"
  type        = string
  default     = "cmu-devops-project"
}

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "East US"
}

variable "virtual_network_name" {
  description = "Name of the Virtual Network"
  type        = string
  default     = "cmu-devops-project-vnet"
}

variable "address_space" {
  description = "Address space for the Virtual Network (CIDR)"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
  default     = "cmu-devops-project-subnet"
}

variable "subnet_address_prefixes" {
  description = "Address prefix for the Subnet (CIDR)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "vm_size" {
  description = "Size of the Virtual Machines (e.g., Standard_B1s, Standard_DS1_v2)"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "Administrator username for the VMs"
  type        = string
  default     = "azureuser"
}

variable "admin_ssh_public_key" {
  description = "SSH Public Key for VM access"
  type        = string
  # IMPORTANT: Replace the placeholder below with your actual SSH public key content.
  # It should look something like "ssh-rsa AAAAB3NzaC1yc2EAAAA..."
  # You can often get this by running 'cat ~/.ssh/id_rsa.pub' on your local machine.
  # Alternatively, you can use file("~/.ssh/id_rsa.pub") if the file exists locally.
  # default = file("~/.ssh/id_rsa.pub") # Uncomment this line to read from a file
}

# Variables for the VM Operating System image

variable "vm_image_publisher" {
  description = "Publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "vm_image_offer" {
  description = "Offer of the VM image"
  type        = string
  default     = "UbuntuServer" 
}

variable "vm_image_sku" {
  description = "SKU of the VM image"
  type        = string
  default     = "20.04-LTS"
}

variable "vm_image_version" {
  description = "Version of the VM image"
  type        = string
  default     = "latest"
}