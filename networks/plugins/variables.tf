//---------- standard inputs -----------

variable "consensus" {
  default = "istanbul"
}

variable "privacy_enhancements" {
  type        = object({ block = number, enabled = bool })
  default     = { block = 0, enabled = false }
  description = "privacy enhancements state (enabled/disabled) and the block height at which they are enabled"
}

variable "privacy_precompile" {
  type        = object({ block = number, enabled = bool })
  default     = { enabled = false, block = 0 }
  description = "Set the privacyPrecompileBlock fork"
}

variable "privacy_marker_transactions" {
  type        = bool
  default     = false
  description = "Enable privacy marker transactions on the node"
}

variable "network_name" {
  default = "plugins"
}

variable "output_dir" {
  default = "/tmp"
}

variable "remote_docker_config" {
  type        = object({ ssh_user = string, ssh_host = string, private_key_file = string, docker_host = string })
  default     = null
  description = "Configuration to connect to a VM which enables remote docker API"
}

variable "properties_outdir" {
  default     = ""
  description = "Output directory containing DockerWaitMain-network.properties"
}

variable "gauge_env_outdir" {
  default     = ""
  description = "Output directory containing user.properties for Gauge env"
}

//---------- advanced inputs -----------

variable "number_of_nodes" {
  default = 4
}

variable "plugins" {
  type        = map(object({ name = string, version = string, expose_api = bool }))
  description = "List of plugins and its version being used."
}

variable "quorum_docker_image" {
  type        = object({ name = string, local = bool })
  default     = { name = "quorumengineering/quorum:develop", local = false }
  description = "Local=true indicates that the image is already available locally and don't need to pull from registry"
}

variable "tessera_docker_image" {
  type        = object({ name = string, local = bool })
  default     = { name = "quorumengineering/tessera:develop", local = false }
  description = "Local=true indicates that the image is already available locally and don't need to pull from registry"
}

variable "docker_registry" {
  type    = list(object({ name = string, username = string, password = string }))
  default = []
}

variable "additional_quorum_container_vol" {
  type        = map(list(object({ container_path = string, host_path = string })))
  default     = {}
  description = "Additional volume mounts for geth container. Each map key is the node index (0-based)"
}

variable "additional_tessera_container_vol" {
  type        = map(list(object({ container_path = string, host_path = string })))
  default     = {}
  description = "Additional volume mounts for tessera container. Each map key is the node index (0-based)"
}

variable "tessera_app_container_path" {
  type        = map(string)
  default     = {}
  description = "Path to Tessera app jar file in the container. Each map key is the node index (0-based)"
}

variable "override_tm_named_key_allocation" {
  default     = {}
  description = <<-EOT
Override default allocation of transaction management named public key
E.g.: use 2 named keys: A1, A2 for node 1
{
  0 = ["A1", "A2"]
}
EOT
}

variable "override_named_account_allocation" {
  default     = {}
  description = <<-EOT
Override default allocation of accounts
E.g.: use 2 named account: ACC1, ACC2 for node 1
{
  0 = ["ACC1", "ACC2"]
}
EOT
}

variable "enable_multitenancy" {
  type = bool
  description = <<-EOT
Star geth with --mulitenancy flag
EOT
  default = false
}

variable "additional_tessera_config" {
  default = {}
  description = <<-EOT
Merge this config with the default config per node. This will override existing keys
E.g.: add config to node 1
{
  0 = {
    alwaysSendTo = ["xyz"]
  }
}
EOT
}

variable "additional_genesis_config" {
  default = {}
  description = <<-EOT
Merge this config with the chain config in the genesis per node. This will override existing keys
E.g.: enable isMPS for node 1
{
  0 = {
    isMPS = true
  }
}
EOT
}

variable "override_additional_geth_args" {
  default = {}
  description = <<-EOT
Override the value from var.additional_geth_args per node
{
  0 = "--http.api admin"
}
EOT
}

# TODO: it's not "override" at the moment. it's more to disable plugins for a node
variable "override_plugins" {
  default = {}
  description = <<-EOT
Override the value from var.plugins per node
{
  0 = {}
}
EOT
}

variable "qbftBlock" {
  type        = object({ block = number, enabled = bool })
  default     = { block = 0, enabled = false }
  description = "qbft fork block (enabled/disabled) and the block height at which it is enabled"
}
