output "vpc_name" {
  value       = "${google_compute_network.vpc_network.name}"
  description = "The unique name of the network"
}

output "self_link" {
  value       = "${google_compute_network.vpc_network.self_link}"
  description = "The URI of the created resource"
}
