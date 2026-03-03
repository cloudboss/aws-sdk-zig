const aws = @import("aws");
const std = @import("std");

const accept_address_transfer = @import("accept_address_transfer.zig");
const accept_capacity_reservation_billing_ownership = @import("accept_capacity_reservation_billing_ownership.zig");
const accept_reserved_instances_exchange_quote = @import("accept_reserved_instances_exchange_quote.zig");
const accept_transit_gateway_multicast_domain_associations = @import("accept_transit_gateway_multicast_domain_associations.zig");
const accept_transit_gateway_peering_attachment = @import("accept_transit_gateway_peering_attachment.zig");
const accept_transit_gateway_vpc_attachment = @import("accept_transit_gateway_vpc_attachment.zig");
const accept_vpc_endpoint_connections = @import("accept_vpc_endpoint_connections.zig");
const accept_vpc_peering_connection = @import("accept_vpc_peering_connection.zig");
const advertise_byoip_cidr = @import("advertise_byoip_cidr.zig");
const allocate_address = @import("allocate_address.zig");
const allocate_hosts = @import("allocate_hosts.zig");
const allocate_ipam_pool_cidr = @import("allocate_ipam_pool_cidr.zig");
const apply_security_groups_to_client_vpn_target_network = @import("apply_security_groups_to_client_vpn_target_network.zig");
const assign_ipv_6_addresses = @import("assign_ipv_6_addresses.zig");
const assign_private_ip_addresses = @import("assign_private_ip_addresses.zig");
const assign_private_nat_gateway_address = @import("assign_private_nat_gateway_address.zig");
const associate_address = @import("associate_address.zig");
const associate_capacity_reservation_billing_owner = @import("associate_capacity_reservation_billing_owner.zig");
const associate_client_vpn_target_network = @import("associate_client_vpn_target_network.zig");
const associate_dhcp_options = @import("associate_dhcp_options.zig");
const associate_enclave_certificate_iam_role = @import("associate_enclave_certificate_iam_role.zig");
const associate_iam_instance_profile = @import("associate_iam_instance_profile.zig");
const associate_instance_event_window = @import("associate_instance_event_window.zig");
const associate_ipam_byoasn = @import("associate_ipam_byoasn.zig");
const associate_ipam_resource_discovery = @import("associate_ipam_resource_discovery.zig");
const associate_nat_gateway_address = @import("associate_nat_gateway_address.zig");
const associate_route_server = @import("associate_route_server.zig");
const associate_route_table = @import("associate_route_table.zig");
const associate_security_group_vpc = @import("associate_security_group_vpc.zig");
const associate_subnet_cidr_block = @import("associate_subnet_cidr_block.zig");
const associate_transit_gateway_multicast_domain = @import("associate_transit_gateway_multicast_domain.zig");
const associate_transit_gateway_policy_table = @import("associate_transit_gateway_policy_table.zig");
const associate_transit_gateway_route_table = @import("associate_transit_gateway_route_table.zig");
const associate_trunk_interface = @import("associate_trunk_interface.zig");
const associate_vpc_cidr_block = @import("associate_vpc_cidr_block.zig");
const attach_classic_link_vpc = @import("attach_classic_link_vpc.zig");
const attach_internet_gateway = @import("attach_internet_gateway.zig");
const attach_network_interface = @import("attach_network_interface.zig");
const attach_verified_access_trust_provider = @import("attach_verified_access_trust_provider.zig");
const attach_volume = @import("attach_volume.zig");
const attach_vpn_gateway = @import("attach_vpn_gateway.zig");
const authorize_client_vpn_ingress = @import("authorize_client_vpn_ingress.zig");
const authorize_security_group_egress = @import("authorize_security_group_egress.zig");
const authorize_security_group_ingress = @import("authorize_security_group_ingress.zig");
const bundle_instance = @import("bundle_instance.zig");
const cancel_bundle_task = @import("cancel_bundle_task.zig");
const cancel_capacity_reservation = @import("cancel_capacity_reservation.zig");
const cancel_capacity_reservation_fleets = @import("cancel_capacity_reservation_fleets.zig");
const cancel_conversion_task = @import("cancel_conversion_task.zig");
const cancel_declarative_policies_report = @import("cancel_declarative_policies_report.zig");
const cancel_export_task = @import("cancel_export_task.zig");
const cancel_image_launch_permission = @import("cancel_image_launch_permission.zig");
const cancel_import_task = @import("cancel_import_task.zig");
const cancel_reserved_instances_listing = @import("cancel_reserved_instances_listing.zig");
const cancel_spot_fleet_requests = @import("cancel_spot_fleet_requests.zig");
const cancel_spot_instance_requests = @import("cancel_spot_instance_requests.zig");
const confirm_product_instance = @import("confirm_product_instance.zig");
const copy_fpga_image = @import("copy_fpga_image.zig");
const copy_image = @import("copy_image.zig");
const copy_snapshot = @import("copy_snapshot.zig");
const copy_volumes = @import("copy_volumes.zig");
const create_capacity_manager_data_export = @import("create_capacity_manager_data_export.zig");
const create_capacity_reservation = @import("create_capacity_reservation.zig");
const create_capacity_reservation_by_splitting = @import("create_capacity_reservation_by_splitting.zig");
const create_capacity_reservation_fleet = @import("create_capacity_reservation_fleet.zig");
const create_carrier_gateway = @import("create_carrier_gateway.zig");
const create_client_vpn_endpoint = @import("create_client_vpn_endpoint.zig");
const create_client_vpn_route = @import("create_client_vpn_route.zig");
const create_coip_cidr = @import("create_coip_cidr.zig");
const create_coip_pool = @import("create_coip_pool.zig");
const create_customer_gateway = @import("create_customer_gateway.zig");
const create_default_subnet = @import("create_default_subnet.zig");
const create_default_vpc = @import("create_default_vpc.zig");
const create_delegate_mac_volume_ownership_task = @import("create_delegate_mac_volume_ownership_task.zig");
const create_dhcp_options = @import("create_dhcp_options.zig");
const create_egress_only_internet_gateway = @import("create_egress_only_internet_gateway.zig");
const create_fleet = @import("create_fleet.zig");
const create_flow_logs = @import("create_flow_logs.zig");
const create_fpga_image = @import("create_fpga_image.zig");
const create_image = @import("create_image.zig");
const create_image_usage_report = @import("create_image_usage_report.zig");
const create_instance_connect_endpoint = @import("create_instance_connect_endpoint.zig");
const create_instance_event_window = @import("create_instance_event_window.zig");
const create_instance_export_task = @import("create_instance_export_task.zig");
const create_internet_gateway = @import("create_internet_gateway.zig");
const create_interruptible_capacity_reservation_allocation = @import("create_interruptible_capacity_reservation_allocation.zig");
const create_ipam = @import("create_ipam.zig");
const create_ipam_external_resource_verification_token = @import("create_ipam_external_resource_verification_token.zig");
const create_ipam_policy = @import("create_ipam_policy.zig");
const create_ipam_pool = @import("create_ipam_pool.zig");
const create_ipam_prefix_list_resolver = @import("create_ipam_prefix_list_resolver.zig");
const create_ipam_prefix_list_resolver_target = @import("create_ipam_prefix_list_resolver_target.zig");
const create_ipam_resource_discovery = @import("create_ipam_resource_discovery.zig");
const create_ipam_scope = @import("create_ipam_scope.zig");
const create_key_pair = @import("create_key_pair.zig");
const create_launch_template = @import("create_launch_template.zig");
const create_launch_template_version = @import("create_launch_template_version.zig");
const create_local_gateway_route = @import("create_local_gateway_route.zig");
const create_local_gateway_route_table = @import("create_local_gateway_route_table.zig");
const create_local_gateway_route_table_virtual_interface_group_association = @import("create_local_gateway_route_table_virtual_interface_group_association.zig");
const create_local_gateway_route_table_vpc_association = @import("create_local_gateway_route_table_vpc_association.zig");
const create_local_gateway_virtual_interface = @import("create_local_gateway_virtual_interface.zig");
const create_local_gateway_virtual_interface_group = @import("create_local_gateway_virtual_interface_group.zig");
const create_mac_system_integrity_protection_modification_task = @import("create_mac_system_integrity_protection_modification_task.zig");
const create_managed_prefix_list = @import("create_managed_prefix_list.zig");
const create_nat_gateway = @import("create_nat_gateway.zig");
const create_network_acl = @import("create_network_acl.zig");
const create_network_acl_entry = @import("create_network_acl_entry.zig");
const create_network_insights_access_scope = @import("create_network_insights_access_scope.zig");
const create_network_insights_path = @import("create_network_insights_path.zig");
const create_network_interface = @import("create_network_interface.zig");
const create_network_interface_permission = @import("create_network_interface_permission.zig");
const create_placement_group = @import("create_placement_group.zig");
const create_public_ipv_4_pool = @import("create_public_ipv_4_pool.zig");
const create_replace_root_volume_task = @import("create_replace_root_volume_task.zig");
const create_reserved_instances_listing = @import("create_reserved_instances_listing.zig");
const create_restore_image_task = @import("create_restore_image_task.zig");
const create_route = @import("create_route.zig");
const create_route_server = @import("create_route_server.zig");
const create_route_server_endpoint = @import("create_route_server_endpoint.zig");
const create_route_server_peer = @import("create_route_server_peer.zig");
const create_route_table = @import("create_route_table.zig");
const create_security_group = @import("create_security_group.zig");
const create_snapshot = @import("create_snapshot.zig");
const create_snapshots = @import("create_snapshots.zig");
const create_spot_datafeed_subscription = @import("create_spot_datafeed_subscription.zig");
const create_store_image_task = @import("create_store_image_task.zig");
const create_subnet = @import("create_subnet.zig");
const create_subnet_cidr_reservation = @import("create_subnet_cidr_reservation.zig");
const create_tags = @import("create_tags.zig");
const create_traffic_mirror_filter = @import("create_traffic_mirror_filter.zig");
const create_traffic_mirror_filter_rule = @import("create_traffic_mirror_filter_rule.zig");
const create_traffic_mirror_session = @import("create_traffic_mirror_session.zig");
const create_traffic_mirror_target = @import("create_traffic_mirror_target.zig");
const create_transit_gateway = @import("create_transit_gateway.zig");
const create_transit_gateway_connect = @import("create_transit_gateway_connect.zig");
const create_transit_gateway_connect_peer = @import("create_transit_gateway_connect_peer.zig");
const create_transit_gateway_metering_policy = @import("create_transit_gateway_metering_policy.zig");
const create_transit_gateway_metering_policy_entry = @import("create_transit_gateway_metering_policy_entry.zig");
const create_transit_gateway_multicast_domain = @import("create_transit_gateway_multicast_domain.zig");
const create_transit_gateway_peering_attachment = @import("create_transit_gateway_peering_attachment.zig");
const create_transit_gateway_policy_table = @import("create_transit_gateway_policy_table.zig");
const create_transit_gateway_prefix_list_reference = @import("create_transit_gateway_prefix_list_reference.zig");
const create_transit_gateway_route = @import("create_transit_gateway_route.zig");
const create_transit_gateway_route_table = @import("create_transit_gateway_route_table.zig");
const create_transit_gateway_route_table_announcement = @import("create_transit_gateway_route_table_announcement.zig");
const create_transit_gateway_vpc_attachment = @import("create_transit_gateway_vpc_attachment.zig");
const create_verified_access_endpoint = @import("create_verified_access_endpoint.zig");
const create_verified_access_group = @import("create_verified_access_group.zig");
const create_verified_access_instance = @import("create_verified_access_instance.zig");
const create_verified_access_trust_provider = @import("create_verified_access_trust_provider.zig");
const create_volume = @import("create_volume.zig");
const create_vpc = @import("create_vpc.zig");
const create_vpc_block_public_access_exclusion = @import("create_vpc_block_public_access_exclusion.zig");
const create_vpc_encryption_control = @import("create_vpc_encryption_control.zig");
const create_vpc_endpoint = @import("create_vpc_endpoint.zig");
const create_vpc_endpoint_connection_notification = @import("create_vpc_endpoint_connection_notification.zig");
const create_vpc_endpoint_service_configuration = @import("create_vpc_endpoint_service_configuration.zig");
const create_vpc_peering_connection = @import("create_vpc_peering_connection.zig");
const create_vpn_concentrator = @import("create_vpn_concentrator.zig");
const create_vpn_connection = @import("create_vpn_connection.zig");
const create_vpn_connection_route = @import("create_vpn_connection_route.zig");
const create_vpn_gateway = @import("create_vpn_gateway.zig");
const delete_capacity_manager_data_export = @import("delete_capacity_manager_data_export.zig");
const delete_carrier_gateway = @import("delete_carrier_gateway.zig");
const delete_client_vpn_endpoint = @import("delete_client_vpn_endpoint.zig");
const delete_client_vpn_route = @import("delete_client_vpn_route.zig");
const delete_coip_cidr = @import("delete_coip_cidr.zig");
const delete_coip_pool = @import("delete_coip_pool.zig");
const delete_customer_gateway = @import("delete_customer_gateway.zig");
const delete_dhcp_options = @import("delete_dhcp_options.zig");
const delete_egress_only_internet_gateway = @import("delete_egress_only_internet_gateway.zig");
const delete_fleets = @import("delete_fleets.zig");
const delete_flow_logs = @import("delete_flow_logs.zig");
const delete_fpga_image = @import("delete_fpga_image.zig");
const delete_image_usage_report = @import("delete_image_usage_report.zig");
const delete_instance_connect_endpoint = @import("delete_instance_connect_endpoint.zig");
const delete_instance_event_window = @import("delete_instance_event_window.zig");
const delete_internet_gateway = @import("delete_internet_gateway.zig");
const delete_ipam = @import("delete_ipam.zig");
const delete_ipam_external_resource_verification_token = @import("delete_ipam_external_resource_verification_token.zig");
const delete_ipam_policy = @import("delete_ipam_policy.zig");
const delete_ipam_pool = @import("delete_ipam_pool.zig");
const delete_ipam_prefix_list_resolver = @import("delete_ipam_prefix_list_resolver.zig");
const delete_ipam_prefix_list_resolver_target = @import("delete_ipam_prefix_list_resolver_target.zig");
const delete_ipam_resource_discovery = @import("delete_ipam_resource_discovery.zig");
const delete_ipam_scope = @import("delete_ipam_scope.zig");
const delete_key_pair = @import("delete_key_pair.zig");
const delete_launch_template = @import("delete_launch_template.zig");
const delete_launch_template_versions = @import("delete_launch_template_versions.zig");
const delete_local_gateway_route = @import("delete_local_gateway_route.zig");
const delete_local_gateway_route_table = @import("delete_local_gateway_route_table.zig");
const delete_local_gateway_route_table_virtual_interface_group_association = @import("delete_local_gateway_route_table_virtual_interface_group_association.zig");
const delete_local_gateway_route_table_vpc_association = @import("delete_local_gateway_route_table_vpc_association.zig");
const delete_local_gateway_virtual_interface = @import("delete_local_gateway_virtual_interface.zig");
const delete_local_gateway_virtual_interface_group = @import("delete_local_gateway_virtual_interface_group.zig");
const delete_managed_prefix_list = @import("delete_managed_prefix_list.zig");
const delete_nat_gateway = @import("delete_nat_gateway.zig");
const delete_network_acl = @import("delete_network_acl.zig");
const delete_network_acl_entry = @import("delete_network_acl_entry.zig");
const delete_network_insights_access_scope = @import("delete_network_insights_access_scope.zig");
const delete_network_insights_access_scope_analysis = @import("delete_network_insights_access_scope_analysis.zig");
const delete_network_insights_analysis = @import("delete_network_insights_analysis.zig");
const delete_network_insights_path = @import("delete_network_insights_path.zig");
const delete_network_interface = @import("delete_network_interface.zig");
const delete_network_interface_permission = @import("delete_network_interface_permission.zig");
const delete_placement_group = @import("delete_placement_group.zig");
const delete_public_ipv_4_pool = @import("delete_public_ipv_4_pool.zig");
const delete_queued_reserved_instances = @import("delete_queued_reserved_instances.zig");
const delete_route = @import("delete_route.zig");
const delete_route_server = @import("delete_route_server.zig");
const delete_route_server_endpoint = @import("delete_route_server_endpoint.zig");
const delete_route_server_peer = @import("delete_route_server_peer.zig");
const delete_route_table = @import("delete_route_table.zig");
const delete_security_group = @import("delete_security_group.zig");
const delete_snapshot = @import("delete_snapshot.zig");
const delete_spot_datafeed_subscription = @import("delete_spot_datafeed_subscription.zig");
const delete_subnet = @import("delete_subnet.zig");
const delete_subnet_cidr_reservation = @import("delete_subnet_cidr_reservation.zig");
const delete_tags = @import("delete_tags.zig");
const delete_traffic_mirror_filter = @import("delete_traffic_mirror_filter.zig");
const delete_traffic_mirror_filter_rule = @import("delete_traffic_mirror_filter_rule.zig");
const delete_traffic_mirror_session = @import("delete_traffic_mirror_session.zig");
const delete_traffic_mirror_target = @import("delete_traffic_mirror_target.zig");
const delete_transit_gateway = @import("delete_transit_gateway.zig");
const delete_transit_gateway_connect = @import("delete_transit_gateway_connect.zig");
const delete_transit_gateway_connect_peer = @import("delete_transit_gateway_connect_peer.zig");
const delete_transit_gateway_metering_policy = @import("delete_transit_gateway_metering_policy.zig");
const delete_transit_gateway_metering_policy_entry = @import("delete_transit_gateway_metering_policy_entry.zig");
const delete_transit_gateway_multicast_domain = @import("delete_transit_gateway_multicast_domain.zig");
const delete_transit_gateway_peering_attachment = @import("delete_transit_gateway_peering_attachment.zig");
const delete_transit_gateway_policy_table = @import("delete_transit_gateway_policy_table.zig");
const delete_transit_gateway_prefix_list_reference = @import("delete_transit_gateway_prefix_list_reference.zig");
const delete_transit_gateway_route = @import("delete_transit_gateway_route.zig");
const delete_transit_gateway_route_table = @import("delete_transit_gateway_route_table.zig");
const delete_transit_gateway_route_table_announcement = @import("delete_transit_gateway_route_table_announcement.zig");
const delete_transit_gateway_vpc_attachment = @import("delete_transit_gateway_vpc_attachment.zig");
const delete_verified_access_endpoint = @import("delete_verified_access_endpoint.zig");
const delete_verified_access_group = @import("delete_verified_access_group.zig");
const delete_verified_access_instance = @import("delete_verified_access_instance.zig");
const delete_verified_access_trust_provider = @import("delete_verified_access_trust_provider.zig");
const delete_volume = @import("delete_volume.zig");
const delete_vpc = @import("delete_vpc.zig");
const delete_vpc_block_public_access_exclusion = @import("delete_vpc_block_public_access_exclusion.zig");
const delete_vpc_encryption_control = @import("delete_vpc_encryption_control.zig");
const delete_vpc_endpoint_connection_notifications = @import("delete_vpc_endpoint_connection_notifications.zig");
const delete_vpc_endpoint_service_configurations = @import("delete_vpc_endpoint_service_configurations.zig");
const delete_vpc_endpoints = @import("delete_vpc_endpoints.zig");
const delete_vpc_peering_connection = @import("delete_vpc_peering_connection.zig");
const delete_vpn_concentrator = @import("delete_vpn_concentrator.zig");
const delete_vpn_connection = @import("delete_vpn_connection.zig");
const delete_vpn_connection_route = @import("delete_vpn_connection_route.zig");
const delete_vpn_gateway = @import("delete_vpn_gateway.zig");
const deprovision_byoip_cidr = @import("deprovision_byoip_cidr.zig");
const deprovision_ipam_byoasn = @import("deprovision_ipam_byoasn.zig");
const deprovision_ipam_pool_cidr = @import("deprovision_ipam_pool_cidr.zig");
const deprovision_public_ipv_4_pool_cidr = @import("deprovision_public_ipv_4_pool_cidr.zig");
const deregister_image = @import("deregister_image.zig");
const deregister_instance_event_notification_attributes = @import("deregister_instance_event_notification_attributes.zig");
const deregister_transit_gateway_multicast_group_members = @import("deregister_transit_gateway_multicast_group_members.zig");
const deregister_transit_gateway_multicast_group_sources = @import("deregister_transit_gateway_multicast_group_sources.zig");
const describe_account_attributes = @import("describe_account_attributes.zig");
const describe_address_transfers = @import("describe_address_transfers.zig");
const describe_addresses = @import("describe_addresses.zig");
const describe_addresses_attribute = @import("describe_addresses_attribute.zig");
const describe_aggregate_id_format = @import("describe_aggregate_id_format.zig");
const describe_availability_zones = @import("describe_availability_zones.zig");
const describe_aws_network_performance_metric_subscriptions = @import("describe_aws_network_performance_metric_subscriptions.zig");
const describe_bundle_tasks = @import("describe_bundle_tasks.zig");
const describe_byoip_cidrs = @import("describe_byoip_cidrs.zig");
const describe_capacity_block_extension_history = @import("describe_capacity_block_extension_history.zig");
const describe_capacity_block_extension_offerings = @import("describe_capacity_block_extension_offerings.zig");
const describe_capacity_block_offerings = @import("describe_capacity_block_offerings.zig");
const describe_capacity_block_status = @import("describe_capacity_block_status.zig");
const describe_capacity_blocks = @import("describe_capacity_blocks.zig");
const describe_capacity_manager_data_exports = @import("describe_capacity_manager_data_exports.zig");
const describe_capacity_reservation_billing_requests = @import("describe_capacity_reservation_billing_requests.zig");
const describe_capacity_reservation_fleets = @import("describe_capacity_reservation_fleets.zig");
const describe_capacity_reservation_topology = @import("describe_capacity_reservation_topology.zig");
const describe_capacity_reservations = @import("describe_capacity_reservations.zig");
const describe_carrier_gateways = @import("describe_carrier_gateways.zig");
const describe_classic_link_instances = @import("describe_classic_link_instances.zig");
const describe_client_vpn_authorization_rules = @import("describe_client_vpn_authorization_rules.zig");
const describe_client_vpn_connections = @import("describe_client_vpn_connections.zig");
const describe_client_vpn_endpoints = @import("describe_client_vpn_endpoints.zig");
const describe_client_vpn_routes = @import("describe_client_vpn_routes.zig");
const describe_client_vpn_target_networks = @import("describe_client_vpn_target_networks.zig");
const describe_coip_pools = @import("describe_coip_pools.zig");
const describe_conversion_tasks = @import("describe_conversion_tasks.zig");
const describe_customer_gateways = @import("describe_customer_gateways.zig");
const describe_declarative_policies_reports = @import("describe_declarative_policies_reports.zig");
const describe_dhcp_options = @import("describe_dhcp_options.zig");
const describe_egress_only_internet_gateways = @import("describe_egress_only_internet_gateways.zig");
const describe_elastic_gpus = @import("describe_elastic_gpus.zig");
const describe_export_image_tasks = @import("describe_export_image_tasks.zig");
const describe_export_tasks = @import("describe_export_tasks.zig");
const describe_fast_launch_images = @import("describe_fast_launch_images.zig");
const describe_fast_snapshot_restores = @import("describe_fast_snapshot_restores.zig");
const describe_fleet_history = @import("describe_fleet_history.zig");
const describe_fleet_instances = @import("describe_fleet_instances.zig");
const describe_fleets = @import("describe_fleets.zig");
const describe_flow_logs = @import("describe_flow_logs.zig");
const describe_fpga_image_attribute = @import("describe_fpga_image_attribute.zig");
const describe_fpga_images = @import("describe_fpga_images.zig");
const describe_host_reservation_offerings = @import("describe_host_reservation_offerings.zig");
const describe_host_reservations = @import("describe_host_reservations.zig");
const describe_hosts = @import("describe_hosts.zig");
const describe_iam_instance_profile_associations = @import("describe_iam_instance_profile_associations.zig");
const describe_id_format = @import("describe_id_format.zig");
const describe_identity_id_format = @import("describe_identity_id_format.zig");
const describe_image_attribute = @import("describe_image_attribute.zig");
const describe_image_references = @import("describe_image_references.zig");
const describe_image_usage_report_entries = @import("describe_image_usage_report_entries.zig");
const describe_image_usage_reports = @import("describe_image_usage_reports.zig");
const describe_images = @import("describe_images.zig");
const describe_import_image_tasks = @import("describe_import_image_tasks.zig");
const describe_import_snapshot_tasks = @import("describe_import_snapshot_tasks.zig");
const describe_instance_attribute = @import("describe_instance_attribute.zig");
const describe_instance_connect_endpoints = @import("describe_instance_connect_endpoints.zig");
const describe_instance_credit_specifications = @import("describe_instance_credit_specifications.zig");
const describe_instance_event_notification_attributes = @import("describe_instance_event_notification_attributes.zig");
const describe_instance_event_windows = @import("describe_instance_event_windows.zig");
const describe_instance_image_metadata = @import("describe_instance_image_metadata.zig");
const describe_instance_sql_ha_history_states = @import("describe_instance_sql_ha_history_states.zig");
const describe_instance_sql_ha_states = @import("describe_instance_sql_ha_states.zig");
const describe_instance_status = @import("describe_instance_status.zig");
const describe_instance_topology = @import("describe_instance_topology.zig");
const describe_instance_type_offerings = @import("describe_instance_type_offerings.zig");
const describe_instance_types = @import("describe_instance_types.zig");
const describe_instances = @import("describe_instances.zig");
const describe_internet_gateways = @import("describe_internet_gateways.zig");
const describe_ipam_byoasn = @import("describe_ipam_byoasn.zig");
const describe_ipam_external_resource_verification_tokens = @import("describe_ipam_external_resource_verification_tokens.zig");
const describe_ipam_policies = @import("describe_ipam_policies.zig");
const describe_ipam_pools = @import("describe_ipam_pools.zig");
const describe_ipam_prefix_list_resolver_targets = @import("describe_ipam_prefix_list_resolver_targets.zig");
const describe_ipam_prefix_list_resolvers = @import("describe_ipam_prefix_list_resolvers.zig");
const describe_ipam_resource_discoveries = @import("describe_ipam_resource_discoveries.zig");
const describe_ipam_resource_discovery_associations = @import("describe_ipam_resource_discovery_associations.zig");
const describe_ipam_scopes = @import("describe_ipam_scopes.zig");
const describe_ipams = @import("describe_ipams.zig");
const describe_ipv_6_pools = @import("describe_ipv_6_pools.zig");
const describe_key_pairs = @import("describe_key_pairs.zig");
const describe_launch_template_versions = @import("describe_launch_template_versions.zig");
const describe_launch_templates = @import("describe_launch_templates.zig");
const describe_local_gateway_route_table_virtual_interface_group_associations = @import("describe_local_gateway_route_table_virtual_interface_group_associations.zig");
const describe_local_gateway_route_table_vpc_associations = @import("describe_local_gateway_route_table_vpc_associations.zig");
const describe_local_gateway_route_tables = @import("describe_local_gateway_route_tables.zig");
const describe_local_gateway_virtual_interface_groups = @import("describe_local_gateway_virtual_interface_groups.zig");
const describe_local_gateway_virtual_interfaces = @import("describe_local_gateway_virtual_interfaces.zig");
const describe_local_gateways = @import("describe_local_gateways.zig");
const describe_locked_snapshots = @import("describe_locked_snapshots.zig");
const describe_mac_hosts = @import("describe_mac_hosts.zig");
const describe_mac_modification_tasks = @import("describe_mac_modification_tasks.zig");
const describe_managed_prefix_lists = @import("describe_managed_prefix_lists.zig");
const describe_moving_addresses = @import("describe_moving_addresses.zig");
const describe_nat_gateways = @import("describe_nat_gateways.zig");
const describe_network_acls = @import("describe_network_acls.zig");
const describe_network_insights_access_scope_analyses = @import("describe_network_insights_access_scope_analyses.zig");
const describe_network_insights_access_scopes = @import("describe_network_insights_access_scopes.zig");
const describe_network_insights_analyses = @import("describe_network_insights_analyses.zig");
const describe_network_insights_paths = @import("describe_network_insights_paths.zig");
const describe_network_interface_attribute = @import("describe_network_interface_attribute.zig");
const describe_network_interface_permissions = @import("describe_network_interface_permissions.zig");
const describe_network_interfaces = @import("describe_network_interfaces.zig");
const describe_outpost_lags = @import("describe_outpost_lags.zig");
const describe_placement_groups = @import("describe_placement_groups.zig");
const describe_prefix_lists = @import("describe_prefix_lists.zig");
const describe_principal_id_format = @import("describe_principal_id_format.zig");
const describe_public_ipv_4_pools = @import("describe_public_ipv_4_pools.zig");
const describe_regions = @import("describe_regions.zig");
const describe_replace_root_volume_tasks = @import("describe_replace_root_volume_tasks.zig");
const describe_reserved_instances = @import("describe_reserved_instances.zig");
const describe_reserved_instances_listings = @import("describe_reserved_instances_listings.zig");
const describe_reserved_instances_modifications = @import("describe_reserved_instances_modifications.zig");
const describe_reserved_instances_offerings = @import("describe_reserved_instances_offerings.zig");
const describe_route_server_endpoints = @import("describe_route_server_endpoints.zig");
const describe_route_server_peers = @import("describe_route_server_peers.zig");
const describe_route_servers = @import("describe_route_servers.zig");
const describe_route_tables = @import("describe_route_tables.zig");
const describe_scheduled_instance_availability = @import("describe_scheduled_instance_availability.zig");
const describe_scheduled_instances = @import("describe_scheduled_instances.zig");
const describe_security_group_references = @import("describe_security_group_references.zig");
const describe_security_group_rules = @import("describe_security_group_rules.zig");
const describe_security_group_vpc_associations = @import("describe_security_group_vpc_associations.zig");
const describe_security_groups = @import("describe_security_groups.zig");
const describe_service_link_virtual_interfaces = @import("describe_service_link_virtual_interfaces.zig");
const describe_snapshot_attribute = @import("describe_snapshot_attribute.zig");
const describe_snapshot_tier_status = @import("describe_snapshot_tier_status.zig");
const describe_snapshots = @import("describe_snapshots.zig");
const describe_spot_datafeed_subscription = @import("describe_spot_datafeed_subscription.zig");
const describe_spot_fleet_instances = @import("describe_spot_fleet_instances.zig");
const describe_spot_fleet_request_history = @import("describe_spot_fleet_request_history.zig");
const describe_spot_fleet_requests = @import("describe_spot_fleet_requests.zig");
const describe_spot_instance_requests = @import("describe_spot_instance_requests.zig");
const describe_spot_price_history = @import("describe_spot_price_history.zig");
const describe_stale_security_groups = @import("describe_stale_security_groups.zig");
const describe_store_image_tasks = @import("describe_store_image_tasks.zig");
const describe_subnets = @import("describe_subnets.zig");
const describe_tags = @import("describe_tags.zig");
const describe_traffic_mirror_filter_rules = @import("describe_traffic_mirror_filter_rules.zig");
const describe_traffic_mirror_filters = @import("describe_traffic_mirror_filters.zig");
const describe_traffic_mirror_sessions = @import("describe_traffic_mirror_sessions.zig");
const describe_traffic_mirror_targets = @import("describe_traffic_mirror_targets.zig");
const describe_transit_gateway_attachments = @import("describe_transit_gateway_attachments.zig");
const describe_transit_gateway_connect_peers = @import("describe_transit_gateway_connect_peers.zig");
const describe_transit_gateway_connects = @import("describe_transit_gateway_connects.zig");
const describe_transit_gateway_metering_policies = @import("describe_transit_gateway_metering_policies.zig");
const describe_transit_gateway_multicast_domains = @import("describe_transit_gateway_multicast_domains.zig");
const describe_transit_gateway_peering_attachments = @import("describe_transit_gateway_peering_attachments.zig");
const describe_transit_gateway_policy_tables = @import("describe_transit_gateway_policy_tables.zig");
const describe_transit_gateway_route_table_announcements = @import("describe_transit_gateway_route_table_announcements.zig");
const describe_transit_gateway_route_tables = @import("describe_transit_gateway_route_tables.zig");
const describe_transit_gateway_vpc_attachments = @import("describe_transit_gateway_vpc_attachments.zig");
const describe_transit_gateways = @import("describe_transit_gateways.zig");
const describe_trunk_interface_associations = @import("describe_trunk_interface_associations.zig");
const describe_verified_access_endpoints = @import("describe_verified_access_endpoints.zig");
const describe_verified_access_groups = @import("describe_verified_access_groups.zig");
const describe_verified_access_instance_logging_configurations = @import("describe_verified_access_instance_logging_configurations.zig");
const describe_verified_access_instances = @import("describe_verified_access_instances.zig");
const describe_verified_access_trust_providers = @import("describe_verified_access_trust_providers.zig");
const describe_volume_attribute = @import("describe_volume_attribute.zig");
const describe_volume_status = @import("describe_volume_status.zig");
const describe_volumes = @import("describe_volumes.zig");
const describe_volumes_modifications = @import("describe_volumes_modifications.zig");
const describe_vpc_attribute = @import("describe_vpc_attribute.zig");
const describe_vpc_block_public_access_exclusions = @import("describe_vpc_block_public_access_exclusions.zig");
const describe_vpc_block_public_access_options = @import("describe_vpc_block_public_access_options.zig");
const describe_vpc_classic_link = @import("describe_vpc_classic_link.zig");
const describe_vpc_classic_link_dns_support = @import("describe_vpc_classic_link_dns_support.zig");
const describe_vpc_encryption_controls = @import("describe_vpc_encryption_controls.zig");
const describe_vpc_endpoint_associations = @import("describe_vpc_endpoint_associations.zig");
const describe_vpc_endpoint_connection_notifications = @import("describe_vpc_endpoint_connection_notifications.zig");
const describe_vpc_endpoint_connections = @import("describe_vpc_endpoint_connections.zig");
const describe_vpc_endpoint_service_configurations = @import("describe_vpc_endpoint_service_configurations.zig");
const describe_vpc_endpoint_service_permissions = @import("describe_vpc_endpoint_service_permissions.zig");
const describe_vpc_endpoint_services = @import("describe_vpc_endpoint_services.zig");
const describe_vpc_endpoints = @import("describe_vpc_endpoints.zig");
const describe_vpc_peering_connections = @import("describe_vpc_peering_connections.zig");
const describe_vpcs = @import("describe_vpcs.zig");
const describe_vpn_concentrators = @import("describe_vpn_concentrators.zig");
const describe_vpn_connections = @import("describe_vpn_connections.zig");
const describe_vpn_gateways = @import("describe_vpn_gateways.zig");
const detach_classic_link_vpc = @import("detach_classic_link_vpc.zig");
const detach_internet_gateway = @import("detach_internet_gateway.zig");
const detach_network_interface = @import("detach_network_interface.zig");
const detach_verified_access_trust_provider = @import("detach_verified_access_trust_provider.zig");
const detach_volume = @import("detach_volume.zig");
const detach_vpn_gateway = @import("detach_vpn_gateway.zig");
const disable_address_transfer = @import("disable_address_transfer.zig");
const disable_allowed_images_settings = @import("disable_allowed_images_settings.zig");
const disable_aws_network_performance_metric_subscription = @import("disable_aws_network_performance_metric_subscription.zig");
const disable_capacity_manager = @import("disable_capacity_manager.zig");
const disable_ebs_encryption_by_default = @import("disable_ebs_encryption_by_default.zig");
const disable_fast_launch = @import("disable_fast_launch.zig");
const disable_fast_snapshot_restores = @import("disable_fast_snapshot_restores.zig");
const disable_image = @import("disable_image.zig");
const disable_image_block_public_access = @import("disable_image_block_public_access.zig");
const disable_image_deprecation = @import("disable_image_deprecation.zig");
const disable_image_deregistration_protection = @import("disable_image_deregistration_protection.zig");
const disable_instance_sql_ha_standby_detections = @import("disable_instance_sql_ha_standby_detections.zig");
const disable_ipam_organization_admin_account = @import("disable_ipam_organization_admin_account.zig");
const disable_ipam_policy = @import("disable_ipam_policy.zig");
const disable_route_server_propagation = @import("disable_route_server_propagation.zig");
const disable_serial_console_access = @import("disable_serial_console_access.zig");
const disable_snapshot_block_public_access = @import("disable_snapshot_block_public_access.zig");
const disable_transit_gateway_route_table_propagation = @import("disable_transit_gateway_route_table_propagation.zig");
const disable_vgw_route_propagation = @import("disable_vgw_route_propagation.zig");
const disable_vpc_classic_link = @import("disable_vpc_classic_link.zig");
const disable_vpc_classic_link_dns_support = @import("disable_vpc_classic_link_dns_support.zig");
const disassociate_address = @import("disassociate_address.zig");
const disassociate_capacity_reservation_billing_owner = @import("disassociate_capacity_reservation_billing_owner.zig");
const disassociate_client_vpn_target_network = @import("disassociate_client_vpn_target_network.zig");
const disassociate_enclave_certificate_iam_role = @import("disassociate_enclave_certificate_iam_role.zig");
const disassociate_iam_instance_profile = @import("disassociate_iam_instance_profile.zig");
const disassociate_instance_event_window = @import("disassociate_instance_event_window.zig");
const disassociate_ipam_byoasn = @import("disassociate_ipam_byoasn.zig");
const disassociate_ipam_resource_discovery = @import("disassociate_ipam_resource_discovery.zig");
const disassociate_nat_gateway_address = @import("disassociate_nat_gateway_address.zig");
const disassociate_route_server = @import("disassociate_route_server.zig");
const disassociate_route_table = @import("disassociate_route_table.zig");
const disassociate_security_group_vpc = @import("disassociate_security_group_vpc.zig");
const disassociate_subnet_cidr_block = @import("disassociate_subnet_cidr_block.zig");
const disassociate_transit_gateway_multicast_domain = @import("disassociate_transit_gateway_multicast_domain.zig");
const disassociate_transit_gateway_policy_table = @import("disassociate_transit_gateway_policy_table.zig");
const disassociate_transit_gateway_route_table = @import("disassociate_transit_gateway_route_table.zig");
const disassociate_trunk_interface = @import("disassociate_trunk_interface.zig");
const disassociate_vpc_cidr_block = @import("disassociate_vpc_cidr_block.zig");
const enable_address_transfer = @import("enable_address_transfer.zig");
const enable_allowed_images_settings = @import("enable_allowed_images_settings.zig");
const enable_aws_network_performance_metric_subscription = @import("enable_aws_network_performance_metric_subscription.zig");
const enable_capacity_manager = @import("enable_capacity_manager.zig");
const enable_ebs_encryption_by_default = @import("enable_ebs_encryption_by_default.zig");
const enable_fast_launch = @import("enable_fast_launch.zig");
const enable_fast_snapshot_restores = @import("enable_fast_snapshot_restores.zig");
const enable_image = @import("enable_image.zig");
const enable_image_block_public_access = @import("enable_image_block_public_access.zig");
const enable_image_deprecation = @import("enable_image_deprecation.zig");
const enable_image_deregistration_protection = @import("enable_image_deregistration_protection.zig");
const enable_instance_sql_ha_standby_detections = @import("enable_instance_sql_ha_standby_detections.zig");
const enable_ipam_organization_admin_account = @import("enable_ipam_organization_admin_account.zig");
const enable_ipam_policy = @import("enable_ipam_policy.zig");
const enable_reachability_analyzer_organization_sharing = @import("enable_reachability_analyzer_organization_sharing.zig");
const enable_route_server_propagation = @import("enable_route_server_propagation.zig");
const enable_serial_console_access = @import("enable_serial_console_access.zig");
const enable_snapshot_block_public_access = @import("enable_snapshot_block_public_access.zig");
const enable_transit_gateway_route_table_propagation = @import("enable_transit_gateway_route_table_propagation.zig");
const enable_vgw_route_propagation = @import("enable_vgw_route_propagation.zig");
const enable_volume_io = @import("enable_volume_io.zig");
const enable_vpc_classic_link = @import("enable_vpc_classic_link.zig");
const enable_vpc_classic_link_dns_support = @import("enable_vpc_classic_link_dns_support.zig");
const export_client_vpn_client_certificate_revocation_list = @import("export_client_vpn_client_certificate_revocation_list.zig");
const export_client_vpn_client_configuration = @import("export_client_vpn_client_configuration.zig");
const export_image = @import("export_image.zig");
const export_transit_gateway_routes = @import("export_transit_gateway_routes.zig");
const export_verified_access_instance_client_configuration = @import("export_verified_access_instance_client_configuration.zig");
const get_active_vpn_tunnel_status = @import("get_active_vpn_tunnel_status.zig");
const get_allowed_images_settings = @import("get_allowed_images_settings.zig");
const get_associated_enclave_certificate_iam_roles = @import("get_associated_enclave_certificate_iam_roles.zig");
const get_associated_ipv_6_pool_cidrs = @import("get_associated_ipv_6_pool_cidrs.zig");
const get_aws_network_performance_data = @import("get_aws_network_performance_data.zig");
const get_capacity_manager_attributes = @import("get_capacity_manager_attributes.zig");
const get_capacity_manager_metric_data = @import("get_capacity_manager_metric_data.zig");
const get_capacity_manager_metric_dimensions = @import("get_capacity_manager_metric_dimensions.zig");
const get_capacity_reservation_usage = @import("get_capacity_reservation_usage.zig");
const get_coip_pool_usage = @import("get_coip_pool_usage.zig");
const get_console_output = @import("get_console_output.zig");
const get_console_screenshot = @import("get_console_screenshot.zig");
const get_declarative_policies_report_summary = @import("get_declarative_policies_report_summary.zig");
const get_default_credit_specification = @import("get_default_credit_specification.zig");
const get_ebs_default_kms_key_id = @import("get_ebs_default_kms_key_id.zig");
const get_ebs_encryption_by_default = @import("get_ebs_encryption_by_default.zig");
const get_enabled_ipam_policy = @import("get_enabled_ipam_policy.zig");
const get_flow_logs_integration_template = @import("get_flow_logs_integration_template.zig");
const get_groups_for_capacity_reservation = @import("get_groups_for_capacity_reservation.zig");
const get_host_reservation_purchase_preview = @import("get_host_reservation_purchase_preview.zig");
const get_image_ancestry = @import("get_image_ancestry.zig");
const get_image_block_public_access_state = @import("get_image_block_public_access_state.zig");
const get_instance_metadata_defaults = @import("get_instance_metadata_defaults.zig");
const get_instance_tpm_ek_pub = @import("get_instance_tpm_ek_pub.zig");
const get_instance_types_from_instance_requirements = @import("get_instance_types_from_instance_requirements.zig");
const get_instance_uefi_data = @import("get_instance_uefi_data.zig");
const get_ipam_address_history = @import("get_ipam_address_history.zig");
const get_ipam_discovered_accounts = @import("get_ipam_discovered_accounts.zig");
const get_ipam_discovered_public_addresses = @import("get_ipam_discovered_public_addresses.zig");
const get_ipam_discovered_resource_cidrs = @import("get_ipam_discovered_resource_cidrs.zig");
const get_ipam_policy_allocation_rules = @import("get_ipam_policy_allocation_rules.zig");
const get_ipam_policy_organization_targets = @import("get_ipam_policy_organization_targets.zig");
const get_ipam_pool_allocations = @import("get_ipam_pool_allocations.zig");
const get_ipam_pool_cidrs = @import("get_ipam_pool_cidrs.zig");
const get_ipam_prefix_list_resolver_rules = @import("get_ipam_prefix_list_resolver_rules.zig");
const get_ipam_prefix_list_resolver_version_entries = @import("get_ipam_prefix_list_resolver_version_entries.zig");
const get_ipam_prefix_list_resolver_versions = @import("get_ipam_prefix_list_resolver_versions.zig");
const get_ipam_resource_cidrs = @import("get_ipam_resource_cidrs.zig");
const get_launch_template_data = @import("get_launch_template_data.zig");
const get_managed_prefix_list_associations = @import("get_managed_prefix_list_associations.zig");
const get_managed_prefix_list_entries = @import("get_managed_prefix_list_entries.zig");
const get_network_insights_access_scope_analysis_findings = @import("get_network_insights_access_scope_analysis_findings.zig");
const get_network_insights_access_scope_content = @import("get_network_insights_access_scope_content.zig");
const get_password_data = @import("get_password_data.zig");
const get_reserved_instances_exchange_quote = @import("get_reserved_instances_exchange_quote.zig");
const get_route_server_associations = @import("get_route_server_associations.zig");
const get_route_server_propagations = @import("get_route_server_propagations.zig");
const get_route_server_routing_database = @import("get_route_server_routing_database.zig");
const get_security_groups_for_vpc = @import("get_security_groups_for_vpc.zig");
const get_serial_console_access_status = @import("get_serial_console_access_status.zig");
const get_snapshot_block_public_access_state = @import("get_snapshot_block_public_access_state.zig");
const get_spot_placement_scores = @import("get_spot_placement_scores.zig");
const get_subnet_cidr_reservations = @import("get_subnet_cidr_reservations.zig");
const get_transit_gateway_attachment_propagations = @import("get_transit_gateway_attachment_propagations.zig");
const get_transit_gateway_metering_policy_entries = @import("get_transit_gateway_metering_policy_entries.zig");
const get_transit_gateway_multicast_domain_associations = @import("get_transit_gateway_multicast_domain_associations.zig");
const get_transit_gateway_policy_table_associations = @import("get_transit_gateway_policy_table_associations.zig");
const get_transit_gateway_policy_table_entries = @import("get_transit_gateway_policy_table_entries.zig");
const get_transit_gateway_prefix_list_references = @import("get_transit_gateway_prefix_list_references.zig");
const get_transit_gateway_route_table_associations = @import("get_transit_gateway_route_table_associations.zig");
const get_transit_gateway_route_table_propagations = @import("get_transit_gateway_route_table_propagations.zig");
const get_verified_access_endpoint_policy = @import("get_verified_access_endpoint_policy.zig");
const get_verified_access_endpoint_targets = @import("get_verified_access_endpoint_targets.zig");
const get_verified_access_group_policy = @import("get_verified_access_group_policy.zig");
const get_vpc_resources_blocking_encryption_enforcement = @import("get_vpc_resources_blocking_encryption_enforcement.zig");
const get_vpn_connection_device_sample_configuration = @import("get_vpn_connection_device_sample_configuration.zig");
const get_vpn_connection_device_types = @import("get_vpn_connection_device_types.zig");
const get_vpn_tunnel_replacement_status = @import("get_vpn_tunnel_replacement_status.zig");
const import_client_vpn_client_certificate_revocation_list = @import("import_client_vpn_client_certificate_revocation_list.zig");
const import_image = @import("import_image.zig");
const import_instance = @import("import_instance.zig");
const import_key_pair = @import("import_key_pair.zig");
const import_snapshot = @import("import_snapshot.zig");
const import_volume = @import("import_volume.zig");
const list_images_in_recycle_bin = @import("list_images_in_recycle_bin.zig");
const list_snapshots_in_recycle_bin = @import("list_snapshots_in_recycle_bin.zig");
const list_volumes_in_recycle_bin = @import("list_volumes_in_recycle_bin.zig");
const lock_snapshot = @import("lock_snapshot.zig");
const modify_address_attribute = @import("modify_address_attribute.zig");
const modify_availability_zone_group = @import("modify_availability_zone_group.zig");
const modify_capacity_reservation = @import("modify_capacity_reservation.zig");
const modify_capacity_reservation_fleet = @import("modify_capacity_reservation_fleet.zig");
const modify_client_vpn_endpoint = @import("modify_client_vpn_endpoint.zig");
const modify_default_credit_specification = @import("modify_default_credit_specification.zig");
const modify_ebs_default_kms_key_id = @import("modify_ebs_default_kms_key_id.zig");
const modify_fleet = @import("modify_fleet.zig");
const modify_fpga_image_attribute = @import("modify_fpga_image_attribute.zig");
const modify_hosts = @import("modify_hosts.zig");
const modify_id_format = @import("modify_id_format.zig");
const modify_identity_id_format = @import("modify_identity_id_format.zig");
const modify_image_attribute = @import("modify_image_attribute.zig");
const modify_instance_attribute = @import("modify_instance_attribute.zig");
const modify_instance_capacity_reservation_attributes = @import("modify_instance_capacity_reservation_attributes.zig");
const modify_instance_connect_endpoint = @import("modify_instance_connect_endpoint.zig");
const modify_instance_cpu_options = @import("modify_instance_cpu_options.zig");
const modify_instance_credit_specification = @import("modify_instance_credit_specification.zig");
const modify_instance_event_start_time = @import("modify_instance_event_start_time.zig");
const modify_instance_event_window = @import("modify_instance_event_window.zig");
const modify_instance_maintenance_options = @import("modify_instance_maintenance_options.zig");
const modify_instance_metadata_defaults = @import("modify_instance_metadata_defaults.zig");
const modify_instance_metadata_options = @import("modify_instance_metadata_options.zig");
const modify_instance_network_performance_options = @import("modify_instance_network_performance_options.zig");
const modify_instance_placement = @import("modify_instance_placement.zig");
const modify_ipam = @import("modify_ipam.zig");
const modify_ipam_policy_allocation_rules = @import("modify_ipam_policy_allocation_rules.zig");
const modify_ipam_pool = @import("modify_ipam_pool.zig");
const modify_ipam_prefix_list_resolver = @import("modify_ipam_prefix_list_resolver.zig");
const modify_ipam_prefix_list_resolver_target = @import("modify_ipam_prefix_list_resolver_target.zig");
const modify_ipam_resource_cidr = @import("modify_ipam_resource_cidr.zig");
const modify_ipam_resource_discovery = @import("modify_ipam_resource_discovery.zig");
const modify_ipam_scope = @import("modify_ipam_scope.zig");
const modify_launch_template = @import("modify_launch_template.zig");
const modify_local_gateway_route = @import("modify_local_gateway_route.zig");
const modify_managed_prefix_list = @import("modify_managed_prefix_list.zig");
const modify_network_interface_attribute = @import("modify_network_interface_attribute.zig");
const modify_private_dns_name_options = @import("modify_private_dns_name_options.zig");
const modify_public_ip_dns_name_options = @import("modify_public_ip_dns_name_options.zig");
const modify_reserved_instances = @import("modify_reserved_instances.zig");
const modify_route_server = @import("modify_route_server.zig");
const modify_security_group_rules = @import("modify_security_group_rules.zig");
const modify_snapshot_attribute = @import("modify_snapshot_attribute.zig");
const modify_snapshot_tier = @import("modify_snapshot_tier.zig");
const modify_spot_fleet_request = @import("modify_spot_fleet_request.zig");
const modify_subnet_attribute = @import("modify_subnet_attribute.zig");
const modify_traffic_mirror_filter_network_services = @import("modify_traffic_mirror_filter_network_services.zig");
const modify_traffic_mirror_filter_rule = @import("modify_traffic_mirror_filter_rule.zig");
const modify_traffic_mirror_session = @import("modify_traffic_mirror_session.zig");
const modify_transit_gateway = @import("modify_transit_gateway.zig");
const modify_transit_gateway_metering_policy = @import("modify_transit_gateway_metering_policy.zig");
const modify_transit_gateway_prefix_list_reference = @import("modify_transit_gateway_prefix_list_reference.zig");
const modify_transit_gateway_vpc_attachment = @import("modify_transit_gateway_vpc_attachment.zig");
const modify_verified_access_endpoint = @import("modify_verified_access_endpoint.zig");
const modify_verified_access_endpoint_policy = @import("modify_verified_access_endpoint_policy.zig");
const modify_verified_access_group = @import("modify_verified_access_group.zig");
const modify_verified_access_group_policy = @import("modify_verified_access_group_policy.zig");
const modify_verified_access_instance = @import("modify_verified_access_instance.zig");
const modify_verified_access_instance_logging_configuration = @import("modify_verified_access_instance_logging_configuration.zig");
const modify_verified_access_trust_provider = @import("modify_verified_access_trust_provider.zig");
const modify_volume = @import("modify_volume.zig");
const modify_volume_attribute = @import("modify_volume_attribute.zig");
const modify_vpc_attribute = @import("modify_vpc_attribute.zig");
const modify_vpc_block_public_access_exclusion = @import("modify_vpc_block_public_access_exclusion.zig");
const modify_vpc_block_public_access_options = @import("modify_vpc_block_public_access_options.zig");
const modify_vpc_encryption_control = @import("modify_vpc_encryption_control.zig");
const modify_vpc_endpoint = @import("modify_vpc_endpoint.zig");
const modify_vpc_endpoint_connection_notification = @import("modify_vpc_endpoint_connection_notification.zig");
const modify_vpc_endpoint_service_configuration = @import("modify_vpc_endpoint_service_configuration.zig");
const modify_vpc_endpoint_service_payer_responsibility = @import("modify_vpc_endpoint_service_payer_responsibility.zig");
const modify_vpc_endpoint_service_permissions = @import("modify_vpc_endpoint_service_permissions.zig");
const modify_vpc_peering_connection_options = @import("modify_vpc_peering_connection_options.zig");
const modify_vpc_tenancy = @import("modify_vpc_tenancy.zig");
const modify_vpn_connection = @import("modify_vpn_connection.zig");
const modify_vpn_connection_options = @import("modify_vpn_connection_options.zig");
const modify_vpn_tunnel_certificate = @import("modify_vpn_tunnel_certificate.zig");
const modify_vpn_tunnel_options = @import("modify_vpn_tunnel_options.zig");
const monitor_instances = @import("monitor_instances.zig");
const move_address_to_vpc = @import("move_address_to_vpc.zig");
const move_byoip_cidr_to_ipam = @import("move_byoip_cidr_to_ipam.zig");
const move_capacity_reservation_instances = @import("move_capacity_reservation_instances.zig");
const provision_byoip_cidr = @import("provision_byoip_cidr.zig");
const provision_ipam_byoasn = @import("provision_ipam_byoasn.zig");
const provision_ipam_pool_cidr = @import("provision_ipam_pool_cidr.zig");
const provision_public_ipv_4_pool_cidr = @import("provision_public_ipv_4_pool_cidr.zig");
const purchase_capacity_block = @import("purchase_capacity_block.zig");
const purchase_capacity_block_extension = @import("purchase_capacity_block_extension.zig");
const purchase_host_reservation = @import("purchase_host_reservation.zig");
const purchase_reserved_instances_offering = @import("purchase_reserved_instances_offering.zig");
const purchase_scheduled_instances = @import("purchase_scheduled_instances.zig");
const reboot_instances = @import("reboot_instances.zig");
const register_image = @import("register_image.zig");
const register_instance_event_notification_attributes = @import("register_instance_event_notification_attributes.zig");
const register_transit_gateway_multicast_group_members = @import("register_transit_gateway_multicast_group_members.zig");
const register_transit_gateway_multicast_group_sources = @import("register_transit_gateway_multicast_group_sources.zig");
const reject_capacity_reservation_billing_ownership = @import("reject_capacity_reservation_billing_ownership.zig");
const reject_transit_gateway_multicast_domain_associations = @import("reject_transit_gateway_multicast_domain_associations.zig");
const reject_transit_gateway_peering_attachment = @import("reject_transit_gateway_peering_attachment.zig");
const reject_transit_gateway_vpc_attachment = @import("reject_transit_gateway_vpc_attachment.zig");
const reject_vpc_endpoint_connections = @import("reject_vpc_endpoint_connections.zig");
const reject_vpc_peering_connection = @import("reject_vpc_peering_connection.zig");
const release_address = @import("release_address.zig");
const release_hosts = @import("release_hosts.zig");
const release_ipam_pool_allocation = @import("release_ipam_pool_allocation.zig");
const replace_iam_instance_profile_association = @import("replace_iam_instance_profile_association.zig");
const replace_image_criteria_in_allowed_images_settings = @import("replace_image_criteria_in_allowed_images_settings.zig");
const replace_network_acl_association = @import("replace_network_acl_association.zig");
const replace_network_acl_entry = @import("replace_network_acl_entry.zig");
const replace_route = @import("replace_route.zig");
const replace_route_table_association = @import("replace_route_table_association.zig");
const replace_transit_gateway_route = @import("replace_transit_gateway_route.zig");
const replace_vpn_tunnel = @import("replace_vpn_tunnel.zig");
const report_instance_status = @import("report_instance_status.zig");
const request_spot_fleet = @import("request_spot_fleet.zig");
const request_spot_instances = @import("request_spot_instances.zig");
const reset_address_attribute = @import("reset_address_attribute.zig");
const reset_ebs_default_kms_key_id = @import("reset_ebs_default_kms_key_id.zig");
const reset_fpga_image_attribute = @import("reset_fpga_image_attribute.zig");
const reset_image_attribute = @import("reset_image_attribute.zig");
const reset_instance_attribute = @import("reset_instance_attribute.zig");
const reset_network_interface_attribute = @import("reset_network_interface_attribute.zig");
const reset_snapshot_attribute = @import("reset_snapshot_attribute.zig");
const restore_address_to_classic = @import("restore_address_to_classic.zig");
const restore_image_from_recycle_bin = @import("restore_image_from_recycle_bin.zig");
const restore_managed_prefix_list_version = @import("restore_managed_prefix_list_version.zig");
const restore_snapshot_from_recycle_bin = @import("restore_snapshot_from_recycle_bin.zig");
const restore_snapshot_tier = @import("restore_snapshot_tier.zig");
const restore_volume_from_recycle_bin = @import("restore_volume_from_recycle_bin.zig");
const revoke_client_vpn_ingress = @import("revoke_client_vpn_ingress.zig");
const revoke_security_group_egress = @import("revoke_security_group_egress.zig");
const revoke_security_group_ingress = @import("revoke_security_group_ingress.zig");
const run_instances = @import("run_instances.zig");
const run_scheduled_instances = @import("run_scheduled_instances.zig");
const search_local_gateway_routes = @import("search_local_gateway_routes.zig");
const search_transit_gateway_multicast_groups = @import("search_transit_gateway_multicast_groups.zig");
const search_transit_gateway_routes = @import("search_transit_gateway_routes.zig");
const send_diagnostic_interrupt = @import("send_diagnostic_interrupt.zig");
const start_declarative_policies_report = @import("start_declarative_policies_report.zig");
const start_instances = @import("start_instances.zig");
const start_network_insights_access_scope_analysis = @import("start_network_insights_access_scope_analysis.zig");
const start_network_insights_analysis = @import("start_network_insights_analysis.zig");
const start_vpc_endpoint_service_private_dns_verification = @import("start_vpc_endpoint_service_private_dns_verification.zig");
const stop_instances = @import("stop_instances.zig");
const terminate_client_vpn_connections = @import("terminate_client_vpn_connections.zig");
const terminate_instances = @import("terminate_instances.zig");
const unassign_ipv_6_addresses = @import("unassign_ipv_6_addresses.zig");
const unassign_private_ip_addresses = @import("unassign_private_ip_addresses.zig");
const unassign_private_nat_gateway_address = @import("unassign_private_nat_gateway_address.zig");
const unlock_snapshot = @import("unlock_snapshot.zig");
const unmonitor_instances = @import("unmonitor_instances.zig");
const update_capacity_manager_organizations_access = @import("update_capacity_manager_organizations_access.zig");
const update_interruptible_capacity_reservation_allocation = @import("update_interruptible_capacity_reservation_allocation.zig");
const update_security_group_rule_descriptions_egress = @import("update_security_group_rule_descriptions_egress.zig");
const update_security_group_rule_descriptions_ingress = @import("update_security_group_rule_descriptions_ingress.zig");
const withdraw_byoip_cidr = @import("withdraw_byoip_cidr.zig");
const CallOptions = @import("call_options.zig").CallOptions;
const paginator = @import("paginator.zig");
const waiters = @import("waiters.zig");

pub const Client = struct {
    allocator: std.mem.Allocator,
    config: *aws.Config,
    http_client: aws.http.HttpClient,

    const Self = @This();
    pub const sdk_id = "EC2";

    pub fn init(allocator: std.mem.Allocator, config: *aws.Config) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode }),
        };
    }

    pub fn initWithOptions(allocator: std.mem.Allocator, config: *aws.Config, options: aws.http.RequestOptions) Self {
        return .{
            .allocator = allocator,
            .config = config,
            .http_client = aws.http.HttpClient.init(allocator, .{ .retry_mode = config.retry_mode, .request_options = options }),
        };
    }

    pub fn deinit(self: *Self) void {
        self.http_client.deinit();
    }

    /// Accepts an Elastic IP address transfer. For more information, see [Accept a
    /// transferred Elastic IP
    /// address](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-eips.html#using-instance-addressing-eips-transfer-accept) in the *Amazon VPC User Guide*.
    pub fn acceptAddressTransfer(self: *Self, allocator: std.mem.Allocator, input: accept_address_transfer.AcceptAddressTransferInput, options: CallOptions) !accept_address_transfer.AcceptAddressTransferOutput {
        return accept_address_transfer.execute(self, allocator, input, options);
    }

    /// Accepts a request to assign billing of the available capacity of a shared
    /// Capacity
    /// Reservation to your account. For more information, see [ Billing assignment
    /// for shared
    /// Amazon EC2 Capacity
    /// Reservations](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/assign-billing.html).
    pub fn acceptCapacityReservationBillingOwnership(self: *Self, allocator: std.mem.Allocator, input: accept_capacity_reservation_billing_ownership.AcceptCapacityReservationBillingOwnershipInput, options: CallOptions) !accept_capacity_reservation_billing_ownership.AcceptCapacityReservationBillingOwnershipOutput {
        return accept_capacity_reservation_billing_ownership.execute(self, allocator, input, options);
    }

    /// Accepts the Convertible Reserved Instance exchange quote described in the
    /// GetReservedInstancesExchangeQuote call.
    pub fn acceptReservedInstancesExchangeQuote(self: *Self, allocator: std.mem.Allocator, input: accept_reserved_instances_exchange_quote.AcceptReservedInstancesExchangeQuoteInput, options: CallOptions) !accept_reserved_instances_exchange_quote.AcceptReservedInstancesExchangeQuoteOutput {
        return accept_reserved_instances_exchange_quote.execute(self, allocator, input, options);
    }

    /// Accepts a request to associate subnets with a transit gateway multicast
    /// domain.
    pub fn acceptTransitGatewayMulticastDomainAssociations(self: *Self, allocator: std.mem.Allocator, input: accept_transit_gateway_multicast_domain_associations.AcceptTransitGatewayMulticastDomainAssociationsInput, options: CallOptions) !accept_transit_gateway_multicast_domain_associations.AcceptTransitGatewayMulticastDomainAssociationsOutput {
        return accept_transit_gateway_multicast_domain_associations.execute(self, allocator, input, options);
    }

    /// Accepts a transit gateway peering attachment request. The peering attachment
    /// must be
    /// in the `pendingAcceptance` state.
    pub fn acceptTransitGatewayPeeringAttachment(self: *Self, allocator: std.mem.Allocator, input: accept_transit_gateway_peering_attachment.AcceptTransitGatewayPeeringAttachmentInput, options: CallOptions) !accept_transit_gateway_peering_attachment.AcceptTransitGatewayPeeringAttachmentOutput {
        return accept_transit_gateway_peering_attachment.execute(self, allocator, input, options);
    }

    /// Accepts a request to attach a VPC to a transit gateway.
    ///
    /// The VPC attachment must be in the `pendingAcceptance` state.
    /// Use DescribeTransitGatewayVpcAttachments to view your pending VPC attachment
    /// requests.
    /// Use RejectTransitGatewayVpcAttachment to reject a VPC attachment request.
    pub fn acceptTransitGatewayVpcAttachment(self: *Self, allocator: std.mem.Allocator, input: accept_transit_gateway_vpc_attachment.AcceptTransitGatewayVpcAttachmentInput, options: CallOptions) !accept_transit_gateway_vpc_attachment.AcceptTransitGatewayVpcAttachmentOutput {
        return accept_transit_gateway_vpc_attachment.execute(self, allocator, input, options);
    }

    /// Accepts connection requests to your VPC endpoint service.
    pub fn acceptVpcEndpointConnections(self: *Self, allocator: std.mem.Allocator, input: accept_vpc_endpoint_connections.AcceptVpcEndpointConnectionsInput, options: CallOptions) !accept_vpc_endpoint_connections.AcceptVpcEndpointConnectionsOutput {
        return accept_vpc_endpoint_connections.execute(self, allocator, input, options);
    }

    /// Accept a VPC peering connection request. To accept a request, the VPC
    /// peering connection must
    /// be in the `pending-acceptance` state, and you must be the owner of the peer
    /// VPC.
    /// Use DescribeVpcPeeringConnections to view your outstanding VPC
    /// peering connection requests.
    ///
    /// For an inter-Region VPC peering connection request, you must accept the VPC
    /// peering
    /// connection in the Region of the accepter VPC.
    pub fn acceptVpcPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: accept_vpc_peering_connection.AcceptVpcPeeringConnectionInput, options: CallOptions) !accept_vpc_peering_connection.AcceptVpcPeeringConnectionOutput {
        return accept_vpc_peering_connection.execute(self, allocator, input, options);
    }

    /// Advertises an IPv4 or IPv6 address range that is provisioned for use with
    /// your Amazon Web Services resources through
    /// bring your own IP addresses (BYOIP).
    ///
    /// You can perform this operation at most once every 10 seconds, even if you
    /// specify different
    /// address ranges each time.
    ///
    /// We recommend that you stop advertising the BYOIP CIDR from other locations
    /// when you advertise
    /// it from Amazon Web Services. To minimize down time, you can configure your
    /// Amazon Web Services resources to use an address from a
    /// BYOIP CIDR before it is advertised, and then simultaneously stop advertising
    /// it from the current
    /// location and start advertising it through Amazon Web Services.
    ///
    /// It can take a few minutes before traffic to the specified addresses starts
    /// routing to Amazon Web Services
    /// because of BGP propagation delays.
    pub fn advertiseByoipCidr(self: *Self, allocator: std.mem.Allocator, input: advertise_byoip_cidr.AdvertiseByoipCidrInput, options: CallOptions) !advertise_byoip_cidr.AdvertiseByoipCidrOutput {
        return advertise_byoip_cidr.execute(self, allocator, input, options);
    }

    /// Allocates an Elastic IP address to your Amazon Web Services account. After
    /// you allocate the Elastic IP address you can associate
    /// it with an instance or network interface. After you release an Elastic IP
    /// address, it is released to the IP address
    /// pool and can be allocated to a different Amazon Web Services account.
    ///
    /// You can allocate an Elastic IP address from one of the following address
    /// pools:
    ///
    /// * Amazon's pool of IPv4 addresses
    ///
    /// * Public IPv4 address range that you own and bring to your Amazon Web
    ///   Services account using
    /// [Bring Your Own IP Addresses
    /// (BYOIP)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-byoip.html)
    ///
    /// * An IPv4 IPAM pool with an Amazon-provided or BYOIP public IPv4 address
    ///   range
    ///
    /// * IPv4 addresses from your on-premises network made available for use with
    ///   an Outpost
    /// using a [customer-owned IP address
    /// pool](https://docs.aws.amazon.com/outposts/latest/userguide/routing.html#ip-addressing) (CoIP pool)
    ///
    /// For more information, see [Elastic IP
    /// Addresses](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html) in the *Amazon EC2 User Guide*.
    ///
    /// If you release an Elastic IP address, you might be able to recover it. You
    /// cannot recover
    /// an Elastic IP address that you released after it is allocated to another
    /// Amazon Web Services account. To attempt to recover an Elastic IP address
    /// that you released, specify
    /// it in this operation.
    ///
    /// You can allocate a carrier IP address which is a public IP address from a
    /// telecommunication carrier,
    /// to a network interface which resides in a subnet in a Wavelength Zone (for
    /// example an EC2 instance).
    pub fn allocateAddress(self: *Self, allocator: std.mem.Allocator, input: allocate_address.AllocateAddressInput, options: CallOptions) !allocate_address.AllocateAddressOutput {
        return allocate_address.execute(self, allocator, input, options);
    }

    /// Allocates a Dedicated Host to your account. At a minimum, specify the
    /// supported
    /// instance type or instance family, the Availability Zone in which to allocate
    /// the host,
    /// and the number of hosts to allocate.
    pub fn allocateHosts(self: *Self, allocator: std.mem.Allocator, input: allocate_hosts.AllocateHostsInput, options: CallOptions) !allocate_hosts.AllocateHostsOutput {
        return allocate_hosts.execute(self, allocator, input, options);
    }

    /// Allocate a CIDR from an IPAM pool. The Region you use should be the IPAM
    /// pool locale. The locale is the Amazon Web Services Region where this IPAM
    /// pool is available for allocations.
    ///
    /// In IPAM, an allocation is a CIDR assignment from an IPAM pool to another
    /// IPAM pool or to a resource. For more information, see [Allocate
    /// CIDRs](https://docs.aws.amazon.com/vpc/latest/ipam/allocate-cidrs-ipam.html)
    /// in the *Amazon VPC IPAM User Guide*.
    ///
    /// This action creates an allocation with strong consistency. The returned CIDR
    /// will not overlap with any other allocations from the same pool.
    pub fn allocateIpamPoolCidr(self: *Self, allocator: std.mem.Allocator, input: allocate_ipam_pool_cidr.AllocateIpamPoolCidrInput, options: CallOptions) !allocate_ipam_pool_cidr.AllocateIpamPoolCidrOutput {
        return allocate_ipam_pool_cidr.execute(self, allocator, input, options);
    }

    /// Applies a security group to the association between the target network and
    /// the Client VPN endpoint. This action replaces the existing
    /// security groups with the specified security groups.
    pub fn applySecurityGroupsToClientVpnTargetNetwork(self: *Self, allocator: std.mem.Allocator, input: apply_security_groups_to_client_vpn_target_network.ApplySecurityGroupsToClientVpnTargetNetworkInput, options: CallOptions) !apply_security_groups_to_client_vpn_target_network.ApplySecurityGroupsToClientVpnTargetNetworkOutput {
        return apply_security_groups_to_client_vpn_target_network.execute(self, allocator, input, options);
    }

    /// Assigns the specified IPv6 addresses to the specified network interface. You
    /// can
    /// specify specific IPv6 addresses, or you can specify the number of IPv6
    /// addresses to be
    /// automatically assigned from the subnet's IPv6 CIDR block range. You can
    /// assign as many
    /// IPv6 addresses to a network interface as you can assign private IPv4
    /// addresses, and the
    /// limit varies by instance type.
    ///
    /// You must specify either the IPv6 addresses or the IPv6 address count in the
    /// request.
    ///
    /// You can optionally use Prefix Delegation on the network interface. You must
    /// specify
    /// either the IPV6 Prefix Delegation prefixes, or the IPv6 Prefix Delegation
    /// count. For
    /// information, see [ Assigning prefixes to network
    /// interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-prefix-eni.html) in the *Amazon EC2 User Guide*.
    pub fn assignIpv6Addresses(self: *Self, allocator: std.mem.Allocator, input: assign_ipv_6_addresses.AssignIpv6AddressesInput, options: CallOptions) !assign_ipv_6_addresses.AssignIpv6AddressesOutput {
        return assign_ipv_6_addresses.execute(self, allocator, input, options);
    }

    /// Assigns the specified secondary private IP addresses to the specified
    /// network
    /// interface.
    ///
    /// You can specify specific secondary IP addresses, or you can specify the
    /// number of
    /// secondary IP addresses to be automatically assigned from the subnet's CIDR
    /// block range.
    /// The number of secondary IP addresses that you can assign to an instance
    /// varies by
    /// instance type. For more information about Elastic IP addresses, see [Elastic
    /// IP
    /// Addresses](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html) in the *Amazon EC2 User Guide*.
    ///
    /// When you move a secondary private IP address to another network interface,
    /// any Elastic
    /// IP address that is associated with the IP address is also moved.
    ///
    /// Remapping an IP address is an asynchronous operation. When you move an IP
    /// address from
    /// one network interface to another, check
    /// `network/interfaces/macs/mac/local-ipv4s` in the instance metadata to
    /// confirm that the remapping is complete.
    ///
    /// You must specify either the IP addresses or the IP address count in the
    /// request.
    ///
    /// You can optionally use Prefix Delegation on the network interface. You must
    /// specify
    /// either the IPv4 Prefix Delegation prefixes, or the IPv4 Prefix Delegation
    /// count. For
    /// information, see [ Assigning prefixes to network
    /// interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-prefix-eni.html) in the *Amazon EC2 User Guide*.
    pub fn assignPrivateIpAddresses(self: *Self, allocator: std.mem.Allocator, input: assign_private_ip_addresses.AssignPrivateIpAddressesInput, options: CallOptions) !assign_private_ip_addresses.AssignPrivateIpAddressesOutput {
        return assign_private_ip_addresses.execute(self, allocator, input, options);
    }

    /// Assigns private IPv4 addresses to a private NAT gateway. For more
    /// information, see
    /// [Work with NAT
    /// gateways](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html) in the *Amazon VPC User Guide*.
    pub fn assignPrivateNatGatewayAddress(self: *Self, allocator: std.mem.Allocator, input: assign_private_nat_gateway_address.AssignPrivateNatGatewayAddressInput, options: CallOptions) !assign_private_nat_gateway_address.AssignPrivateNatGatewayAddressOutput {
        return assign_private_nat_gateway_address.execute(self, allocator, input, options);
    }

    /// Associates an Elastic IP address, or carrier IP address (for instances that
    /// are in
    /// subnets in Wavelength Zones) with an instance or a network interface. Before
    /// you can use an
    /// Elastic IP address, you must allocate it to your account.
    ///
    /// If the Elastic IP address is already
    /// associated with a different instance, it is disassociated from that instance
    /// and associated
    /// with the specified instance. If you associate an Elastic IP address with an
    /// instance that has
    /// an existing Elastic IP address, the existing address is disassociated from
    /// the instance, but
    /// remains allocated to your account.
    ///
    /// [Subnets in Wavelength Zones] You can associate an IP address from the
    /// telecommunication
    /// carrier to the instance or network interface.
    ///
    /// You cannot associate an Elastic IP address with an interface in a different
    /// network border group.
    ///
    /// This is an idempotent operation. If you perform the operation more than
    /// once, Amazon EC2
    /// doesn't return an error, and you may be charged for each time the Elastic IP
    /// address is
    /// remapped to the same instance. For more information, see the *Elastic IP
    /// Addresses* section of [Amazon EC2
    /// Pricing](http://aws.amazon.com/ec2/pricing/).
    pub fn associateAddress(self: *Self, allocator: std.mem.Allocator, input: associate_address.AssociateAddressInput, options: CallOptions) !associate_address.AssociateAddressOutput {
        return associate_address.execute(self, allocator, input, options);
    }

    /// Initiates a request to assign billing of the unused capacity of a shared
    /// Capacity
    /// Reservation to a consumer account that is consolidated under the same Amazon
    /// Web Services
    /// organizations payer account. For more information, see [Billing assignment
    /// for shared
    /// Amazon EC2 Capacity
    /// Reservations](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/assign-billing.html).
    pub fn associateCapacityReservationBillingOwner(self: *Self, allocator: std.mem.Allocator, input: associate_capacity_reservation_billing_owner.AssociateCapacityReservationBillingOwnerInput, options: CallOptions) !associate_capacity_reservation_billing_owner.AssociateCapacityReservationBillingOwnerOutput {
        return associate_capacity_reservation_billing_owner.execute(self, allocator, input, options);
    }

    /// Associates a target network with a Client VPN endpoint. A target network is
    /// a subnet in a VPC. You can associate multiple subnets from the same VPC with
    /// a Client VPN endpoint. You can associate only one subnet in each
    /// Availability Zone. We recommend that you associate at least two subnets to
    /// provide Availability Zone redundancy.
    ///
    /// If you specified a VPC when you created the Client VPN endpoint or if you
    /// have previous subnet associations, the specified subnet must be in the same
    /// VPC. To specify a subnet that's in a different VPC, you must first modify
    /// the Client VPN endpoint (ModifyClientVpnEndpoint) and change the VPC that's
    /// associated with it.
    pub fn associateClientVpnTargetNetwork(self: *Self, allocator: std.mem.Allocator, input: associate_client_vpn_target_network.AssociateClientVpnTargetNetworkInput, options: CallOptions) !associate_client_vpn_target_network.AssociateClientVpnTargetNetworkOutput {
        return associate_client_vpn_target_network.execute(self, allocator, input, options);
    }

    /// Associates a set of DHCP options (that you've previously created) with the
    /// specified VPC, or associates no DHCP options with the VPC.
    ///
    /// After you associate the options with the VPC, any existing instances and all
    /// new instances that you launch in that VPC use the options. You don't need to
    /// restart or relaunch the instances. They automatically pick up the changes
    /// within a few hours, depending on how frequently the instance renews its DHCP
    /// lease. You can explicitly renew the lease using the operating system on the
    /// instance.
    ///
    /// For more information, see [DHCP option
    /// sets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_DHCP_Options.html)
    /// in the *Amazon VPC User Guide*.
    pub fn associateDhcpOptions(self: *Self, allocator: std.mem.Allocator, input: associate_dhcp_options.AssociateDhcpOptionsInput, options: CallOptions) !associate_dhcp_options.AssociateDhcpOptionsOutput {
        return associate_dhcp_options.execute(self, allocator, input, options);
    }

    /// Associates an Identity and Access Management (IAM) role with an Certificate
    /// Manager (ACM) certificate.
    /// This enables the certificate to be used by the ACM for Nitro Enclaves
    /// application inside an enclave. For more
    /// information, see [Certificate Manager for Nitro
    /// Enclaves](https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave-refapp.html) in the *Amazon Web Services Nitro Enclaves
    /// User Guide*.
    ///
    /// When the IAM role is associated with the ACM certificate, the certificate,
    /// certificate chain, and encrypted
    /// private key are placed in an Amazon S3 location that only the associated IAM
    /// role can access. The private key of the certificate
    /// is encrypted with an Amazon Web Services managed key that has an attached
    /// attestation-based key policy.
    ///
    /// To enable the IAM role to access the Amazon S3 object, you must grant it
    /// permission to call `s3:GetObject`
    /// on the Amazon S3 bucket returned by the command. To enable the IAM role to
    /// access the KMS key,
    /// you must grant it permission to call `kms:Decrypt` on the KMS key returned
    /// by the command.
    /// For more information, see [
    /// Grant the role permission to access the certificate and encryption
    /// key](https://docs.aws.amazon.com/enclaves/latest/user/nitro-enclave-refapp.html#add-policy) in the
    /// *Amazon Web Services Nitro Enclaves User Guide*.
    pub fn associateEnclaveCertificateIamRole(self: *Self, allocator: std.mem.Allocator, input: associate_enclave_certificate_iam_role.AssociateEnclaveCertificateIamRoleInput, options: CallOptions) !associate_enclave_certificate_iam_role.AssociateEnclaveCertificateIamRoleOutput {
        return associate_enclave_certificate_iam_role.execute(self, allocator, input, options);
    }

    /// Associates an IAM instance profile with a running or stopped instance. You
    /// cannot
    /// associate more than one IAM instance profile with an instance.
    pub fn associateIamInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: associate_iam_instance_profile.AssociateIamInstanceProfileInput, options: CallOptions) !associate_iam_instance_profile.AssociateIamInstanceProfileOutput {
        return associate_iam_instance_profile.execute(self, allocator, input, options);
    }

    /// Associates one or more targets with an event window. Only one type of target
    /// (instance
    /// IDs, Dedicated Host IDs, or tags) can be specified with an event window.
    ///
    /// For more information, see [Define event windows for scheduled
    /// events](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/event-windows.html) in the *Amazon EC2 User Guide*.
    pub fn associateInstanceEventWindow(self: *Self, allocator: std.mem.Allocator, input: associate_instance_event_window.AssociateInstanceEventWindowInput, options: CallOptions) !associate_instance_event_window.AssociateInstanceEventWindowOutput {
        return associate_instance_event_window.execute(self, allocator, input, options);
    }

    /// Associates your Autonomous System Number (ASN) with a BYOIP CIDR that you
    /// own in the same Amazon Web Services Region.
    /// For more information, see [Tutorial: Bring your ASN to
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoasn.html) in
    /// the *Amazon VPC IPAM guide*.
    ///
    /// After the association succeeds, the ASN is eligible for
    /// advertisement. You can view the association with
    /// [DescribeByoipCidrs](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeByoipCidrs.html). You can advertise the CIDR with [AdvertiseByoipCidr](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AdvertiseByoipCidr.html).
    pub fn associateIpamByoasn(self: *Self, allocator: std.mem.Allocator, input: associate_ipam_byoasn.AssociateIpamByoasnInput, options: CallOptions) !associate_ipam_byoasn.AssociateIpamByoasnOutput {
        return associate_ipam_byoasn.execute(self, allocator, input, options);
    }

    /// Associates an IPAM resource discovery with an Amazon VPC IPAM. A resource
    /// discovery is an IPAM component that enables IPAM to manage and monitor
    /// resources that belong to the owning account.
    pub fn associateIpamResourceDiscovery(self: *Self, allocator: std.mem.Allocator, input: associate_ipam_resource_discovery.AssociateIpamResourceDiscoveryInput, options: CallOptions) !associate_ipam_resource_discovery.AssociateIpamResourceDiscoveryOutput {
        return associate_ipam_resource_discovery.execute(self, allocator, input, options);
    }

    /// Associates Elastic IP addresses (EIPs) and private IPv4 addresses with a
    /// public NAT gateway. For more information,
    /// see [Work with NAT
    /// gateways](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html) in the *Amazon VPC User Guide*.
    ///
    /// By default, you can associate up to 2 Elastic IP addresses per public NAT
    /// gateway. You can increase the limit by requesting a quota adjustment.
    /// For more information, see [Elastic IP address
    /// quotas](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html#vpc-limits-eips) in the *Amazon VPC User Guide*.
    ///
    /// When you associate an EIP or secondary EIPs with a public NAT gateway, the
    /// network border group of the EIPs
    /// must match the network border group of the Availability Zone (AZ) that the
    /// public NAT gateway is in. If it's not the same,
    /// the EIP will fail to associate. You can see the network border group for the
    /// subnet's AZ by viewing the details of the subnet.
    /// Similarly, you can view the network border group of an EIP by viewing the
    /// details of the EIP address. For more information
    /// about network border groups and EIPs, see [Allocate an Elastic IP
    /// address](https://docs.aws.amazon.com/vpc/latest/userguide/WorkWithEIPs.html)
    /// in the *Amazon VPC User Guide*.
    pub fn associateNatGatewayAddress(self: *Self, allocator: std.mem.Allocator, input: associate_nat_gateway_address.AssociateNatGatewayAddressInput, options: CallOptions) !associate_nat_gateway_address.AssociateNatGatewayAddressOutput {
        return associate_nat_gateway_address.execute(self, allocator, input, options);
    }

    /// Associates a route server with a VPC to enable dynamic route updates.
    ///
    /// A route server association is the connection established between a route
    /// server and a VPC.
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn associateRouteServer(self: *Self, allocator: std.mem.Allocator, input: associate_route_server.AssociateRouteServerInput, options: CallOptions) !associate_route_server.AssociateRouteServerOutput {
        return associate_route_server.execute(self, allocator, input, options);
    }

    /// Associates a subnet in your VPC or an internet gateway or virtual private
    /// gateway
    /// attached to your VPC with a route table in your VPC. This association causes
    /// traffic
    /// from the subnet or gateway to be routed according to the routes in the route
    /// table. The
    /// action returns an association ID, which you need in order to disassociate
    /// the route
    /// table later. A route table can be associated with multiple subnets.
    ///
    /// For more information, see [Route
    /// tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html) in the
    /// *Amazon VPC User Guide*.
    pub fn associateRouteTable(self: *Self, allocator: std.mem.Allocator, input: associate_route_table.AssociateRouteTableInput, options: CallOptions) !associate_route_table.AssociateRouteTableOutput {
        return associate_route_table.execute(self, allocator, input, options);
    }

    /// Associates a security group with another VPC in the same Region. This
    /// enables you to use the same security group with network interfaces and
    /// instances in the specified VPC.
    ///
    /// * The VPC you want to associate the security group with must be in the same
    ///   Region.
    ///
    /// * You can associate the security group with another VPC if your account owns
    ///   the VPC or if the VPC was shared with you.
    ///
    /// * You must own the security group.
    ///
    /// * You cannot use this feature with default security groups.
    ///
    /// * You cannot use this feature with the default VPC.
    pub fn associateSecurityGroupVpc(self: *Self, allocator: std.mem.Allocator, input: associate_security_group_vpc.AssociateSecurityGroupVpcInput, options: CallOptions) !associate_security_group_vpc.AssociateSecurityGroupVpcOutput {
        return associate_security_group_vpc.execute(self, allocator, input, options);
    }

    /// Associates a CIDR block with your subnet. You can only associate a single
    /// IPv6 CIDR
    /// block with your subnet.
    pub fn associateSubnetCidrBlock(self: *Self, allocator: std.mem.Allocator, input: associate_subnet_cidr_block.AssociateSubnetCidrBlockInput, options: CallOptions) !associate_subnet_cidr_block.AssociateSubnetCidrBlockOutput {
        return associate_subnet_cidr_block.execute(self, allocator, input, options);
    }

    /// Associates the specified subnets and transit gateway attachments with the
    /// specified transit gateway multicast domain.
    ///
    /// The transit gateway attachment must be in the available state before you can
    /// add a resource. Use
    /// [DescribeTransitGatewayAttachments](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeTransitGatewayAttachments.html)
    /// to see the state of the attachment.
    pub fn associateTransitGatewayMulticastDomain(self: *Self, allocator: std.mem.Allocator, input: associate_transit_gateway_multicast_domain.AssociateTransitGatewayMulticastDomainInput, options: CallOptions) !associate_transit_gateway_multicast_domain.AssociateTransitGatewayMulticastDomainOutput {
        return associate_transit_gateway_multicast_domain.execute(self, allocator, input, options);
    }

    /// Associates the specified transit gateway attachment with a transit gateway
    /// policy table.
    pub fn associateTransitGatewayPolicyTable(self: *Self, allocator: std.mem.Allocator, input: associate_transit_gateway_policy_table.AssociateTransitGatewayPolicyTableInput, options: CallOptions) !associate_transit_gateway_policy_table.AssociateTransitGatewayPolicyTableOutput {
        return associate_transit_gateway_policy_table.execute(self, allocator, input, options);
    }

    /// Associates the specified attachment with the specified transit gateway route
    /// table. You can
    /// associate only one route table with an attachment.
    pub fn associateTransitGatewayRouteTable(self: *Self, allocator: std.mem.Allocator, input: associate_transit_gateway_route_table.AssociateTransitGatewayRouteTableInput, options: CallOptions) !associate_transit_gateway_route_table.AssociateTransitGatewayRouteTableOutput {
        return associate_transit_gateway_route_table.execute(self, allocator, input, options);
    }

    /// Associates a branch network interface with a trunk network interface.
    ///
    /// Before you create the association, use
    /// [CreateNetworkInterface](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateNetworkInterface.html) command and set the interface type
    /// to `trunk`. You must also create a network interface for
    /// each branch network interface that you want to associate with the trunk
    /// network interface.
    pub fn associateTrunkInterface(self: *Self, allocator: std.mem.Allocator, input: associate_trunk_interface.AssociateTrunkInterfaceInput, options: CallOptions) !associate_trunk_interface.AssociateTrunkInterfaceOutput {
        return associate_trunk_interface.execute(self, allocator, input, options);
    }

    /// Associates a CIDR block with your VPC. You can associate a secondary IPv4
    /// CIDR block,
    /// an Amazon-provided IPv6 CIDR block, or an IPv6 CIDR block from an IPv6
    /// address pool that
    /// you provisioned through bring your own IP addresses
    /// ([BYOIP](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-byoip.html)).
    ///
    /// You must specify one of the following in the request: an IPv4 CIDR block, an
    /// IPv6
    /// pool, or an Amazon-provided IPv6 CIDR block.
    ///
    /// For more information about associating CIDR blocks with your VPC and
    /// applicable
    /// restrictions, see [IP addressing for your VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-ip-addressing.html)
    /// in the *Amazon VPC User Guide*.
    pub fn associateVpcCidrBlock(self: *Self, allocator: std.mem.Allocator, input: associate_vpc_cidr_block.AssociateVpcCidrBlockInput, options: CallOptions) !associate_vpc_cidr_block.AssociateVpcCidrBlockOutput {
        return associate_vpc_cidr_block.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Links an EC2-Classic instance to a ClassicLink-enabled VPC through one or
    /// more of the VPC
    /// security groups. You cannot link an EC2-Classic instance to more than one
    /// VPC at a time. You
    /// can only link an instance that's in the `running` state. An instance is
    /// automatically unlinked from a VPC when it's stopped - you can link it to the
    /// VPC again when
    /// you restart it.
    ///
    /// After you've linked an instance, you cannot change the VPC security groups
    /// that are associated with it. To change the security groups, you must first
    /// unlink the instance, and then link it again.
    ///
    /// Linking your instance to a VPC is sometimes referred to as *attaching* your
    /// instance.
    pub fn attachClassicLinkVpc(self: *Self, allocator: std.mem.Allocator, input: attach_classic_link_vpc.AttachClassicLinkVpcInput, options: CallOptions) !attach_classic_link_vpc.AttachClassicLinkVpcOutput {
        return attach_classic_link_vpc.execute(self, allocator, input, options);
    }

    /// Attaches an internet gateway or a virtual private gateway to a VPC, enabling
    /// connectivity
    /// between the internet and the VPC. For more information, see [Internet
    /// gateways](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html) in the
    /// *Amazon VPC User Guide*.
    pub fn attachInternetGateway(self: *Self, allocator: std.mem.Allocator, input: attach_internet_gateway.AttachInternetGatewayInput, options: CallOptions) !attach_internet_gateway.AttachInternetGatewayOutput {
        return attach_internet_gateway.execute(self, allocator, input, options);
    }

    /// Attaches a network interface to an instance.
    pub fn attachNetworkInterface(self: *Self, allocator: std.mem.Allocator, input: attach_network_interface.AttachNetworkInterfaceInput, options: CallOptions) !attach_network_interface.AttachNetworkInterfaceOutput {
        return attach_network_interface.execute(self, allocator, input, options);
    }

    /// Attaches the specified Amazon Web Services Verified Access trust provider to
    /// the specified Amazon Web Services Verified Access instance.
    pub fn attachVerifiedAccessTrustProvider(self: *Self, allocator: std.mem.Allocator, input: attach_verified_access_trust_provider.AttachVerifiedAccessTrustProviderInput, options: CallOptions) !attach_verified_access_trust_provider.AttachVerifiedAccessTrustProviderOutput {
        return attach_verified_access_trust_provider.execute(self, allocator, input, options);
    }

    /// Attaches an Amazon EBS volume to a `running` or `stopped`
    /// instance, and exposes it to the instance with the specified device name.
    ///
    /// The maximum number of Amazon EBS volumes that you can attach to an instance
    /// depends on the
    /// instance type. If you exceed the volume attachment limit for an instance
    /// type, the attachment
    /// request fails with the `AttachmentLimitExceeded` error. For more
    /// information,
    /// see [Instance
    /// volume
    /// limits](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/volume_limits.html).
    ///
    /// After you attach an EBS volume, you must make it available for use. For more
    /// information,
    /// see [Make an
    /// EBS volume available for
    /// use](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-using-volumes.html).
    ///
    /// If a volume has an Amazon Web Services Marketplace product code:
    ///
    /// * The volume can be attached only to a stopped instance.
    ///
    /// * Amazon Web Services Marketplace product codes are copied from the volume
    ///   to the instance.
    ///
    /// * You must be subscribed to the product.
    ///
    /// * The instance type and operating system of the instance must support the
    ///   product. For
    /// example, you can't detach a volume from a Windows instance and attach it to
    /// a Linux
    /// instance.
    ///
    /// For more information, see [Attach an Amazon EBS volume to an
    /// instance](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-attaching-volume.html) in the
    /// *Amazon EBS User Guide*.
    pub fn attachVolume(self: *Self, allocator: std.mem.Allocator, input: attach_volume.AttachVolumeInput, options: CallOptions) !attach_volume.AttachVolumeOutput {
        return attach_volume.execute(self, allocator, input, options);
    }

    /// Attaches an available virtual private gateway to a VPC. You can attach one
    /// virtual private
    /// gateway to one VPC at a time.
    ///
    /// For more information, see [Amazon Web Services Site-to-Site
    /// VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html) in the
    /// *Amazon Web Services Site-to-Site VPN
    /// User Guide*.
    pub fn attachVpnGateway(self: *Self, allocator: std.mem.Allocator, input: attach_vpn_gateway.AttachVpnGatewayInput, options: CallOptions) !attach_vpn_gateway.AttachVpnGatewayOutput {
        return attach_vpn_gateway.execute(self, allocator, input, options);
    }

    /// Adds an ingress authorization rule to a Client VPN endpoint. Ingress
    /// authorization rules act as
    /// firewall rules that grant access to networks. You must configure ingress
    /// authorization rules to
    /// enable clients to access resources in Amazon Web Services or on-premises
    /// networks.
    pub fn authorizeClientVpnIngress(self: *Self, allocator: std.mem.Allocator, input: authorize_client_vpn_ingress.AuthorizeClientVpnIngressInput, options: CallOptions) !authorize_client_vpn_ingress.AuthorizeClientVpnIngressOutput {
        return authorize_client_vpn_ingress.execute(self, allocator, input, options);
    }

    /// Adds the specified outbound (egress) rules to a security group.
    ///
    /// An outbound rule permits instances to send traffic to the specified IPv4 or
    /// IPv6
    /// address ranges, the IP address ranges specified by a prefix list, or the
    /// instances
    /// that are associated with a source security group. For more information, see
    /// [Security group
    /// rules](https://docs.aws.amazon.com/vpc/latest/userguide/security-group-rules.html).
    ///
    /// You must specify exactly one of the following destinations: an IPv4 or IPv6
    /// address range,
    /// a prefix list, or a security group. You must specify a protocol for each
    /// rule (for example, TCP).
    /// If the protocol is TCP or UDP, you must also specify a port or port range.
    /// If the protocol is
    /// ICMP or ICMPv6, you must also specify the ICMP type and code.
    ///
    /// Rule changes are propagated to instances associated with the security group
    /// as quickly
    /// as possible. However, a small delay might occur.
    ///
    /// For examples of rules that you can add to security groups for specific
    /// access scenarios,
    /// see [Security group rules for different use
    /// cases](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-rules-reference.html) in the *Amazon EC2 User Guide*.
    ///
    /// For information about security group quotas, see [Amazon VPC
    /// quotas](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html) in the *Amazon VPC User Guide*.
    pub fn authorizeSecurityGroupEgress(self: *Self, allocator: std.mem.Allocator, input: authorize_security_group_egress.AuthorizeSecurityGroupEgressInput, options: CallOptions) !authorize_security_group_egress.AuthorizeSecurityGroupEgressOutput {
        return authorize_security_group_egress.execute(self, allocator, input, options);
    }

    /// Adds the specified inbound (ingress) rules to a security group.
    ///
    /// An inbound rule permits instances to receive traffic from the specified IPv4
    /// or IPv6
    /// address range, the IP address ranges that are specified by a prefix list, or
    /// the instances
    /// that are associated with a destination security group. For more information,
    /// see [Security group
    /// rules](https://docs.aws.amazon.com/vpc/latest/userguide/security-group-rules.html).
    ///
    /// You must specify exactly one of the following sources: an IPv4 or IPv6
    /// address range,
    /// a prefix list, or a security group. You must specify a protocol for each
    /// rule (for example, TCP).
    /// If the protocol is TCP or UDP, you must also specify a port or port range.
    /// If the protocol is
    /// ICMP or ICMPv6, you must also specify the ICMP/ICMPv6 type and code.
    ///
    /// Rule changes are propagated to instances associated with the security group
    /// as quickly
    /// as possible. However, a small delay might occur.
    ///
    /// For examples of rules that you can add to security groups for specific
    /// access scenarios,
    /// see [Security group rules for different use
    /// cases](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/security-group-rules-reference.html) in the *Amazon EC2 User Guide*.
    ///
    /// For more information about security group quotas, see [Amazon VPC
    /// quotas](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html) in the *Amazon VPC User Guide*.
    pub fn authorizeSecurityGroupIngress(self: *Self, allocator: std.mem.Allocator, input: authorize_security_group_ingress.AuthorizeSecurityGroupIngressInput, options: CallOptions) !authorize_security_group_ingress.AuthorizeSecurityGroupIngressOutput {
        return authorize_security_group_ingress.execute(self, allocator, input, options);
    }

    /// Bundles an Amazon instance store-backed Windows instance.
    ///
    /// During bundling, only the root device volume (C:\) is bundled. Data on other
    /// instance
    /// store volumes is not preserved.
    ///
    /// This action is not applicable for Linux/Unix instances or Windows instances
    /// that are
    /// backed by Amazon EBS.
    pub fn bundleInstance(self: *Self, allocator: std.mem.Allocator, input: bundle_instance.BundleInstanceInput, options: CallOptions) !bundle_instance.BundleInstanceOutput {
        return bundle_instance.execute(self, allocator, input, options);
    }

    /// Cancels a bundling operation for an instance store-backed Windows instance.
    pub fn cancelBundleTask(self: *Self, allocator: std.mem.Allocator, input: cancel_bundle_task.CancelBundleTaskInput, options: CallOptions) !cancel_bundle_task.CancelBundleTaskOutput {
        return cancel_bundle_task.execute(self, allocator, input, options);
    }

    /// Cancels the specified Capacity Reservation, releases the reserved capacity,
    /// and
    /// changes the Capacity Reservation's state to `cancelled`.
    ///
    /// You can cancel a Capacity Reservation that is in the following states:
    ///
    /// * `assessing`
    ///
    /// * `active` and there is no commitment duration or the commitment
    /// duration has elapsed. You can't cancel a future-dated Capacity Reservation
    /// during the commitment duration.
    ///
    /// You can't modify or cancel a Capacity Block. For more information, see
    /// [Capacity Blocks for
    /// ML](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-capacity-blocks.html).
    ///
    /// If a future-dated Capacity Reservation enters the `delayed` state, the
    /// commitment duration is waived, and you can cancel it as soon as it enters
    /// the
    /// `active` state.
    ///
    /// Instances running in the reserved capacity continue running until you stop
    /// them.
    /// Stopped instances that target the Capacity Reservation can no longer launch.
    /// Modify
    /// these instances to either target a different Capacity Reservation, launch
    /// On-Demand
    /// Instance capacity, or run in any open Capacity Reservation that has matching
    /// attributes
    /// and sufficient capacity.
    pub fn cancelCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: cancel_capacity_reservation.CancelCapacityReservationInput, options: CallOptions) !cancel_capacity_reservation.CancelCapacityReservationOutput {
        return cancel_capacity_reservation.execute(self, allocator, input, options);
    }

    /// Cancels one or more Capacity Reservation Fleets. When you cancel a Capacity
    /// Reservation Fleet, the following happens:
    ///
    /// * The Capacity Reservation Fleet's status changes to
    /// `cancelled`.
    ///
    /// * The individual Capacity Reservations in the Fleet are cancelled. Instances
    /// running in the Capacity Reservations at the time of cancelling the Fleet
    /// continue to run in shared capacity.
    ///
    /// * The Fleet stops creating new Capacity Reservations.
    pub fn cancelCapacityReservationFleets(self: *Self, allocator: std.mem.Allocator, input: cancel_capacity_reservation_fleets.CancelCapacityReservationFleetsInput, options: CallOptions) !cancel_capacity_reservation_fleets.CancelCapacityReservationFleetsOutput {
        return cancel_capacity_reservation_fleets.execute(self, allocator, input, options);
    }

    /// Cancels an active conversion task. The task can be the import of an instance
    /// or volume. The action removes all
    /// artifacts of the conversion, including a partially uploaded volume or
    /// instance. If the conversion is complete or is
    /// in the process of transferring the final disk image, the command fails and
    /// returns an exception.
    pub fn cancelConversionTask(self: *Self, allocator: std.mem.Allocator, input: cancel_conversion_task.CancelConversionTaskInput, options: CallOptions) !cancel_conversion_task.CancelConversionTaskOutput {
        return cancel_conversion_task.execute(self, allocator, input, options);
    }

    /// Cancels the generation of an account status report.
    ///
    /// You can only cancel a report while it has the `running` status. Reports
    /// with other statuses (`complete`, `cancelled`, or
    /// `error`) can't be canceled.
    ///
    /// For more information, see [Generating the account status report for
    /// declarative
    /// policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_declarative_status-report.html) in the
    /// *Amazon Web Services Organizations User Guide*.
    pub fn cancelDeclarativePoliciesReport(self: *Self, allocator: std.mem.Allocator, input: cancel_declarative_policies_report.CancelDeclarativePoliciesReportInput, options: CallOptions) !cancel_declarative_policies_report.CancelDeclarativePoliciesReportOutput {
        return cancel_declarative_policies_report.execute(self, allocator, input, options);
    }

    /// Cancels an active export task. The request removes all artifacts of the
    /// export, including any partially-created
    /// Amazon S3 objects. If the export task is complete or is in the process of
    /// transferring the final disk image, the
    /// command fails and returns an error.
    pub fn cancelExportTask(self: *Self, allocator: std.mem.Allocator, input: cancel_export_task.CancelExportTaskInput, options: CallOptions) !cancel_export_task.CancelExportTaskOutput {
        return cancel_export_task.execute(self, allocator, input, options);
    }

    /// Removes your Amazon Web Services account from the launch permissions for the
    /// specified AMI.
    /// For more information, see [Cancel having an AMI shared with
    /// your Amazon Web Services
    /// account](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cancel-sharing-an-AMI.html) in the *Amazon EC2 User Guide*.
    pub fn cancelImageLaunchPermission(self: *Self, allocator: std.mem.Allocator, input: cancel_image_launch_permission.CancelImageLaunchPermissionInput, options: CallOptions) !cancel_image_launch_permission.CancelImageLaunchPermissionOutput {
        return cancel_image_launch_permission.execute(self, allocator, input, options);
    }

    /// Cancels an in-process import virtual machine or import snapshot task.
    pub fn cancelImportTask(self: *Self, allocator: std.mem.Allocator, input: cancel_import_task.CancelImportTaskInput, options: CallOptions) !cancel_import_task.CancelImportTaskOutput {
        return cancel_import_task.execute(self, allocator, input, options);
    }

    /// Cancels the specified Reserved Instance listing in the Reserved Instance
    /// Marketplace.
    ///
    /// For more information, see [Sell in the Reserved Instance
    /// Marketplace](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-general.html) in the *Amazon EC2 User Guide*.
    pub fn cancelReservedInstancesListing(self: *Self, allocator: std.mem.Allocator, input: cancel_reserved_instances_listing.CancelReservedInstancesListingInput, options: CallOptions) !cancel_reserved_instances_listing.CancelReservedInstancesListingOutput {
        return cancel_reserved_instances_listing.execute(self, allocator, input, options);
    }

    /// Cancels the specified Spot Fleet requests.
    ///
    /// After you cancel a Spot Fleet request, the Spot Fleet launches no new
    /// instances.
    ///
    /// You must also specify whether a canceled Spot Fleet request should terminate
    /// its instances. If you
    /// choose to terminate the instances, the Spot Fleet request enters the
    /// `cancelled_terminating` state. Otherwise, the Spot Fleet request enters
    /// the `cancelled_running` state and the instances continue to run until they
    /// are interrupted or you terminate them manually.
    ///
    /// **Terminating an instance is permanent and irreversible.**
    ///
    /// After you terminate an instance, you can no longer connect to it, and it
    /// can't be recovered.
    /// All attached Amazon EBS volumes that are configured to be deleted on
    /// termination are also permanently
    /// deleted and can't be recovered. All data stored on instance store volumes is
    /// permanently lost.
    /// For more information, see [
    /// How instance termination
    /// works](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/how-ec2-instance-termination-works.html).
    ///
    /// Before you terminate an instance, ensure that you have backed up all data
    /// that you need to
    /// retain after the termination to persistent storage.
    ///
    /// **Restrictions**
    ///
    /// * You can delete up to 100 fleets in a single request. If you exceed the
    ///   specified
    /// number, no fleets are deleted.
    pub fn cancelSpotFleetRequests(self: *Self, allocator: std.mem.Allocator, input: cancel_spot_fleet_requests.CancelSpotFleetRequestsInput, options: CallOptions) !cancel_spot_fleet_requests.CancelSpotFleetRequestsOutput {
        return cancel_spot_fleet_requests.execute(self, allocator, input, options);
    }

    /// Cancels one or more Spot Instance requests.
    ///
    /// Canceling a Spot Instance request does not terminate running Spot Instances
    /// associated with the request.
    pub fn cancelSpotInstanceRequests(self: *Self, allocator: std.mem.Allocator, input: cancel_spot_instance_requests.CancelSpotInstanceRequestsInput, options: CallOptions) !cancel_spot_instance_requests.CancelSpotInstanceRequestsOutput {
        return cancel_spot_instance_requests.execute(self, allocator, input, options);
    }

    /// Determines whether a product code is associated with an instance. This
    /// action can only
    /// be used by the owner of the product code. It is useful when a product code
    /// owner must
    /// verify whether another user's instance is eligible for support.
    pub fn confirmProductInstance(self: *Self, allocator: std.mem.Allocator, input: confirm_product_instance.ConfirmProductInstanceInput, options: CallOptions) !confirm_product_instance.ConfirmProductInstanceOutput {
        return confirm_product_instance.execute(self, allocator, input, options);
    }

    /// Copies the specified Amazon FPGA Image (AFI) to the current Region.
    pub fn copyFpgaImage(self: *Self, allocator: std.mem.Allocator, input: copy_fpga_image.CopyFpgaImageInput, options: CallOptions) !copy_fpga_image.CopyFpgaImageOutput {
        return copy_fpga_image.execute(self, allocator, input, options);
    }

    /// Initiates an AMI copy operation. You must specify the source AMI ID and both
    /// the source
    /// and destination locations. The copy operation must be initiated in the
    /// destination
    /// Region.
    ///
    /// **CopyImage supports the following source to destination copies:**
    ///
    /// * Region to Region
    ///
    /// * Region to Outpost
    ///
    /// * Parent Region to Local Zone
    ///
    /// * Local Zone to parent Region
    ///
    /// * Between Local Zones with the same parent Region (only supported for
    ///   certain Local
    /// Zones)
    ///
    /// **CopyImage does not support the following source to destination copies:**
    ///
    /// * Local Zone to non-parent Regions
    ///
    /// * Between Local Zones with different parent Regions
    ///
    /// * Local Zone to Outpost
    ///
    /// * Outpost to Local Zone
    ///
    /// * Outpost to Region
    ///
    /// * Between Outposts
    ///
    /// * Within same Outpost
    ///
    /// * Cross-partition copies (use
    ///   [CreateStoreImageTask](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateStoreImageTask.html) instead)
    ///
    /// **Destination specification**
    ///
    /// * Region to Region: The destination Region is the Region in which you
    ///   initiate the copy
    /// operation.
    ///
    /// * Region to Outpost: Specify the destination using the
    /// `DestinationOutpostArn` parameter (the ARN of the Outpost)
    ///
    /// * Region to Local Zone, and Local Zone to Local Zone copies: Specify the
    ///   destination
    /// using the `DestinationAvailabilityZone` parameter (the name of the
    /// destination
    /// Local Zone) or `DestinationAvailabilityZoneId` parameter (the ID of the
    /// destination Local Zone).
    ///
    /// **Snapshot encryption**
    ///
    /// * Region to Outpost: Backing snapshots copied to an Outpost are encrypted by
    ///   default
    /// using the default encryption key for the Region or the key that you specify.
    /// Outposts do
    /// not support unencrypted snapshots.
    ///
    /// * Region to Local Zone, and Local Zone to Local Zone: Not all Local Zones
    ///   require
    /// encrypted snapshots. In Local Zones that require encrypted snapshots,
    /// backing snapshots
    /// are automatically encrypted during copy. In Local Zones where encryption is
    /// not required,
    /// snapshots retain their original encryption state (encrypted or unencrypted)
    /// by
    /// default.
    ///
    /// For more information, including the required permissions for copying an AMI,
    /// see [Copy an Amazon EC2
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/CopyingAMIs.html)
    /// in the
    /// *Amazon EC2 User Guide*.
    pub fn copyImage(self: *Self, allocator: std.mem.Allocator, input: copy_image.CopyImageInput, options: CallOptions) !copy_image.CopyImageOutput {
        return copy_image.execute(self, allocator, input, options);
    }

    /// Creates an exact copy of an Amazon EBS snapshot.
    ///
    /// The location of the source snapshot determines whether you can copy it or
    /// not,
    /// and the allowed destinations for the snapshot copy.
    ///
    /// * If the source snapshot is in a Region, you can copy it within that Region,
    /// to another Region, to an Outpost associated with that Region, or to a Local
    /// Zone in that Region.
    ///
    /// * If the source snapshot is in a Local Zone, you can copy it within that
    ///   Local Zone,
    /// to another Local Zone in the same zone group, or to the parent Region of the
    /// Local
    /// Zone.
    ///
    /// * If the source snapshot is on an Outpost, you can't copy it.
    ///
    /// When copying snapshots to a Region, the encryption outcome for the snapshot
    /// copy depends on the
    /// Amazon EBS encryption by default setting for the destination Region, the
    /// encryption status of the source
    /// snapshot, and the encryption parameters you specify in the request. For more
    /// information, see [
    /// Encryption and snapshot
    /// copying](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-copy-snapshot.html#creating-encrypted-snapshots).
    ///
    /// Snapshots copied to an Outpost must be encrypted. Unencrypted snapshots are
    /// not supported
    /// on Outposts. For more information, [
    /// Amazon EBS local snapshots on
    /// Outposts](https://docs.aws.amazon.com/ebs/latest/userguide/snapshots-outposts.html#considerations).
    ///
    /// Snapshots copies have an arbitrary source volume ID. Do not use this volume
    /// ID for
    /// any purpose.
    ///
    /// For more information, see [Copy an Amazon EBS
    /// snapshot](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-copy-snapshot.html) in the
    /// *Amazon EBS User Guide*.
    pub fn copySnapshot(self: *Self, allocator: std.mem.Allocator, input: copy_snapshot.CopySnapshotInput, options: CallOptions) !copy_snapshot.CopySnapshotOutput {
        return copy_snapshot.execute(self, allocator, input, options);
    }

    /// Creates a crash-consistent, point-in-time copy of an existing Amazon EBS
    /// volume within the same
    /// Availability Zone. The volume copy can be attached to an Amazon EC2 instance
    /// once it reaches the
    /// `available` state. For more information, see [Copy an Amazon EBS
    /// volume](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-copying-volume.html).
    pub fn copyVolumes(self: *Self, allocator: std.mem.Allocator, input: copy_volumes.CopyVolumesInput, options: CallOptions) !copy_volumes.CopyVolumesOutput {
        return copy_volumes.execute(self, allocator, input, options);
    }

    /// Creates a new data export configuration for EC2 Capacity Manager. This
    /// allows you to automatically export capacity usage data to an S3 bucket on a
    /// scheduled basis.
    /// The exported data includes metrics for On-Demand, Spot, and Capacity
    /// Reservations usage across your organization.
    pub fn createCapacityManagerDataExport(self: *Self, allocator: std.mem.Allocator, input: create_capacity_manager_data_export.CreateCapacityManagerDataExportInput, options: CallOptions) !create_capacity_manager_data_export.CreateCapacityManagerDataExportOutput {
        return create_capacity_manager_data_export.execute(self, allocator, input, options);
    }

    /// Creates a new Capacity Reservation with the specified attributes. Capacity
    /// Reservations enable you to reserve capacity for your Amazon EC2 instances in
    /// a specific
    /// Availability Zone for any duration.
    ///
    /// You can create a Capacity Reservation at any time, and you can choose when
    /// it starts.
    /// You can create a Capacity Reservation for immediate use or you can request a
    /// Capacity
    /// Reservation for a future date.
    ///
    /// For more information, see [ Reserve compute
    /// capacity with On-Demand Capacity
    /// Reservations](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-capacity-reservations.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// Your request to create a Capacity Reservation could fail if:
    ///
    /// * Amazon EC2 does not have sufficient capacity. In this case, try again
    /// at a later time, try in a different Availability Zone, or request a smaller
    /// Capacity Reservation. If your workload is flexible across instance types and
    /// sizes, try with different instance attributes.
    ///
    /// * The requested quantity exceeds your On-Demand Instance quota. In this
    ///   case,
    /// increase your On-Demand Instance quota for the requested instance type and
    /// try
    /// again. For more information, see [
    /// Amazon EC2 Service
    /// Quotas](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-resource-limits.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn createCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: create_capacity_reservation.CreateCapacityReservationInput, options: CallOptions) !create_capacity_reservation.CreateCapacityReservationOutput {
        return create_capacity_reservation.execute(self, allocator, input, options);
    }

    /// Create a new Capacity Reservation by splitting the capacity of the source
    /// Capacity
    /// Reservation. The new Capacity Reservation will have the same attributes as
    /// the source
    /// Capacity Reservation except for tags. The source Capacity Reservation must
    /// be
    /// `active` and owned by your Amazon Web Services account.
    pub fn createCapacityReservationBySplitting(self: *Self, allocator: std.mem.Allocator, input: create_capacity_reservation_by_splitting.CreateCapacityReservationBySplittingInput, options: CallOptions) !create_capacity_reservation_by_splitting.CreateCapacityReservationBySplittingOutput {
        return create_capacity_reservation_by_splitting.execute(self, allocator, input, options);
    }

    /// Creates a Capacity Reservation Fleet. For more information, see [Create a
    /// Capacity Reservation
    /// Fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-cr-fleets.html#create-crfleet) in the
    /// *Amazon EC2 User Guide*.
    pub fn createCapacityReservationFleet(self: *Self, allocator: std.mem.Allocator, input: create_capacity_reservation_fleet.CreateCapacityReservationFleetInput, options: CallOptions) !create_capacity_reservation_fleet.CreateCapacityReservationFleetOutput {
        return create_capacity_reservation_fleet.execute(self, allocator, input, options);
    }

    /// Creates a carrier gateway. For more information about carrier gateways, see
    /// [Carrier
    /// gateways](https://docs.aws.amazon.com/wavelength/latest/developerguide/how-wavelengths-work.html#wavelength-carrier-gateway) in the *Amazon Web Services Wavelength Developer Guide*.
    pub fn createCarrierGateway(self: *Self, allocator: std.mem.Allocator, input: create_carrier_gateway.CreateCarrierGatewayInput, options: CallOptions) !create_carrier_gateway.CreateCarrierGatewayOutput {
        return create_carrier_gateway.execute(self, allocator, input, options);
    }

    /// Creates a Client VPN endpoint. A Client VPN endpoint is the resource you
    /// create and configure to
    /// enable and manage client VPN sessions. It is the destination endpoint at
    /// which all client VPN sessions
    /// are terminated.
    pub fn createClientVpnEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_client_vpn_endpoint.CreateClientVpnEndpointInput, options: CallOptions) !create_client_vpn_endpoint.CreateClientVpnEndpointOutput {
        return create_client_vpn_endpoint.execute(self, allocator, input, options);
    }

    /// Adds a route to a network to a Client VPN endpoint. Each Client VPN endpoint
    /// has a route table that describes the
    /// available destination network routes. Each route in the route table
    /// specifies the path for traﬃc to speciﬁc resources or networks.
    pub fn createClientVpnRoute(self: *Self, allocator: std.mem.Allocator, input: create_client_vpn_route.CreateClientVpnRouteInput, options: CallOptions) !create_client_vpn_route.CreateClientVpnRouteOutput {
        return create_client_vpn_route.execute(self, allocator, input, options);
    }

    /// Creates a range of customer-owned IP addresses.
    pub fn createCoipCidr(self: *Self, allocator: std.mem.Allocator, input: create_coip_cidr.CreateCoipCidrInput, options: CallOptions) !create_coip_cidr.CreateCoipCidrOutput {
        return create_coip_cidr.execute(self, allocator, input, options);
    }

    /// Creates a pool of customer-owned IP (CoIP) addresses.
    pub fn createCoipPool(self: *Self, allocator: std.mem.Allocator, input: create_coip_pool.CreateCoipPoolInput, options: CallOptions) !create_coip_pool.CreateCoipPoolOutput {
        return create_coip_pool.execute(self, allocator, input, options);
    }

    /// Provides information to Amazon Web Services about your customer gateway
    /// device. The
    /// customer gateway device is the appliance at your end of the VPN connection.
    /// You
    /// must provide the IP address of the customer gateway device’s external
    /// interface. The IP address must be static and can be behind a device
    /// performing network
    /// address translation (NAT).
    ///
    /// For devices that use Border Gateway Protocol (BGP), you can also provide the
    /// device's
    /// BGP Autonomous System Number (ASN). You can use an existing ASN assigned to
    /// your network.
    /// If you don't have an ASN already, you can use a private ASN. For more
    /// information, see
    /// [Customer gateway
    /// options for your Site-to-Site VPN
    /// connection](https://docs.aws.amazon.com/vpn/latest/s2svpn/cgw-options.html)
    /// in the *Amazon Web Services Site-to-Site VPN User Guide*.
    ///
    /// To create more than one customer gateway with the same VPN type, IP address,
    /// and
    /// BGP ASN, specify a unique device name for each customer gateway. An
    /// identical request
    /// returns information about the existing customer gateway; it doesn't create a
    /// new customer
    /// gateway.
    pub fn createCustomerGateway(self: *Self, allocator: std.mem.Allocator, input: create_customer_gateway.CreateCustomerGatewayInput, options: CallOptions) !create_customer_gateway.CreateCustomerGatewayOutput {
        return create_customer_gateway.execute(self, allocator, input, options);
    }

    /// Creates a default subnet with a size `/20` IPv4 CIDR block in the
    /// specified Availability Zone in your default VPC. You can have only one
    /// default subnet
    /// per Availability Zone. For more information, see [Create a default
    /// subnet](https://docs.aws.amazon.com/vpc/latest/userguide/work-with-default-vpc.html#create-default-subnet) in the *Amazon VPC User Guide*.
    pub fn createDefaultSubnet(self: *Self, allocator: std.mem.Allocator, input: create_default_subnet.CreateDefaultSubnetInput, options: CallOptions) !create_default_subnet.CreateDefaultSubnetOutput {
        return create_default_subnet.execute(self, allocator, input, options);
    }

    /// Creates a default VPC with a size `/16` IPv4 CIDR block and a default subnet
    /// in each Availability Zone. For more information about the components of a
    /// default VPC,
    /// see [Default
    /// VPCs](https://docs.aws.amazon.com/vpc/latest/userguide/default-vpc.html)
    /// in the *Amazon VPC User Guide*. You cannot specify the components of the
    /// default VPC yourself.
    ///
    /// If you deleted your previous default VPC, you can create a default VPC. You
    /// cannot have
    /// more than one default VPC per Region.
    pub fn createDefaultVpc(self: *Self, allocator: std.mem.Allocator, input: create_default_vpc.CreateDefaultVpcInput, options: CallOptions) !create_default_vpc.CreateDefaultVpcOutput {
        return create_default_vpc.execute(self, allocator, input, options);
    }

    /// Delegates ownership of the Amazon EBS root volume for an Apple silicon
    /// Mac instance to an administrative user.
    pub fn createDelegateMacVolumeOwnershipTask(self: *Self, allocator: std.mem.Allocator, input: create_delegate_mac_volume_ownership_task.CreateDelegateMacVolumeOwnershipTaskInput, options: CallOptions) !create_delegate_mac_volume_ownership_task.CreateDelegateMacVolumeOwnershipTaskOutput {
        return create_delegate_mac_volume_ownership_task.execute(self, allocator, input, options);
    }

    /// Creates a custom set of DHCP options. After you create a DHCP option set,
    /// you associate
    /// it with a VPC. After you associate a DHCP option set with a VPC, all
    /// existing and newly
    /// launched instances in the VPC use this set of DHCP options.
    ///
    /// The following are the individual DHCP options you can specify. For more
    /// information, see
    /// [DHCP option
    /// sets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_DHCP_Options.html)
    /// in the *Amazon VPC User Guide*.
    ///
    /// * `domain-name` - If you're using AmazonProvidedDNS in `us-east-1`,
    /// specify `ec2.internal`. If you're using AmazonProvidedDNS in any other
    /// Region,
    /// specify `region.compute.internal`. Otherwise, specify a custom domain name.
    /// This value is used to complete unqualified DNS hostnames.
    ///
    /// Some Linux operating systems accept multiple domain names separated by
    /// spaces.
    /// However, Windows and other Linux operating systems treat the value as a
    /// single
    /// domain, which results in unexpected behavior. If your DHCP option set is
    /// associated with a VPC that has instances running operating systems that
    /// treat
    /// the value as a single domain, specify only one domain name.
    ///
    /// * `domain-name-servers` - The IP addresses of up to four DNS servers,
    /// or AmazonProvidedDNS. To specify multiple domain name servers in a single
    /// parameter,
    /// separate the IP addresses using commas. To have your instances receive
    /// custom DNS
    /// hostnames as specified in `domain-name`, you must specify a custom DNS
    /// server.
    ///
    /// * `ntp-servers` - The IP addresses of up to eight Network Time Protocol
    ///   (NTP)
    /// servers (four IPv4 addresses and four IPv6 addresses).
    ///
    /// * `netbios-name-servers` - The IP addresses of up to four NetBIOS name
    /// servers.
    ///
    /// * `netbios-node-type` - The NetBIOS node type (1, 2, 4, or 8). We recommend
    ///   that
    /// you specify 2. Broadcast and multicast are not supported. For more
    /// information about
    /// NetBIOS node types, see [RFC 2132](https://www.ietf.org/rfc/rfc2132.txt).
    ///
    /// * `ipv6-address-preferred-lease-time` - A value (in seconds, minutes, hours,
    ///   or years) for how frequently a running instance with an IPv6 assigned to
    ///   it goes through DHCPv6 lease renewal.
    /// Acceptable values are between 140 and 2147483647 seconds (approximately 68
    /// years). If no value is entered, the default lease time is 140 seconds. If
    /// you use long-term addressing for EC2 instances, you can increase the lease
    /// time and avoid frequent
    /// lease renewal requests. Lease renewal typically occurs when half of the
    /// lease time has elapsed.
    pub fn createDhcpOptions(self: *Self, allocator: std.mem.Allocator, input: create_dhcp_options.CreateDhcpOptionsInput, options: CallOptions) !create_dhcp_options.CreateDhcpOptionsOutput {
        return create_dhcp_options.execute(self, allocator, input, options);
    }

    /// [IPv6 only] Creates an egress-only internet gateway for your VPC. An
    /// egress-only
    /// internet gateway is used to enable outbound communication over IPv6 from
    /// instances in
    /// your VPC to the internet, and prevents hosts outside of your VPC from
    /// initiating an IPv6
    /// connection with your instance.
    pub fn createEgressOnlyInternetGateway(self: *Self, allocator: std.mem.Allocator, input: create_egress_only_internet_gateway.CreateEgressOnlyInternetGatewayInput, options: CallOptions) !create_egress_only_internet_gateway.CreateEgressOnlyInternetGatewayOutput {
        return create_egress_only_internet_gateway.execute(self, allocator, input, options);
    }

    /// Creates an EC2 Fleet that contains the configuration information for
    /// On-Demand Instances and Spot Instances.
    /// Instances are launched immediately if there is available capacity.
    ///
    /// A single EC2 Fleet can include multiple launch specifications that vary by
    /// instance type,
    /// AMI, Availability Zone, or subnet.
    ///
    /// For more information, see [EC2
    /// Fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet.html)
    /// in the *Amazon EC2 User Guide*.
    pub fn createFleet(self: *Self, allocator: std.mem.Allocator, input: create_fleet.CreateFleetInput, options: CallOptions) !create_fleet.CreateFleetOutput {
        return create_fleet.execute(self, allocator, input, options);
    }

    /// Creates one or more flow logs to capture information about IP traffic for a
    /// specific network interface,
    /// subnet, or VPC.
    ///
    /// Flow log data for a monitored network interface is recorded as flow log
    /// records, which are log events
    /// consisting of fields that describe the traffic flow. For more information,
    /// see
    /// [Flow log
    /// records](https://docs.aws.amazon.com/vpc/latest/userguide/flow-log-records.html)
    /// in the *Amazon VPC User Guide*.
    ///
    /// When publishing to CloudWatch Logs, flow log records are published to a log
    /// group, and each network
    /// interface has a unique log stream in the log group. When publishing to
    /// Amazon S3, flow log records for all
    /// of the monitored network interfaces are published to a single log file
    /// object that is stored in the specified
    /// bucket.
    ///
    /// For more information, see [VPC Flow
    /// Logs](https://docs.aws.amazon.com/vpc/latest/userguide/flow-logs.html)
    /// in the *Amazon VPC User Guide*.
    pub fn createFlowLogs(self: *Self, allocator: std.mem.Allocator, input: create_flow_logs.CreateFlowLogsInput, options: CallOptions) !create_flow_logs.CreateFlowLogsOutput {
        return create_flow_logs.execute(self, allocator, input, options);
    }

    /// Creates an Amazon FPGA Image (AFI) from the specified design checkpoint
    /// (DCP).
    ///
    /// The create operation is asynchronous. To verify that the AFI was
    /// successfully
    /// created and is ready for use, check the output logs.
    ///
    /// An AFI contains the FPGA bitstream that is ready to download to an FPGA.
    /// You can securely deploy an AFI on multiple FPGA-accelerated instances.
    /// For more information, see the [Amazon Web Services FPGA Hardware Development
    /// Kit](https://github.com/aws/aws-fpga/).
    pub fn createFpgaImage(self: *Self, allocator: std.mem.Allocator, input: create_fpga_image.CreateFpgaImageInput, options: CallOptions) !create_fpga_image.CreateFpgaImageOutput {
        return create_fpga_image.execute(self, allocator, input, options);
    }

    /// Creates an Amazon EBS-backed AMI from an Amazon EBS-backed instance that is
    /// either running or
    /// stopped.
    ///
    /// If you customized your instance with instance store volumes or Amazon EBS
    /// volumes in addition
    /// to the root device volume, the new AMI contains block device mapping
    /// information for those
    /// volumes. When you launch an instance from this new AMI, the instance
    /// automatically launches
    /// with those additional volumes.
    ///
    /// The location of the source instance determines where you can create the
    /// snapshots of the
    /// AMI:
    ///
    /// * If the source instance is in a Region, you must create the snapshots in
    ///   the same
    /// Region as the instance.
    ///
    /// * If the source instance is in a Local Zone, you can create the snapshots in
    ///   the same
    /// Local Zone or in its parent Region.
    ///
    /// For more information, see [Create an Amazon EBS-backed
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating-an-ami-ebs.html) in
    /// the *Amazon Elastic Compute Cloud User Guide*.
    pub fn createImage(self: *Self, allocator: std.mem.Allocator, input: create_image.CreateImageInput, options: CallOptions) !create_image.CreateImageOutput {
        return create_image.execute(self, allocator, input, options);
    }

    /// Creates a report that shows how your image is used across other Amazon Web
    /// Services accounts. The report
    /// provides visibility into which accounts are using the specified image, and
    /// how many resources
    /// (EC2 instances or launch templates) are referencing it.
    ///
    /// For more information, see [View your AMI
    /// usage](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/your-ec2-ami-usage.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn createImageUsageReport(self: *Self, allocator: std.mem.Allocator, input: create_image_usage_report.CreateImageUsageReportInput, options: CallOptions) !create_image_usage_report.CreateImageUsageReportOutput {
        return create_image_usage_report.execute(self, allocator, input, options);
    }

    /// Creates an EC2 Instance Connect Endpoint.
    ///
    /// An EC2 Instance Connect Endpoint allows you to connect to an instance,
    /// without
    /// requiring the instance to have a public IPv4 or public IPv6 address. For
    /// more
    /// information, see [Connect to your instances using EC2 Instance Connect
    /// Endpoint](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Connect-using-EC2-Instance-Connect-Endpoint.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn createInstanceConnectEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_instance_connect_endpoint.CreateInstanceConnectEndpointInput, options: CallOptions) !create_instance_connect_endpoint.CreateInstanceConnectEndpointOutput {
        return create_instance_connect_endpoint.execute(self, allocator, input, options);
    }

    /// Creates an event window in which scheduled events for the associated Amazon
    /// EC2 instances can
    /// run.
    ///
    /// You can define either a set of time ranges or a cron expression when
    /// creating the event
    /// window, but not both. All event window times are in UTC.
    ///
    /// You can create up to 200 event windows per Amazon Web Services Region.
    ///
    /// When you create the event window, targets (instance IDs, Dedicated Host IDs,
    /// or tags)
    /// are not yet associated with it. To ensure that the event window can be used,
    /// you must
    /// associate one or more targets with it by using the
    /// AssociateInstanceEventWindow API.
    ///
    /// Event windows are applicable only for scheduled events that stop, reboot, or
    /// terminate instances.
    ///
    /// Event windows are *not* applicable for:
    ///
    /// * Expedited scheduled events and network maintenance events.
    ///
    /// * Unscheduled maintenance such as AutoRecovery and unplanned reboots.
    ///
    /// For more information, see [Define event windows for scheduled
    /// events](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/event-windows.html) in the *Amazon EC2 User Guide*.
    pub fn createInstanceEventWindow(self: *Self, allocator: std.mem.Allocator, input: create_instance_event_window.CreateInstanceEventWindowInput, options: CallOptions) !create_instance_event_window.CreateInstanceEventWindowOutput {
        return create_instance_event_window.execute(self, allocator, input, options);
    }

    /// Exports a running or stopped instance to an Amazon S3 bucket.
    ///
    /// For information about the prerequisites for your Amazon S3 bucket, supported
    /// operating systems,
    /// image formats, and known limitations for the types of instances you can
    /// export, see [Exporting an instance as a VM Using VM
    /// Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport.html) in the *VM Import/Export User Guide*.
    pub fn createInstanceExportTask(self: *Self, allocator: std.mem.Allocator, input: create_instance_export_task.CreateInstanceExportTaskInput, options: CallOptions) !create_instance_export_task.CreateInstanceExportTaskOutput {
        return create_instance_export_task.execute(self, allocator, input, options);
    }

    /// Creates an internet gateway for use with a VPC. After creating the internet
    /// gateway,
    /// you attach it to a VPC using AttachInternetGateway.
    ///
    /// For more information, see [Internet
    /// gateways](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Internet_Gateway.html) in the
    /// *Amazon VPC User Guide*.
    pub fn createInternetGateway(self: *Self, allocator: std.mem.Allocator, input: create_internet_gateway.CreateInternetGatewayInput, options: CallOptions) !create_internet_gateway.CreateInternetGatewayOutput {
        return create_internet_gateway.execute(self, allocator, input, options);
    }

    /// Creates an interruptible Capacity Reservation by specifying the number of
    /// unused instances you want to allocate from your source reservation. This
    /// helps you make unused capacity available for other workloads within your
    /// account while maintaining control to reclaim it.
    pub fn createInterruptibleCapacityReservationAllocation(self: *Self, allocator: std.mem.Allocator, input: create_interruptible_capacity_reservation_allocation.CreateInterruptibleCapacityReservationAllocationInput, options: CallOptions) !create_interruptible_capacity_reservation_allocation.CreateInterruptibleCapacityReservationAllocationOutput {
        return create_interruptible_capacity_reservation_allocation.execute(self, allocator, input, options);
    }

    /// Create an IPAM. Amazon VPC IP Address Manager (IPAM) is a VPC feature that
    /// you can use
    /// to automate your IP address management workflows including assigning,
    /// tracking,
    /// troubleshooting, and auditing IP addresses across Amazon Web Services
    /// Regions and accounts
    /// throughout your Amazon Web Services Organization.
    ///
    /// For more information, see [Create an
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/create-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    pub fn createIpam(self: *Self, allocator: std.mem.Allocator, input: create_ipam.CreateIpamInput, options: CallOptions) !create_ipam.CreateIpamOutput {
        return create_ipam.execute(self, allocator, input, options);
    }

    /// Create a verification token.
    ///
    /// A verification token is an Amazon Web Services-generated random value that
    /// you can use to prove ownership of an external resource. For example, you can
    /// use a verification token to validate that you control a public IP address
    /// range when you bring an IP address range to Amazon Web Services (BYOIP).
    pub fn createIpamExternalResourceVerificationToken(self: *Self, allocator: std.mem.Allocator, input: create_ipam_external_resource_verification_token.CreateIpamExternalResourceVerificationTokenInput, options: CallOptions) !create_ipam_external_resource_verification_token.CreateIpamExternalResourceVerificationTokenOutput {
        return create_ipam_external_resource_verification_token.execute(self, allocator, input, options);
    }

    /// Creates an IPAM policy.
    ///
    /// An IPAM policy is a set of rules that define how public IPv4 addresses from
    /// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
    /// Amazon Web Services service to IPAM pools that the service will use to get
    /// IP addresses. A single policy can have multiple rules and be applied to
    /// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
    /// then the services fallback to Amazon-provided IP addresses. A policy can be
    /// applied to an individual Amazon Web Services account or an entity within
    /// Amazon Web Services Organizations.
    ///
    /// For more information, see [Define public IPv4 allocation strategy with IPAM
    /// policies](https://docs.aws.amazon.com/vpc/latest/ipam/define-public-ipv4-allocation-strategy-with-ipam-policies.html) in the *Amazon VPC IPAM User Guide*.
    pub fn createIpamPolicy(self: *Self, allocator: std.mem.Allocator, input: create_ipam_policy.CreateIpamPolicyInput, options: CallOptions) !create_ipam_policy.CreateIpamPolicyOutput {
        return create_ipam_policy.execute(self, allocator, input, options);
    }

    /// Create an IP address pool for Amazon VPC IP Address Manager (IPAM). In IPAM,
    /// a pool is a collection of contiguous IP addresses CIDRs. Pools enable you to
    /// organize your IP addresses according to your routing and security needs. For
    /// example, if you have separate routing and security needs for development and
    /// production applications, you can create a pool for each.
    ///
    /// For more information, see [Create a top-level
    /// pool](https://docs.aws.amazon.com/vpc/latest/ipam/create-top-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    pub fn createIpamPool(self: *Self, allocator: std.mem.Allocator, input: create_ipam_pool.CreateIpamPoolInput, options: CallOptions) !create_ipam_pool.CreateIpamPoolOutput {
        return create_ipam_pool.execute(self, allocator, input, options);
    }

    /// Creates an IPAM prefix list resolver.
    ///
    /// An IPAM prefix list resolver is a component that manages the synchronization
    /// between IPAM's CIDR selection rules and customer-managed prefix lists. It
    /// automates connectivity configurations by selecting CIDRs from IPAM's
    /// database based on your business logic and synchronizing them with prefix
    /// lists used in resources such as VPC route tables and security groups.
    ///
    /// For more information about IPAM prefix list resolver, see [Automate prefix
    /// list updates with
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/automate-prefix-list-updates.html) in the *Amazon VPC IPAM User Guide*.
    pub fn createIpamPrefixListResolver(self: *Self, allocator: std.mem.Allocator, input: create_ipam_prefix_list_resolver.CreateIpamPrefixListResolverInput, options: CallOptions) !create_ipam_prefix_list_resolver.CreateIpamPrefixListResolverOutput {
        return create_ipam_prefix_list_resolver.execute(self, allocator, input, options);
    }

    /// Creates an IPAM prefix list resolver target.
    ///
    /// An IPAM prefix list resolver target is an association between a specific
    /// customer-managed prefix list and an IPAM prefix list resolver. The target
    /// enables the resolver to synchronize CIDRs selected by its rules into the
    /// specified prefix list, which can then be referenced in Amazon Web Services
    /// resources.
    ///
    /// For more information about IPAM prefix list resolver, see [Automate prefix
    /// list updates with
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/automate-prefix-list-updates.html) in the *Amazon VPC IPAM User Guide*.
    pub fn createIpamPrefixListResolverTarget(self: *Self, allocator: std.mem.Allocator, input: create_ipam_prefix_list_resolver_target.CreateIpamPrefixListResolverTargetInput, options: CallOptions) !create_ipam_prefix_list_resolver_target.CreateIpamPrefixListResolverTargetOutput {
        return create_ipam_prefix_list_resolver_target.execute(self, allocator, input, options);
    }

    /// Creates an IPAM resource discovery. A resource discovery is an IPAM
    /// component that enables IPAM to manage and monitor resources that belong to
    /// the owning account.
    pub fn createIpamResourceDiscovery(self: *Self, allocator: std.mem.Allocator, input: create_ipam_resource_discovery.CreateIpamResourceDiscoveryInput, options: CallOptions) !create_ipam_resource_discovery.CreateIpamResourceDiscoveryOutput {
        return create_ipam_resource_discovery.execute(self, allocator, input, options);
    }

    /// Create an IPAM scope. In IPAM, a scope is the highest-level container within
    /// IPAM. An IPAM contains two default scopes. Each scope represents the IP
    /// space for a single network. The private scope is intended for all private IP
    /// address space. The public scope is intended for all public IP address space.
    /// Scopes enable you to reuse IP addresses across multiple unconnected networks
    /// without causing IP address overlap or conflict.
    ///
    /// For more information, see [Add a
    /// scope](https://docs.aws.amazon.com/vpc/latest/ipam/add-scope-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    pub fn createIpamScope(self: *Self, allocator: std.mem.Allocator, input: create_ipam_scope.CreateIpamScopeInput, options: CallOptions) !create_ipam_scope.CreateIpamScopeOutput {
        return create_ipam_scope.execute(self, allocator, input, options);
    }

    /// Creates an ED25519 or 2048-bit RSA key pair with the specified name and in
    /// the
    /// specified format. Amazon EC2 stores the public key and displays the private
    /// key for you to save to a file. The private key is returned as an unencrypted
    /// PEM encoded
    /// PKCS#1 private key or an unencrypted PPK formatted private key for use with
    /// PuTTY. If a
    /// key with the specified name already exists, Amazon EC2 returns an error.
    ///
    /// The key pair returned to you is available only in the Amazon Web Services
    /// Region in which you create it.
    /// If you prefer, you can create your own key pair using a third-party tool and
    /// upload it
    /// to any Region using ImportKeyPair.
    ///
    /// You can have up to 5,000 key pairs per Amazon Web Services Region.
    ///
    /// For more information, see [Amazon EC2 key
    /// pairs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn createKeyPair(self: *Self, allocator: std.mem.Allocator, input: create_key_pair.CreateKeyPairInput, options: CallOptions) !create_key_pair.CreateKeyPairOutput {
        return create_key_pair.execute(self, allocator, input, options);
    }

    /// Creates a launch template.
    ///
    /// A launch template contains the parameters to launch an instance. When you
    /// launch an
    /// instance using RunInstances, you can specify a launch template instead
    /// of providing the launch parameters in the request. For more information, see
    /// [Store
    /// instance launch parameters in Amazon EC2 launch
    /// templates](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// To clone an existing launch template as the basis for a new launch template,
    /// use the
    /// Amazon EC2 console. The API, SDKs, and CLI do not support cloning a
    /// template. For more
    /// information, see [Create a launch template from an existing launch
    /// template](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-launch-template.html#create-launch-template-from-existing-launch-template) in the
    /// *Amazon EC2 User Guide*.
    pub fn createLaunchTemplate(self: *Self, allocator: std.mem.Allocator, input: create_launch_template.CreateLaunchTemplateInput, options: CallOptions) !create_launch_template.CreateLaunchTemplateOutput {
        return create_launch_template.execute(self, allocator, input, options);
    }

    /// Creates a new version of a launch template. You must specify an existing
    /// launch
    /// template, either by name or ID. You can determine whether the new version
    /// inherits
    /// parameters from a source version, and add or overwrite parameters as needed.
    ///
    /// Launch template versions are numbered in the order in which they are
    /// created. You
    /// can't specify, change, or replace the numbering of launch template versions.
    ///
    /// Launch templates are immutable; after you create a launch template, you
    /// can't modify
    /// it. Instead, you can create a new version of the launch template that
    /// includes the
    /// changes that you require.
    ///
    /// For more information, see [Modify a launch
    /// template (manage launch template
    /// versions)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/manage-launch-template-versions.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn createLaunchTemplateVersion(self: *Self, allocator: std.mem.Allocator, input: create_launch_template_version.CreateLaunchTemplateVersionInput, options: CallOptions) !create_launch_template_version.CreateLaunchTemplateVersionOutput {
        return create_launch_template_version.execute(self, allocator, input, options);
    }

    /// Creates a static route for the specified local gateway route table. You must
    /// specify one of the
    /// following targets:
    ///
    /// * `LocalGatewayVirtualInterfaceGroupId`
    ///
    /// * `NetworkInterfaceId`
    pub fn createLocalGatewayRoute(self: *Self, allocator: std.mem.Allocator, input: create_local_gateway_route.CreateLocalGatewayRouteInput, options: CallOptions) !create_local_gateway_route.CreateLocalGatewayRouteOutput {
        return create_local_gateway_route.execute(self, allocator, input, options);
    }

    /// Creates a local gateway route table.
    pub fn createLocalGatewayRouteTable(self: *Self, allocator: std.mem.Allocator, input: create_local_gateway_route_table.CreateLocalGatewayRouteTableInput, options: CallOptions) !create_local_gateway_route_table.CreateLocalGatewayRouteTableOutput {
        return create_local_gateway_route_table.execute(self, allocator, input, options);
    }

    /// Creates a local gateway route table virtual interface group association.
    pub fn createLocalGatewayRouteTableVirtualInterfaceGroupAssociation(self: *Self, allocator: std.mem.Allocator, input: create_local_gateway_route_table_virtual_interface_group_association.CreateLocalGatewayRouteTableVirtualInterfaceGroupAssociationInput, options: CallOptions) !create_local_gateway_route_table_virtual_interface_group_association.CreateLocalGatewayRouteTableVirtualInterfaceGroupAssociationOutput {
        return create_local_gateway_route_table_virtual_interface_group_association.execute(self, allocator, input, options);
    }

    /// Associates the specified VPC with the specified local gateway route table.
    pub fn createLocalGatewayRouteTableVpcAssociation(self: *Self, allocator: std.mem.Allocator, input: create_local_gateway_route_table_vpc_association.CreateLocalGatewayRouteTableVpcAssociationInput, options: CallOptions) !create_local_gateway_route_table_vpc_association.CreateLocalGatewayRouteTableVpcAssociationOutput {
        return create_local_gateway_route_table_vpc_association.execute(self, allocator, input, options);
    }

    /// Create a virtual interface for a local gateway.
    pub fn createLocalGatewayVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: create_local_gateway_virtual_interface.CreateLocalGatewayVirtualInterfaceInput, options: CallOptions) !create_local_gateway_virtual_interface.CreateLocalGatewayVirtualInterfaceOutput {
        return create_local_gateway_virtual_interface.execute(self, allocator, input, options);
    }

    /// Create a local gateway virtual interface group.
    pub fn createLocalGatewayVirtualInterfaceGroup(self: *Self, allocator: std.mem.Allocator, input: create_local_gateway_virtual_interface_group.CreateLocalGatewayVirtualInterfaceGroupInput, options: CallOptions) !create_local_gateway_virtual_interface_group.CreateLocalGatewayVirtualInterfaceGroupOutput {
        return create_local_gateway_virtual_interface_group.execute(self, allocator, input, options);
    }

    /// Creates a System Integrity Protection (SIP) modification task to configure
    /// the SIP settings
    /// for an x86 Mac instance or Apple silicon Mac instance. For more information,
    /// see
    /// [
    /// Configure SIP for Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mac-sip-settings.html#mac-sip-configure) in the *Amazon EC2 User Guide*.
    ///
    /// When you configure the SIP settings for your instance, you can either enable
    /// or disable all SIP settings, or you can specify a custom SIP configuration
    /// that
    /// selectively enables or disables specific SIP settings.
    ///
    /// If you implement a custom configuration, [
    /// connect to the instance and verify the
    /// settings](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mac-sip-settings.html#mac-sip-check-settings) to ensure that your
    /// requirements are properly implemented and functioning as intended.
    ///
    /// SIP configurations might change with macOS updates. We recommend that you
    /// review custom SIP settings after any macOS version upgrade to ensure
    /// continued compatibility and proper functionality of your security
    /// configurations.
    ///
    /// To enable or disable all SIP settings, use the
    /// **MacSystemIntegrityProtectionStatus**
    /// parameter only. For example, to enable all SIP settings, specify the
    /// following:
    ///
    /// * `MacSystemIntegrityProtectionStatus=enabled`
    ///
    /// To specify a custom configuration that selectively enables or disables
    /// specific SIP
    /// settings, use the **MacSystemIntegrityProtectionStatus**
    /// parameter to enable or disable all SIP settings, and then use the
    /// **MacSystemIntegrityProtectionConfiguration** parameter
    /// to specify exceptions. In this case, the exceptions you specify for
    /// **MacSystemIntegrityProtectionConfiguration** override the value
    /// you specify for **MacSystemIntegrityProtectionStatus**.
    /// For example, to enable all SIP settings, except `NvramProtections`,
    /// specify the following:
    ///
    /// * `MacSystemIntegrityProtectionStatus=enabled`
    ///
    /// * `MacSystemIntegrityProtectionConfigurationRequest
    ///   "NvramProtections=disabled"`
    pub fn createMacSystemIntegrityProtectionModificationTask(self: *Self, allocator: std.mem.Allocator, input: create_mac_system_integrity_protection_modification_task.CreateMacSystemIntegrityProtectionModificationTaskInput, options: CallOptions) !create_mac_system_integrity_protection_modification_task.CreateMacSystemIntegrityProtectionModificationTaskOutput {
        return create_mac_system_integrity_protection_modification_task.execute(self, allocator, input, options);
    }

    /// Creates a managed prefix list. You can specify entries for the prefix list.
    /// Each entry consists of a CIDR block and an optional description.
    pub fn createManagedPrefixList(self: *Self, allocator: std.mem.Allocator, input: create_managed_prefix_list.CreateManagedPrefixListInput, options: CallOptions) !create_managed_prefix_list.CreateManagedPrefixListOutput {
        return create_managed_prefix_list.execute(self, allocator, input, options);
    }

    /// Creates a NAT gateway in the specified subnet. This action creates a network
    /// interface
    /// in the specified subnet with a private IP address from the IP address range
    /// of the
    /// subnet. You can create either a public NAT gateway or a private NAT gateway.
    ///
    /// With a public NAT gateway, internet-bound traffic from a private subnet can
    /// be routed
    /// to the NAT gateway, so that instances in a private subnet can connect to the
    /// internet.
    ///
    /// With a private NAT gateway, private communication is routed across VPCs and
    /// on-premises
    /// networks through a transit gateway or virtual private gateway. Common use
    /// cases include
    /// running large workloads behind a small pool of allowlisted IPv4 addresses,
    /// preserving
    /// private IPv4 addresses, and communicating between overlapping networks.
    ///
    /// For more information, see [NAT
    /// gateways](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-nat-gateway.html) in the *Amazon VPC User Guide*.
    ///
    /// When you create a public NAT gateway and assign it an EIP or secondary EIPs,
    /// the network border group of the EIPs must match the network border group of
    /// the Availability Zone (AZ)
    /// that the public NAT gateway is in. If it's not the same, the NAT gateway
    /// will fail to launch.
    /// You can see the network border group for the subnet's AZ by viewing the
    /// details of the subnet.
    /// Similarly, you can view the network border group of an EIP by viewing the
    /// details of the EIP address.
    /// For more information about network border groups and EIPs, see [Allocate an
    /// Elastic IP
    /// address](https://docs.aws.amazon.com/vpc/latest/userguide/WorkWithEIPs.html)
    /// in the *Amazon VPC User Guide*.
    pub fn createNatGateway(self: *Self, allocator: std.mem.Allocator, input: create_nat_gateway.CreateNatGatewayInput, options: CallOptions) !create_nat_gateway.CreateNatGatewayOutput {
        return create_nat_gateway.execute(self, allocator, input, options);
    }

    /// Creates a network ACL in a VPC. Network ACLs provide an optional layer of
    /// security (in addition to security groups) for the instances in your VPC.
    ///
    /// For more information, see [Network
    /// ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) in the
    /// *Amazon VPC User Guide*.
    pub fn createNetworkAcl(self: *Self, allocator: std.mem.Allocator, input: create_network_acl.CreateNetworkAclInput, options: CallOptions) !create_network_acl.CreateNetworkAclOutput {
        return create_network_acl.execute(self, allocator, input, options);
    }

    /// Creates an entry (a rule) in a network ACL with the specified rule number.
    /// Each network ACL has a set of numbered ingress rules
    /// and a separate set of numbered egress rules. When determining whether a
    /// packet should be allowed in or out of a subnet associated
    /// with the ACL, we process the entries in the ACL according to the rule
    /// numbers, in ascending order. Each network ACL has a set of
    /// ingress rules and a separate set of egress rules.
    ///
    /// We recommend that you leave room between the rule numbers (for example, 100,
    /// 110, 120, ...), and not number them one right after the
    /// other (for example, 101, 102, 103, ...). This makes it easier to add a rule
    /// between existing ones without having to renumber the rules.
    ///
    /// After you add an entry, you can't modify it; you must either replace it, or
    /// create an entry and delete the old one.
    ///
    /// For more information about network ACLs, see [Network
    /// ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html)
    /// in the *Amazon VPC User Guide*.
    pub fn createNetworkAclEntry(self: *Self, allocator: std.mem.Allocator, input: create_network_acl_entry.CreateNetworkAclEntryInput, options: CallOptions) !create_network_acl_entry.CreateNetworkAclEntryOutput {
        return create_network_acl_entry.execute(self, allocator, input, options);
    }

    /// Creates a Network Access Scope.
    ///
    /// Amazon Web Services Network Access Analyzer enables cloud networking and
    /// cloud operations teams
    /// to verify that their networks on Amazon Web Services conform to their
    /// network security and governance
    /// objectives. For more information, see the [Amazon Web Services Network
    /// Access Analyzer
    /// Guide](https://docs.aws.amazon.com/vpc/latest/network-access-analyzer/).
    pub fn createNetworkInsightsAccessScope(self: *Self, allocator: std.mem.Allocator, input: create_network_insights_access_scope.CreateNetworkInsightsAccessScopeInput, options: CallOptions) !create_network_insights_access_scope.CreateNetworkInsightsAccessScopeOutput {
        return create_network_insights_access_scope.execute(self, allocator, input, options);
    }

    /// Creates a path to analyze for reachability.
    ///
    /// Reachability Analyzer enables you to analyze and debug network reachability
    /// between
    /// two resources in your virtual private cloud (VPC). For more information, see
    /// the
    /// [Reachability Analyzer
    /// Guide](https://docs.aws.amazon.com/vpc/latest/reachability/).
    pub fn createNetworkInsightsPath(self: *Self, allocator: std.mem.Allocator, input: create_network_insights_path.CreateNetworkInsightsPathInput, options: CallOptions) !create_network_insights_path.CreateNetworkInsightsPathOutput {
        return create_network_insights_path.execute(self, allocator, input, options);
    }

    /// Creates a network interface in the specified subnet.
    ///
    /// The number of IP addresses you can assign to a network interface varies by
    /// instance
    /// type.
    ///
    /// For more information about network interfaces, see [Elastic network
    /// interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-eni.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn createNetworkInterface(self: *Self, allocator: std.mem.Allocator, input: create_network_interface.CreateNetworkInterfaceInput, options: CallOptions) !create_network_interface.CreateNetworkInterfaceOutput {
        return create_network_interface.execute(self, allocator, input, options);
    }

    /// Grants an Amazon Web Services-authorized account permission to attach the
    /// specified
    /// network interface to an instance in their account.
    ///
    /// You can grant permission to a single Amazon Web Services account only, and
    /// only one
    /// account at a time.
    pub fn createNetworkInterfacePermission(self: *Self, allocator: std.mem.Allocator, input: create_network_interface_permission.CreateNetworkInterfacePermissionInput, options: CallOptions) !create_network_interface_permission.CreateNetworkInterfacePermissionOutput {
        return create_network_interface_permission.execute(self, allocator, input, options);
    }

    /// Creates a placement group in which to launch instances. The strategy of the
    /// placement
    /// group determines how the instances are organized within the group.
    ///
    /// A `cluster` placement group is a logical grouping of instances within a
    /// single Availability Zone that benefit from low network latency, high network
    /// throughput.
    /// A `spread` placement group places instances on distinct hardware. A
    /// `partition` placement group places groups of instances in different
    /// partitions, where instances in one partition do not share the same hardware
    /// with
    /// instances in another partition.
    ///
    /// For more information, see [Placement
    /// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn createPlacementGroup(self: *Self, allocator: std.mem.Allocator, input: create_placement_group.CreatePlacementGroupInput, options: CallOptions) !create_placement_group.CreatePlacementGroupOutput {
        return create_placement_group.execute(self, allocator, input, options);
    }

    /// Creates a public IPv4 address pool. A public IPv4 pool is an EC2 IP address
    /// pool required for the public IPv4 CIDRs that you own and bring to Amazon Web
    /// Services to manage with IPAM. IPv6 addresses you bring to Amazon Web
    /// Services, however, use IPAM pools only. To monitor the status of pool
    /// creation, use
    /// [DescribePublicIpv4Pools](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribePublicIpv4Pools.html).
    pub fn createPublicIpv4Pool(self: *Self, allocator: std.mem.Allocator, input: create_public_ipv_4_pool.CreatePublicIpv4PoolInput, options: CallOptions) !create_public_ipv_4_pool.CreatePublicIpv4PoolOutput {
        return create_public_ipv_4_pool.execute(self, allocator, input, options);
    }

    /// Replaces the EBS-backed root volume for a `running` instance with a new
    /// volume that is restored to the original root volume's launch state, that is
    /// restored to a
    /// specific snapshot taken from the original root volume, or that is restored
    /// from an AMI
    /// that has the same key characteristics as that of the instance.
    ///
    /// For more information, see [Replace a root
    /// volume](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/replace-root.html) in the *Amazon EC2 User Guide*.
    pub fn createReplaceRootVolumeTask(self: *Self, allocator: std.mem.Allocator, input: create_replace_root_volume_task.CreateReplaceRootVolumeTaskInput, options: CallOptions) !create_replace_root_volume_task.CreateReplaceRootVolumeTaskOutput {
        return create_replace_root_volume_task.execute(self, allocator, input, options);
    }

    /// Creates a listing for Amazon EC2 Standard Reserved Instances to be sold in
    /// the Reserved
    /// Instance Marketplace. You can submit one Standard Reserved Instance listing
    /// at a time. To get
    /// a list of your Standard Reserved Instances, you can use the
    /// DescribeReservedInstances operation.
    ///
    /// Only Standard Reserved Instances can be sold in the Reserved Instance
    /// Marketplace.
    /// Convertible Reserved Instances cannot be sold.
    ///
    /// The Reserved Instance Marketplace matches sellers who want to resell
    /// Standard Reserved
    /// Instance capacity that they no longer need with buyers who want to purchase
    /// additional
    /// capacity. Reserved Instances bought and sold through the Reserved Instance
    /// Marketplace work
    /// like any other Reserved Instances.
    ///
    /// To sell your Standard Reserved Instances, you must first register as a
    /// seller in the
    /// Reserved Instance Marketplace. After completing the registration process,
    /// you can create a
    /// Reserved Instance Marketplace listing of some or all of your Standard
    /// Reserved Instances, and
    /// specify the upfront price to receive for them. Your Standard Reserved
    /// Instance listings then
    /// become available for purchase. To view the details of your Standard Reserved
    /// Instance listing,
    /// you can use the DescribeReservedInstancesListings operation.
    ///
    /// For more information, see [Sell in the Reserved Instance
    /// Marketplace](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-general.html) in the *Amazon EC2 User Guide*.
    pub fn createReservedInstancesListing(self: *Self, allocator: std.mem.Allocator, input: create_reserved_instances_listing.CreateReservedInstancesListingInput, options: CallOptions) !create_reserved_instances_listing.CreateReservedInstancesListingOutput {
        return create_reserved_instances_listing.execute(self, allocator, input, options);
    }

    /// Starts a task that restores an AMI from an Amazon S3 object that was
    /// previously created by
    /// using
    /// [CreateStoreImageTask](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateStoreImageTask.html).
    ///
    /// To use this API, you must have the required permissions. For more
    /// information, see [Permissions for storing and restoring AMIs using
    /// S3](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-ami-store-restore.html#ami-s3-permissions) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// For more information, see [Store and restore an AMI using
    /// S3](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-store-restore.html) in the *Amazon EC2 User Guide*.
    pub fn createRestoreImageTask(self: *Self, allocator: std.mem.Allocator, input: create_restore_image_task.CreateRestoreImageTaskInput, options: CallOptions) !create_restore_image_task.CreateRestoreImageTaskOutput {
        return create_restore_image_task.execute(self, allocator, input, options);
    }

    /// Creates a route in a route table within a VPC.
    ///
    /// You must specify either a destination CIDR block or a prefix list ID. You
    /// must also specify
    /// exactly one of the resources from the parameter list.
    ///
    /// When determining how to route traffic, we use the route with the most
    /// specific match.
    /// For example, traffic is destined for the IPv4 address `192.0.2.3`, and the
    /// route table includes the following two IPv4 routes:
    ///
    /// * `192.0.2.0/24` (goes to some target A)
    ///
    /// * `192.0.2.0/28` (goes to some target B)
    ///
    /// Both routes apply to the traffic destined for `192.0.2.3`. However, the
    /// second route
    /// in the list covers a smaller number of IP addresses and is therefore more
    /// specific,
    /// so we use that route to determine where to target the traffic.
    ///
    /// For more information about route tables, see [Route
    /// tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html) in the
    /// *Amazon VPC User Guide*.
    pub fn createRoute(self: *Self, allocator: std.mem.Allocator, input: create_route.CreateRouteInput, options: CallOptions) !create_route.CreateRouteOutput {
        return create_route.execute(self, allocator, input, options);
    }

    /// Creates a new route server to manage dynamic routing in a VPC.
    ///
    /// Amazon VPC Route Server simplifies routing for traffic between workloads
    /// that are deployed within a VPC and its internet gateways. With this feature,
    /// VPC Route Server dynamically updates VPC and internet gateway route tables
    /// with your preferred IPv4 or IPv6 routes to achieve routing fault tolerance
    /// for those workloads. This enables you to automatically reroute traffic
    /// within a VPC, which increases the manageability of VPC routing and
    /// interoperability with third-party workloads.
    ///
    /// Route server supports the follow route table types:
    ///
    /// * VPC route tables not associated with subnets
    ///
    /// * Subnet route tables
    ///
    /// * Internet gateway route tables
    ///
    /// Route server does not support route tables associated with virtual private
    /// gateways. To propagate routes into a transit gateway route table, use
    /// [Transit Gateway
    /// Connect](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html).
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn createRouteServer(self: *Self, allocator: std.mem.Allocator, input: create_route_server.CreateRouteServerInput, options: CallOptions) !create_route_server.CreateRouteServerOutput {
        return create_route_server.execute(self, allocator, input, options);
    }

    /// Creates a new endpoint for a route server in a specified subnet.
    ///
    /// A route server endpoint is an Amazon Web Services-managed component inside a
    /// subnet that facilitates [BGP (Border Gateway
    /// Protocol)](https://en.wikipedia.org/wiki/Border_Gateway_Protocol)
    /// connections between your route server and your BGP peers.
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn createRouteServerEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_route_server_endpoint.CreateRouteServerEndpointInput, options: CallOptions) !create_route_server_endpoint.CreateRouteServerEndpointOutput {
        return create_route_server_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a new BGP peer for a specified route server endpoint.
    ///
    /// A route server peer is a session between a route server endpoint and the
    /// device deployed in Amazon Web Services (such as a firewall appliance or
    /// other network security function running on an EC2 instance). The device must
    /// meet these requirements:
    ///
    /// * Have an elastic network interface in the VPC
    ///
    /// * Support BGP (Border Gateway Protocol)
    ///
    /// * Can initiate BGP sessions
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn createRouteServerPeer(self: *Self, allocator: std.mem.Allocator, input: create_route_server_peer.CreateRouteServerPeerInput, options: CallOptions) !create_route_server_peer.CreateRouteServerPeerOutput {
        return create_route_server_peer.execute(self, allocator, input, options);
    }

    /// Creates a route table for the specified VPC. After you create a route table,
    /// you can add routes and associate the table with a subnet.
    ///
    /// For more information, see [Route
    /// tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html) in the
    /// *Amazon VPC User Guide*.
    pub fn createRouteTable(self: *Self, allocator: std.mem.Allocator, input: create_route_table.CreateRouteTableInput, options: CallOptions) !create_route_table.CreateRouteTableOutput {
        return create_route_table.execute(self, allocator, input, options);
    }

    /// Creates a security group.
    ///
    /// A security group acts as a virtual firewall for your instance to control
    /// inbound and outbound traffic.
    /// For more information, see
    /// [Amazon EC2 security
    /// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html) in
    /// the *Amazon EC2 User Guide* and
    /// [Security groups for your
    /// VPC](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_SecurityGroups.html) in the
    /// *Amazon VPC User Guide*.
    ///
    /// When you create a security group, you specify a friendly name of your
    /// choice.
    /// You can't have two security groups for the same VPC with the same name.
    ///
    /// You have a default security group for use in your VPC. If you don't specify
    /// a security group
    /// when you launch an instance, the instance is launched into the appropriate
    /// default security group.
    /// A default security group includes a default rule that grants instances
    /// unrestricted network access
    /// to each other.
    ///
    /// You can add or remove rules from your security groups using
    /// AuthorizeSecurityGroupIngress,
    /// AuthorizeSecurityGroupEgress,
    /// RevokeSecurityGroupIngress, and
    /// RevokeSecurityGroupEgress.
    ///
    /// For more information about VPC security group limits, see [Amazon VPC
    /// Limits](https://docs.aws.amazon.com/vpc/latest/userguide/amazon-vpc-limits.html).
    pub fn createSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: create_security_group.CreateSecurityGroupInput, options: CallOptions) !create_security_group.CreateSecurityGroupOutput {
        return create_security_group.execute(self, allocator, input, options);
    }

    /// Creates a snapshot of an EBS volume and stores it in Amazon S3. You can use
    /// snapshots for
    /// backups, to make copies of EBS volumes, and to save data before shutting
    /// down an
    /// instance.
    ///
    /// The location of the source EBS volume determines where you can create the
    /// snapshot.
    ///
    /// * If the source volume is in a Region, you must create the snapshot in the
    ///   same
    /// Region as the volume.
    ///
    /// * If the source volume is in a Local Zone, you can create the snapshot in
    ///   the same Local
    /// Zone or in its parent Amazon Web Services Region.
    ///
    /// * If the source volume is on an Outpost, you can create the snapshot on the
    ///   same
    /// Outpost or in its parent Amazon Web Services Region.
    ///
    /// When a snapshot is created, any Amazon Web Services Marketplace product
    /// codes that are associated with the
    /// source volume are propagated to the snapshot.
    ///
    /// You can take a snapshot of an attached volume that is in use. However,
    /// snapshots only
    /// capture data that has been written to your Amazon EBS volume at the time the
    /// snapshot command is
    /// issued; this might exclude any data that has been cached by any applications
    /// or the operating
    /// system. If you can pause any file systems on the volume long enough to take
    /// a snapshot, your
    /// snapshot should be complete. However, if you cannot pause all file writes to
    /// the volume, you
    /// should unmount the volume from within the instance, issue the snapshot
    /// command, and then
    /// remount the volume to ensure a consistent and complete snapshot. You may
    /// remount and use your
    /// volume while the snapshot status is `pending`.
    ///
    /// When you create a snapshot for an EBS volume that serves as a root device,
    /// we recommend
    /// that you stop the instance before taking the snapshot.
    ///
    /// Snapshots that are taken from encrypted volumes are automatically encrypted.
    /// Volumes that
    /// are created from encrypted snapshots are also automatically encrypted. Your
    /// encrypted volumes
    /// and any associated snapshots always remain protected. For more information,
    /// see [Amazon EBS
    /// encryption](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption.html)
    /// in the *Amazon EBS User Guide*.
    pub fn createSnapshot(self: *Self, allocator: std.mem.Allocator, input: create_snapshot.CreateSnapshotInput, options: CallOptions) !create_snapshot.CreateSnapshotOutput {
        return create_snapshot.execute(self, allocator, input, options);
    }

    /// Creates crash-consistent snapshots of multiple EBS volumes attached to an
    /// Amazon EC2 instance.
    /// Volumes are chosen by specifying an instance. Each volume attached to the
    /// specified instance
    /// will produce one snapshot that is crash-consistent across the instance. You
    /// can include all of
    /// the volumes currently attached to the instance, or you can exclude the root
    /// volume or specific
    /// data (non-root) volumes from the multi-volume snapshot set.
    ///
    /// The location of the source instance determines where you can create the
    /// snapshots.
    ///
    /// * If the source instance is in a Region, you must create the snapshots in
    ///   the same
    /// Region as the instance.
    ///
    /// * If the source instance is in a Local Zone, you can create the snapshots in
    ///   the same
    /// Local Zone or in its parent Amazon Web Services Region.
    ///
    /// * If the source instance is on an Outpost, you can create the snapshots on
    ///   the same
    /// Outpost or in its parent Amazon Web Services Region.
    pub fn createSnapshots(self: *Self, allocator: std.mem.Allocator, input: create_snapshots.CreateSnapshotsInput, options: CallOptions) !create_snapshots.CreateSnapshotsOutput {
        return create_snapshots.execute(self, allocator, input, options);
    }

    /// Creates a data feed for Spot Instances, enabling you to view Spot Instance
    /// usage logs.
    /// You can create one data feed per Amazon Web Services account. For more
    /// information, see
    /// [Spot Instance data
    /// feed](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-data-feeds.html)
    /// in the *Amazon EC2 User Guide*.
    pub fn createSpotDatafeedSubscription(self: *Self, allocator: std.mem.Allocator, input: create_spot_datafeed_subscription.CreateSpotDatafeedSubscriptionInput, options: CallOptions) !create_spot_datafeed_subscription.CreateSpotDatafeedSubscriptionOutput {
        return create_spot_datafeed_subscription.execute(self, allocator, input, options);
    }

    /// Stores an AMI as a single object in an Amazon S3 bucket.
    ///
    /// To use this API, you must have the required permissions. For more
    /// information, see [Permissions for storing and restoring AMIs using
    /// S3](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-ami-store-restore.html#ami-s3-permissions) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// For more information, see [Store and restore an AMI using
    /// S3](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-store-restore.html) in the *Amazon EC2 User Guide*.
    pub fn createStoreImageTask(self: *Self, allocator: std.mem.Allocator, input: create_store_image_task.CreateStoreImageTaskInput, options: CallOptions) !create_store_image_task.CreateStoreImageTaskOutput {
        return create_store_image_task.execute(self, allocator, input, options);
    }

    /// Creates a subnet in the specified VPC. For an IPv4 only subnet, specify an
    /// IPv4 CIDR block.
    /// If the VPC has an IPv6 CIDR block, you can create an IPv6 only subnet or a
    /// dual stack subnet instead.
    /// For an IPv6 only subnet, specify an IPv6 CIDR block. For a dual stack
    /// subnet, specify both
    /// an IPv4 CIDR block and an IPv6 CIDR block.
    ///
    /// A subnet CIDR block must not overlap the CIDR block of an existing subnet in
    /// the VPC.
    /// After you create a subnet, you can't change its CIDR block.
    ///
    /// The allowed size for an IPv4 subnet is between a /28 netmask (16 IP
    /// addresses) and
    /// a /16 netmask (65,536 IP addresses). Amazon Web Services reserves both the
    /// first four and
    /// the last IPv4 address in each subnet's CIDR block. They're not available for
    /// your use.
    ///
    /// If you've associated an IPv6 CIDR block with your VPC, you can associate an
    /// IPv6 CIDR
    /// block with a subnet when you create it.
    ///
    /// If you add more than one subnet to a VPC, they're set up in a star topology
    /// with a
    /// logical router in the middle.
    ///
    /// When you stop an instance in a subnet, it retains its private IPv4 address.
    /// It's
    /// therefore possible to have a subnet with no running instances (they're all
    /// stopped), but
    /// no remaining IP addresses available.
    ///
    /// For more information, see
    /// [Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html) in the *Amazon VPC User Guide*.
    pub fn createSubnet(self: *Self, allocator: std.mem.Allocator, input: create_subnet.CreateSubnetInput, options: CallOptions) !create_subnet.CreateSubnetOutput {
        return create_subnet.execute(self, allocator, input, options);
    }

    /// Creates a subnet CIDR reservation. For more information, see [Subnet CIDR
    /// reservations](https://docs.aws.amazon.com/vpc/latest/userguide/subnet-cidr-reservation.html)
    /// in the *Amazon VPC User Guide* and [Manage prefixes
    /// for your network
    /// interfaces](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-prefixes.html) in the *Amazon EC2 User Guide*.
    pub fn createSubnetCidrReservation(self: *Self, allocator: std.mem.Allocator, input: create_subnet_cidr_reservation.CreateSubnetCidrReservationInput, options: CallOptions) !create_subnet_cidr_reservation.CreateSubnetCidrReservationOutput {
        return create_subnet_cidr_reservation.execute(self, allocator, input, options);
    }

    /// Adds or overwrites only the specified tags for the specified Amazon EC2
    /// resource or
    /// resources. When you specify an existing tag key, the value is overwritten
    /// with
    /// the new value. Each resource can have a maximum of 50 tags. Each tag
    /// consists of a key and
    /// optional value. Tag keys must be unique per resource.
    ///
    /// For more information about tags, see [Tag your Amazon EC2
    /// resources](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*. For more information about
    /// creating IAM policies that control users' access to resources based on tags,
    /// see [Supported
    /// resource-level permissions for Amazon EC2 API
    /// actions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-supported-iam-actions-resources.html) in the *Amazon
    /// Elastic Compute Cloud User Guide*.
    pub fn createTags(self: *Self, allocator: std.mem.Allocator, input: create_tags.CreateTagsInput, options: CallOptions) !create_tags.CreateTagsOutput {
        return create_tags.execute(self, allocator, input, options);
    }

    /// Creates a Traffic Mirror filter.
    ///
    /// A Traffic Mirror filter is a set of rules that defines the traffic to
    /// mirror.
    ///
    /// By default, no traffic is mirrored. To mirror traffic, use
    /// [CreateTrafficMirrorFilterRule](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTrafficMirrorFilterRule.htm)
    /// to add Traffic Mirror rules to the filter. The rules you add define what
    /// traffic gets mirrored.
    /// You can also use
    /// [ModifyTrafficMirrorFilterNetworkServices](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyTrafficMirrorFilterNetworkServices.html) to mirror supported network services.
    pub fn createTrafficMirrorFilter(self: *Self, allocator: std.mem.Allocator, input: create_traffic_mirror_filter.CreateTrafficMirrorFilterInput, options: CallOptions) !create_traffic_mirror_filter.CreateTrafficMirrorFilterOutput {
        return create_traffic_mirror_filter.execute(self, allocator, input, options);
    }

    /// Creates a Traffic Mirror filter rule.
    ///
    /// A Traffic Mirror rule defines the Traffic Mirror source traffic to mirror.
    ///
    /// You need the Traffic Mirror filter ID when you create the rule.
    pub fn createTrafficMirrorFilterRule(self: *Self, allocator: std.mem.Allocator, input: create_traffic_mirror_filter_rule.CreateTrafficMirrorFilterRuleInput, options: CallOptions) !create_traffic_mirror_filter_rule.CreateTrafficMirrorFilterRuleOutput {
        return create_traffic_mirror_filter_rule.execute(self, allocator, input, options);
    }

    /// Creates a Traffic Mirror session.
    ///
    /// A Traffic Mirror session actively copies packets from a Traffic Mirror
    /// source to a Traffic Mirror target. Create a filter, and then assign it
    /// to the session to define a subset of the traffic to mirror, for example all
    /// TCP
    /// traffic.
    ///
    /// The Traffic Mirror source and the Traffic Mirror target (monitoring
    /// appliances) can be in the same VPC, or in a different VPC connected via VPC
    /// peering or a transit gateway.
    ///
    /// By default, no traffic is mirrored. Use
    /// [CreateTrafficMirrorFilter](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTrafficMirrorFilter.html) to
    /// create filter rules that specify the traffic to mirror.
    pub fn createTrafficMirrorSession(self: *Self, allocator: std.mem.Allocator, input: create_traffic_mirror_session.CreateTrafficMirrorSessionInput, options: CallOptions) !create_traffic_mirror_session.CreateTrafficMirrorSessionOutput {
        return create_traffic_mirror_session.execute(self, allocator, input, options);
    }

    /// Creates a target for your Traffic Mirror session.
    ///
    /// A Traffic Mirror target is the destination for mirrored traffic. The Traffic
    /// Mirror source and
    /// the Traffic Mirror target (monitoring appliances) can be in the same VPC, or
    /// in
    /// different VPCs connected via VPC peering or a transit gateway.
    ///
    /// A Traffic Mirror target can be a network interface, a Network Load Balancer,
    /// or a Gateway Load Balancer endpoint.
    ///
    /// To use the target in a Traffic Mirror session, use
    /// [CreateTrafficMirrorSession](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_CreateTrafficMirrorSession.htm).
    pub fn createTrafficMirrorTarget(self: *Self, allocator: std.mem.Allocator, input: create_traffic_mirror_target.CreateTrafficMirrorTargetInput, options: CallOptions) !create_traffic_mirror_target.CreateTrafficMirrorTargetOutput {
        return create_traffic_mirror_target.execute(self, allocator, input, options);
    }

    /// Creates a transit gateway.
    ///
    /// You can use a transit gateway to interconnect your virtual private clouds
    /// (VPC) and on-premises networks.
    /// After the transit gateway enters the `available` state, you can attach your
    /// VPCs and VPN
    /// connections to the transit gateway.
    ///
    /// To attach your VPCs, use CreateTransitGatewayVpcAttachment.
    ///
    /// To attach a VPN connection, use CreateCustomerGateway to create a customer
    /// gateway and specify the ID of the customer gateway and the ID of the transit
    /// gateway in a call to
    /// CreateVpnConnection.
    ///
    /// When you create a transit gateway, we create a default transit gateway route
    /// table and use it as the default association route table
    /// and the default propagation route table. You can use
    /// CreateTransitGatewayRouteTable to create
    /// additional transit gateway route tables. If you disable automatic route
    /// propagation, we do not create a default transit gateway route table.
    /// You can use EnableTransitGatewayRouteTablePropagation to propagate routes
    /// from a resource
    /// attachment to a transit gateway route table. If you disable automatic
    /// associations, you can use AssociateTransitGatewayRouteTable to associate a
    /// resource attachment with a transit gateway route table.
    pub fn createTransitGateway(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway.CreateTransitGatewayInput, options: CallOptions) !create_transit_gateway.CreateTransitGatewayOutput {
        return create_transit_gateway.execute(self, allocator, input, options);
    }

    /// Creates a Connect attachment from a specified transit gateway attachment. A
    /// Connect attachment is a GRE-based tunnel attachment that you can use to
    /// establish a connection between a transit gateway and an appliance.
    ///
    /// A Connect attachment uses an existing VPC or Amazon Web Services Direct
    /// Connect attachment as the underlying transport mechanism.
    pub fn createTransitGatewayConnect(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_connect.CreateTransitGatewayConnectInput, options: CallOptions) !create_transit_gateway_connect.CreateTransitGatewayConnectOutput {
        return create_transit_gateway_connect.execute(self, allocator, input, options);
    }

    /// Creates a Connect peer for a specified transit gateway Connect attachment
    /// between a
    /// transit gateway and an appliance.
    ///
    /// The peer address and transit gateway address must be the same IP address
    /// family (IPv4 or IPv6).
    ///
    /// For more information, see [Connect
    /// peers](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html#tgw-connect-peer)
    /// in the *Amazon Web Services Transit Gateways Guide*.
    pub fn createTransitGatewayConnectPeer(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_connect_peer.CreateTransitGatewayConnectPeerInput, options: CallOptions) !create_transit_gateway_connect_peer.CreateTransitGatewayConnectPeerOutput {
        return create_transit_gateway_connect_peer.execute(self, allocator, input, options);
    }

    /// Creates a metering policy for a transit gateway to track and measure network
    /// traffic.
    pub fn createTransitGatewayMeteringPolicy(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_metering_policy.CreateTransitGatewayMeteringPolicyInput, options: CallOptions) !create_transit_gateway_metering_policy.CreateTransitGatewayMeteringPolicyOutput {
        return create_transit_gateway_metering_policy.execute(self, allocator, input, options);
    }

    /// Creates an entry in a transit gateway metering policy to define traffic
    /// measurement rules.
    pub fn createTransitGatewayMeteringPolicyEntry(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_metering_policy_entry.CreateTransitGatewayMeteringPolicyEntryInput, options: CallOptions) !create_transit_gateway_metering_policy_entry.CreateTransitGatewayMeteringPolicyEntryOutput {
        return create_transit_gateway_metering_policy_entry.execute(self, allocator, input, options);
    }

    /// Creates a multicast domain using the specified transit gateway.
    ///
    /// The transit gateway must be in the available state before you create a
    /// domain. Use
    /// [DescribeTransitGateways](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeTransitGateways.html) to see the state of transit gateway.
    pub fn createTransitGatewayMulticastDomain(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_multicast_domain.CreateTransitGatewayMulticastDomainInput, options: CallOptions) !create_transit_gateway_multicast_domain.CreateTransitGatewayMulticastDomainOutput {
        return create_transit_gateway_multicast_domain.execute(self, allocator, input, options);
    }

    /// Requests a transit gateway peering attachment between the specified transit
    /// gateway
    /// (requester) and a peer transit gateway (accepter). The peer transit gateway
    /// can be in
    /// your account or a different Amazon Web Services account.
    ///
    /// After you create the peering attachment, the owner of the accepter transit
    /// gateway
    /// must accept the attachment request.
    pub fn createTransitGatewayPeeringAttachment(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_peering_attachment.CreateTransitGatewayPeeringAttachmentInput, options: CallOptions) !create_transit_gateway_peering_attachment.CreateTransitGatewayPeeringAttachmentOutput {
        return create_transit_gateway_peering_attachment.execute(self, allocator, input, options);
    }

    /// Creates a transit gateway policy table.
    pub fn createTransitGatewayPolicyTable(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_policy_table.CreateTransitGatewayPolicyTableInput, options: CallOptions) !create_transit_gateway_policy_table.CreateTransitGatewayPolicyTableOutput {
        return create_transit_gateway_policy_table.execute(self, allocator, input, options);
    }

    /// Creates a reference (route) to a prefix list in a specified transit gateway
    /// route table.
    pub fn createTransitGatewayPrefixListReference(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_prefix_list_reference.CreateTransitGatewayPrefixListReferenceInput, options: CallOptions) !create_transit_gateway_prefix_list_reference.CreateTransitGatewayPrefixListReferenceOutput {
        return create_transit_gateway_prefix_list_reference.execute(self, allocator, input, options);
    }

    /// Creates a static route for the specified transit gateway route table.
    pub fn createTransitGatewayRoute(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_route.CreateTransitGatewayRouteInput, options: CallOptions) !create_transit_gateway_route.CreateTransitGatewayRouteOutput {
        return create_transit_gateway_route.execute(self, allocator, input, options);
    }

    /// Creates a route table for the specified transit gateway.
    pub fn createTransitGatewayRouteTable(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_route_table.CreateTransitGatewayRouteTableInput, options: CallOptions) !create_transit_gateway_route_table.CreateTransitGatewayRouteTableOutput {
        return create_transit_gateway_route_table.execute(self, allocator, input, options);
    }

    /// Advertises a new transit gateway route table.
    pub fn createTransitGatewayRouteTableAnnouncement(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_route_table_announcement.CreateTransitGatewayRouteTableAnnouncementInput, options: CallOptions) !create_transit_gateway_route_table_announcement.CreateTransitGatewayRouteTableAnnouncementOutput {
        return create_transit_gateway_route_table_announcement.execute(self, allocator, input, options);
    }

    /// Attaches the specified VPC to the specified transit gateway.
    ///
    /// If you attach a VPC with a CIDR range that overlaps the CIDR range of a VPC
    /// that is already attached,
    /// the new VPC CIDR range is not propagated to the default propagation route
    /// table.
    ///
    /// To send VPC traffic to an attached transit gateway, add a route to the VPC
    /// route table using CreateRoute.
    pub fn createTransitGatewayVpcAttachment(self: *Self, allocator: std.mem.Allocator, input: create_transit_gateway_vpc_attachment.CreateTransitGatewayVpcAttachmentInput, options: CallOptions) !create_transit_gateway_vpc_attachment.CreateTransitGatewayVpcAttachmentOutput {
        return create_transit_gateway_vpc_attachment.execute(self, allocator, input, options);
    }

    /// An Amazon Web Services Verified Access endpoint is where you define your
    /// application along with an optional endpoint-level access policy.
    pub fn createVerifiedAccessEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_verified_access_endpoint.CreateVerifiedAccessEndpointInput, options: CallOptions) !create_verified_access_endpoint.CreateVerifiedAccessEndpointOutput {
        return create_verified_access_endpoint.execute(self, allocator, input, options);
    }

    /// An Amazon Web Services Verified Access group is a collection of Amazon Web
    /// Services Verified Access endpoints who's associated applications have
    /// similar security requirements. Each instance within a Verified Access group
    /// shares an Verified Access policy. For
    /// example, you can group all Verified Access instances associated with "sales"
    /// applications together and
    /// use one common Verified Access policy.
    pub fn createVerifiedAccessGroup(self: *Self, allocator: std.mem.Allocator, input: create_verified_access_group.CreateVerifiedAccessGroupInput, options: CallOptions) !create_verified_access_group.CreateVerifiedAccessGroupOutput {
        return create_verified_access_group.execute(self, allocator, input, options);
    }

    /// An Amazon Web Services Verified Access instance is a regional entity that
    /// evaluates application requests and grants
    /// access only when your security requirements are met.
    pub fn createVerifiedAccessInstance(self: *Self, allocator: std.mem.Allocator, input: create_verified_access_instance.CreateVerifiedAccessInstanceInput, options: CallOptions) !create_verified_access_instance.CreateVerifiedAccessInstanceOutput {
        return create_verified_access_instance.execute(self, allocator, input, options);
    }

    /// A trust provider is a third-party entity that creates, maintains, and
    /// manages identity
    /// information for users and devices. When an application request is made, the
    /// identity
    /// information sent by the trust provider is evaluated by Verified Access
    /// before allowing or
    /// denying the application request.
    pub fn createVerifiedAccessTrustProvider(self: *Self, allocator: std.mem.Allocator, input: create_verified_access_trust_provider.CreateVerifiedAccessTrustProviderInput, options: CallOptions) !create_verified_access_trust_provider.CreateVerifiedAccessTrustProviderOutput {
        return create_verified_access_trust_provider.execute(self, allocator, input, options);
    }

    /// Creates an EBS volume that can be attached to an instance in the same
    /// Availability Zone.
    ///
    /// You can create a new empty volume or restore a volume from an EBS snapshot.
    /// Any Amazon Web Services Marketplace product codes from the snapshot are
    /// propagated to the volume.
    ///
    /// You can create encrypted volumes. Encrypted volumes must be attached to
    /// instances that
    /// support Amazon EBS encryption. Volumes that are created from encrypted
    /// snapshots are also automatically
    /// encrypted. For more information, see [Amazon EBS
    /// encryption](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption.html)
    /// in the *Amazon EBS User Guide*.
    ///
    /// You can tag your volumes during creation. For more information, see [Tag
    /// your Amazon EC2
    /// resources](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html) in the *Amazon EC2 User Guide*.
    ///
    /// For more information, see [Create an Amazon EBS
    /// volume](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-creating-volume.html) in the
    /// *Amazon EBS User Guide*.
    pub fn createVolume(self: *Self, allocator: std.mem.Allocator, input: create_volume.CreateVolumeInput, options: CallOptions) !create_volume.CreateVolumeOutput {
        return create_volume.execute(self, allocator, input, options);
    }

    /// Creates a VPC with the specified CIDR blocks.
    ///
    /// A VPC must have an associated IPv4 CIDR block. You can choose an IPv4 CIDR
    /// block or an
    /// IPAM-allocated IPv4 CIDR block. You can optionally associate an IPv6 CIDR
    /// block with a
    /// VPC. You can choose an IPv6 CIDR block, an Amazon-provided IPv6 CIDR block,
    /// an
    /// IPAM-allocated IPv6 CIDR block, or an IPv6 CIDR block that you brought to
    /// Amazon Web Services. For
    /// more information, see [IP addressing for your VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-ip-addressing.html) in the *Amazon VPC User Guide*.
    ///
    /// By default, each instance that you launch in the VPC has the default DHCP
    /// options, which
    /// include only a default DNS server that we provide (AmazonProvidedDNS). For
    /// more
    /// information, see [DHCP option
    /// sets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_DHCP_Options.html) in the *Amazon VPC User Guide*.
    ///
    /// You can specify DNS options and tenancy for a VPC when you create it. You
    /// can't change
    /// the tenancy of a VPC after you create it. For more information, see [VPC
    /// configuration
    /// options](https://docs.aws.amazon.com/vpc/latest/userguide/create-vpc-options.html) in the
    /// *Amazon VPC User Guide*.
    pub fn createVpc(self: *Self, allocator: std.mem.Allocator, input: create_vpc.CreateVpcInput, options: CallOptions) !create_vpc.CreateVpcOutput {
        return create_vpc.execute(self, allocator, input, options);
    }

    /// Create a VPC Block Public Access (BPA) exclusion. A VPC BPA exclusion is a
    /// mode that can be applied to a single VPC or subnet that exempts it from the
    /// account’s BPA mode and will allow bidirectional or egress-only access. You
    /// can create BPA exclusions for VPCs and subnets even when BPA is not enabled
    /// on the account to ensure that there is no traffic disruption to the
    /// exclusions when VPC BPA is turned on. To learn more about VPC BPA, see
    /// [Block public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    pub fn createVpcBlockPublicAccessExclusion(self: *Self, allocator: std.mem.Allocator, input: create_vpc_block_public_access_exclusion.CreateVpcBlockPublicAccessExclusionInput, options: CallOptions) !create_vpc_block_public_access_exclusion.CreateVpcBlockPublicAccessExclusionOutput {
        return create_vpc_block_public_access_exclusion.execute(self, allocator, input, options);
    }

    /// Creates a VPC Encryption Control configuration for a specified VPC. VPC
    /// Encryption Control enables you to enforce encryption for all data in transit
    /// within and between VPCs to meet compliance requirements for standards like
    /// HIPAA, FedRAMP, and PCI DSS.
    ///
    /// For more information, see [Enforce VPC encryption in
    /// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
    pub fn createVpcEncryptionControl(self: *Self, allocator: std.mem.Allocator, input: create_vpc_encryption_control.CreateVpcEncryptionControlInput, options: CallOptions) !create_vpc_encryption_control.CreateVpcEncryptionControlOutput {
        return create_vpc_encryption_control.execute(self, allocator, input, options);
    }

    /// Creates a VPC endpoint. A VPC endpoint provides a private connection between
    /// the
    /// specified VPC and the specified endpoint service. You can use an endpoint
    /// service
    /// provided by Amazon Web Services, an Amazon Web Services Marketplace Partner,
    /// or another
    /// Amazon Web Services account. For more information, see the [Amazon Web
    /// Services PrivateLink User
    /// Guide](https://docs.aws.amazon.com/vpc/latest/privatelink/).
    pub fn createVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: create_vpc_endpoint.CreateVpcEndpointInput, options: CallOptions) !create_vpc_endpoint.CreateVpcEndpointOutput {
        return create_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Creates a connection notification for a specified VPC endpoint or VPC
    /// endpoint
    /// service. A connection notification notifies you of specific endpoint events.
    /// You must
    /// create an SNS topic to receive notifications. For more information, see
    /// [Creating an Amazon SNS
    /// topic](https://docs.aws.amazon.com/sns/latest/dg/CreateTopic.html) in
    /// the *Amazon SNS Developer Guide*.
    ///
    /// You can create a connection notification for interface endpoints only.
    pub fn createVpcEndpointConnectionNotification(self: *Self, allocator: std.mem.Allocator, input: create_vpc_endpoint_connection_notification.CreateVpcEndpointConnectionNotificationInput, options: CallOptions) !create_vpc_endpoint_connection_notification.CreateVpcEndpointConnectionNotificationOutput {
        return create_vpc_endpoint_connection_notification.execute(self, allocator, input, options);
    }

    /// Creates a VPC endpoint service to which service consumers (Amazon Web
    /// Services accounts,
    /// users, and IAM roles) can connect.
    ///
    /// Before you create an endpoint service, you must create one of the following
    /// for your service:
    ///
    /// * A [Network Load
    ///   Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/network/).
    /// Service consumers connect to your service using an interface endpoint.
    ///
    /// * A [Gateway Load
    ///   Balancer](https://docs.aws.amazon.com/elasticloadbalancing/latest/gateway/).
    /// Service consumers connect to your service using a Gateway Load Balancer
    /// endpoint.
    ///
    /// If you set the private DNS name, you must prove that you own the private DNS
    /// domain
    /// name.
    ///
    /// For more information, see the [Amazon Web Services PrivateLink
    /// Guide](https://docs.aws.amazon.com/vpc/latest/privatelink/).
    pub fn createVpcEndpointServiceConfiguration(self: *Self, allocator: std.mem.Allocator, input: create_vpc_endpoint_service_configuration.CreateVpcEndpointServiceConfigurationInput, options: CallOptions) !create_vpc_endpoint_service_configuration.CreateVpcEndpointServiceConfigurationOutput {
        return create_vpc_endpoint_service_configuration.execute(self, allocator, input, options);
    }

    /// Requests a VPC peering connection between two VPCs: a requester VPC that you
    /// own and
    /// an accepter VPC with which to create the connection. The accepter VPC can
    /// belong to
    /// another Amazon Web Services account and can be in a different Region to the
    /// requester VPC.
    /// The requester VPC and accepter VPC cannot have overlapping CIDR blocks.
    ///
    /// Limitations and rules apply to a VPC peering connection. For more
    /// information, see
    /// the [VPC peering
    /// limitations](https://docs.aws.amazon.com/vpc/latest/peering/vpc-peering-basics.html#vpc-peering-limitations) in the *VPC Peering Guide*.
    ///
    /// The owner of the accepter VPC must accept the peering request to activate
    /// the peering
    /// connection. The VPC peering connection request expires after 7 days, after
    /// which it
    /// cannot be accepted or rejected.
    ///
    /// If you create a VPC peering connection request between VPCs with overlapping
    /// CIDR
    /// blocks, the VPC peering connection has a status of `failed`.
    pub fn createVpcPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: create_vpc_peering_connection.CreateVpcPeeringConnectionInput, options: CallOptions) !create_vpc_peering_connection.CreateVpcPeeringConnectionOutput {
        return create_vpc_peering_connection.execute(self, allocator, input, options);
    }

    /// Creates a VPN concentrator that aggregates multiple VPN connections to a
    /// transit gateway.
    pub fn createVpnConcentrator(self: *Self, allocator: std.mem.Allocator, input: create_vpn_concentrator.CreateVpnConcentratorInput, options: CallOptions) !create_vpn_concentrator.CreateVpnConcentratorOutput {
        return create_vpn_concentrator.execute(self, allocator, input, options);
    }

    /// Creates a VPN connection between an existing virtual private gateway or
    /// transit
    /// gateway and a customer gateway. The supported connection type is
    /// `ipsec.1`.
    ///
    /// The response includes information that you need to give to your network
    /// administrator
    /// to configure your customer gateway.
    ///
    /// We strongly recommend that you use HTTPS when calling this operation because
    /// the
    /// response contains sensitive cryptographic information for configuring your
    /// customer
    /// gateway device.
    ///
    /// If you decide to shut down your VPN connection for any reason and later
    /// create a new
    /// VPN connection, you must reconfigure your customer gateway with the new
    /// information
    /// returned from this call.
    ///
    /// This is an idempotent operation. If you perform the operation more than
    /// once, Amazon
    /// EC2 doesn't return an error.
    ///
    /// For more information, see [Amazon Web Services Site-to-Site
    /// VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html) in the
    /// *Amazon Web Services Site-to-Site VPN
    /// User Guide*.
    pub fn createVpnConnection(self: *Self, allocator: std.mem.Allocator, input: create_vpn_connection.CreateVpnConnectionInput, options: CallOptions) !create_vpn_connection.CreateVpnConnectionOutput {
        return create_vpn_connection.execute(self, allocator, input, options);
    }

    /// Creates a static route associated with a VPN connection between an existing
    /// virtual
    /// private gateway and a VPN customer gateway. The static route allows traffic
    /// to be routed
    /// from the virtual private gateway to the VPN customer gateway.
    ///
    /// For more information, see [Amazon Web Services Site-to-Site
    /// VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html) in the
    /// *Amazon Web Services Site-to-Site VPN
    /// User Guide*.
    pub fn createVpnConnectionRoute(self: *Self, allocator: std.mem.Allocator, input: create_vpn_connection_route.CreateVpnConnectionRouteInput, options: CallOptions) !create_vpn_connection_route.CreateVpnConnectionRouteOutput {
        return create_vpn_connection_route.execute(self, allocator, input, options);
    }

    /// Creates a virtual private gateway. A virtual private gateway is the endpoint
    /// on the
    /// VPC side of your VPN connection. You can create a virtual private gateway
    /// before
    /// creating the VPC itself.
    ///
    /// For more information, see [Amazon Web Services Site-to-Site
    /// VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html) in the
    /// *Amazon Web Services Site-to-Site VPN
    /// User Guide*.
    pub fn createVpnGateway(self: *Self, allocator: std.mem.Allocator, input: create_vpn_gateway.CreateVpnGatewayInput, options: CallOptions) !create_vpn_gateway.CreateVpnGatewayOutput {
        return create_vpn_gateway.execute(self, allocator, input, options);
    }

    /// Deletes an existing Capacity Manager data export configuration. This stops
    /// future scheduled exports but does not delete previously exported files from
    /// S3.
    pub fn deleteCapacityManagerDataExport(self: *Self, allocator: std.mem.Allocator, input: delete_capacity_manager_data_export.DeleteCapacityManagerDataExportInput, options: CallOptions) !delete_capacity_manager_data_export.DeleteCapacityManagerDataExportOutput {
        return delete_capacity_manager_data_export.execute(self, allocator, input, options);
    }

    /// Deletes a carrier gateway.
    ///
    /// If you do not delete the route that contains the carrier gateway as the
    /// Target, the route is a blackhole route. For information about how to delete
    /// a route, see
    /// [DeleteRoute](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeleteRoute.html).
    pub fn deleteCarrierGateway(self: *Self, allocator: std.mem.Allocator, input: delete_carrier_gateway.DeleteCarrierGatewayInput, options: CallOptions) !delete_carrier_gateway.DeleteCarrierGatewayOutput {
        return delete_carrier_gateway.execute(self, allocator, input, options);
    }

    /// Deletes the specified Client VPN endpoint. You must disassociate all target
    /// networks before you
    /// can delete a Client VPN endpoint.
    pub fn deleteClientVpnEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_client_vpn_endpoint.DeleteClientVpnEndpointInput, options: CallOptions) !delete_client_vpn_endpoint.DeleteClientVpnEndpointOutput {
        return delete_client_vpn_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes a route from a Client VPN endpoint. You can only delete routes that
    /// you manually added using
    /// the **CreateClientVpnRoute** action. You cannot delete routes that were
    /// automatically added when associating a subnet. To remove routes that have
    /// been automatically added,
    /// disassociate the target subnet from the Client VPN endpoint.
    pub fn deleteClientVpnRoute(self: *Self, allocator: std.mem.Allocator, input: delete_client_vpn_route.DeleteClientVpnRouteInput, options: CallOptions) !delete_client_vpn_route.DeleteClientVpnRouteOutput {
        return delete_client_vpn_route.execute(self, allocator, input, options);
    }

    /// Deletes a range of customer-owned IP addresses.
    pub fn deleteCoipCidr(self: *Self, allocator: std.mem.Allocator, input: delete_coip_cidr.DeleteCoipCidrInput, options: CallOptions) !delete_coip_cidr.DeleteCoipCidrOutput {
        return delete_coip_cidr.execute(self, allocator, input, options);
    }

    /// Deletes a pool of customer-owned IP (CoIP) addresses.
    pub fn deleteCoipPool(self: *Self, allocator: std.mem.Allocator, input: delete_coip_pool.DeleteCoipPoolInput, options: CallOptions) !delete_coip_pool.DeleteCoipPoolOutput {
        return delete_coip_pool.execute(self, allocator, input, options);
    }

    /// Deletes the specified customer gateway. You must delete the VPN connection
    /// before you
    /// can delete the customer gateway.
    pub fn deleteCustomerGateway(self: *Self, allocator: std.mem.Allocator, input: delete_customer_gateway.DeleteCustomerGatewayInput, options: CallOptions) !delete_customer_gateway.DeleteCustomerGatewayOutput {
        return delete_customer_gateway.execute(self, allocator, input, options);
    }

    /// Deletes the specified set of DHCP options. You must disassociate the set of
    /// DHCP options before you can delete it. You can disassociate the set of DHCP
    /// options by associating either a new set of options or the default set of
    /// options with the VPC.
    pub fn deleteDhcpOptions(self: *Self, allocator: std.mem.Allocator, input: delete_dhcp_options.DeleteDhcpOptionsInput, options: CallOptions) !delete_dhcp_options.DeleteDhcpOptionsOutput {
        return delete_dhcp_options.execute(self, allocator, input, options);
    }

    /// Deletes an egress-only internet gateway.
    pub fn deleteEgressOnlyInternetGateway(self: *Self, allocator: std.mem.Allocator, input: delete_egress_only_internet_gateway.DeleteEgressOnlyInternetGatewayInput, options: CallOptions) !delete_egress_only_internet_gateway.DeleteEgressOnlyInternetGatewayOutput {
        return delete_egress_only_internet_gateway.execute(self, allocator, input, options);
    }

    /// Deletes the specified EC2 Fleet request.
    ///
    /// After you delete an EC2 Fleet request, it launches no new instances.
    ///
    /// You must also specify whether a deleted EC2 Fleet request should terminate
    /// its instances. If
    /// you choose to terminate the instances, the EC2 Fleet request enters the
    /// `deleted_terminating` state. Otherwise, it enters the
    /// `deleted_running` state, and the instances continue to run until they are
    /// interrupted or you terminate them manually.
    ///
    /// A deleted `instant` fleet with running instances is not supported. When you
    /// delete an `instant` fleet, Amazon EC2 automatically terminates all its
    /// instances. For
    /// fleets with more than 1000 instances, the deletion request might fail. If
    /// your fleet has
    /// more than 1000 instances, first terminate most of the instances manually,
    /// leaving 1000 or
    /// fewer. Then delete the fleet, and the remaining instances will be terminated
    /// automatically.
    ///
    /// **Terminating an instance is permanent and irreversible.**
    ///
    /// After you terminate an instance, you can no longer connect to it, and it
    /// can't be recovered.
    /// All attached Amazon EBS volumes that are configured to be deleted on
    /// termination are also permanently
    /// deleted and can't be recovered. All data stored on instance store volumes is
    /// permanently lost.
    /// For more information, see [
    /// How instance termination
    /// works](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/how-ec2-instance-termination-works.html).
    ///
    /// Before you terminate an instance, ensure that you have backed up all data
    /// that you need to
    /// retain after the termination to persistent storage.
    ///
    /// **Restrictions**
    ///
    /// * You can delete up to 25 fleets of type `instant` in a single
    /// request.
    ///
    /// * You can delete up to 100 fleets of type `maintain` or
    /// `request` in a single request.
    ///
    /// * You can delete up to 125 fleets in a single request, provided you do not
    ///   exceed
    /// the quota for each fleet type, as specified above.
    ///
    /// * If you exceed the specified number of fleets to delete, no fleets are
    /// deleted.
    ///
    /// For more information, see [Delete an EC2 Fleet request and the instances
    /// in the
    /// fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/delete-fleet.html) in the *Amazon EC2 User Guide*.
    pub fn deleteFleets(self: *Self, allocator: std.mem.Allocator, input: delete_fleets.DeleteFleetsInput, options: CallOptions) !delete_fleets.DeleteFleetsOutput {
        return delete_fleets.execute(self, allocator, input, options);
    }

    /// Deletes one or more flow logs.
    pub fn deleteFlowLogs(self: *Self, allocator: std.mem.Allocator, input: delete_flow_logs.DeleteFlowLogsInput, options: CallOptions) !delete_flow_logs.DeleteFlowLogsOutput {
        return delete_flow_logs.execute(self, allocator, input, options);
    }

    /// Deletes the specified Amazon FPGA Image (AFI).
    pub fn deleteFpgaImage(self: *Self, allocator: std.mem.Allocator, input: delete_fpga_image.DeleteFpgaImageInput, options: CallOptions) !delete_fpga_image.DeleteFpgaImageOutput {
        return delete_fpga_image.execute(self, allocator, input, options);
    }

    /// Deletes the specified image usage report.
    ///
    /// For more information, see [View your AMI
    /// usage](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/your-ec2-ami-usage.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn deleteImageUsageReport(self: *Self, allocator: std.mem.Allocator, input: delete_image_usage_report.DeleteImageUsageReportInput, options: CallOptions) !delete_image_usage_report.DeleteImageUsageReportOutput {
        return delete_image_usage_report.execute(self, allocator, input, options);
    }

    /// Deletes the specified EC2 Instance Connect Endpoint.
    pub fn deleteInstanceConnectEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_instance_connect_endpoint.DeleteInstanceConnectEndpointInput, options: CallOptions) !delete_instance_connect_endpoint.DeleteInstanceConnectEndpointOutput {
        return delete_instance_connect_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes the specified event window.
    ///
    /// For more information, see [Define event windows for scheduled
    /// events](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/event-windows.html) in the *Amazon EC2 User Guide*.
    pub fn deleteInstanceEventWindow(self: *Self, allocator: std.mem.Allocator, input: delete_instance_event_window.DeleteInstanceEventWindowInput, options: CallOptions) !delete_instance_event_window.DeleteInstanceEventWindowOutput {
        return delete_instance_event_window.execute(self, allocator, input, options);
    }

    /// Deletes the specified internet gateway. You must detach the internet gateway
    /// from the
    /// VPC before you can delete it.
    pub fn deleteInternetGateway(self: *Self, allocator: std.mem.Allocator, input: delete_internet_gateway.DeleteInternetGatewayInput, options: CallOptions) !delete_internet_gateway.DeleteInternetGatewayOutput {
        return delete_internet_gateway.execute(self, allocator, input, options);
    }

    /// Delete an IPAM. Deleting an IPAM removes all monitored data associated with
    /// the IPAM including the historical data for CIDRs.
    ///
    /// For more information, see [Delete an
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/delete-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    pub fn deleteIpam(self: *Self, allocator: std.mem.Allocator, input: delete_ipam.DeleteIpamInput, options: CallOptions) !delete_ipam.DeleteIpamOutput {
        return delete_ipam.execute(self, allocator, input, options);
    }

    /// Delete a verification token.
    ///
    /// A verification token is an Amazon Web Services-generated random value that
    /// you can use to prove ownership of an external resource. For example, you can
    /// use a verification token to validate that you control a public IP address
    /// range when you bring an IP address range to Amazon Web Services (BYOIP).
    pub fn deleteIpamExternalResourceVerificationToken(self: *Self, allocator: std.mem.Allocator, input: delete_ipam_external_resource_verification_token.DeleteIpamExternalResourceVerificationTokenInput, options: CallOptions) !delete_ipam_external_resource_verification_token.DeleteIpamExternalResourceVerificationTokenOutput {
        return delete_ipam_external_resource_verification_token.execute(self, allocator, input, options);
    }

    /// Deletes an IPAM policy.
    ///
    /// An IPAM policy is a set of rules that define how public IPv4 addresses from
    /// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
    /// Amazon Web Services service to IPAM pools that the service will use to get
    /// IP addresses. A single policy can have multiple rules and be applied to
    /// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
    /// then the services fallback to Amazon-provided IP addresses. A policy can be
    /// applied to an individual Amazon Web Services account or an entity within
    /// Amazon Web Services Organizations.
    pub fn deleteIpamPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_ipam_policy.DeleteIpamPolicyInput, options: CallOptions) !delete_ipam_policy.DeleteIpamPolicyOutput {
        return delete_ipam_policy.execute(self, allocator, input, options);
    }

    /// Delete an IPAM pool.
    ///
    /// You cannot delete an IPAM pool if there are allocations in it or CIDRs
    /// provisioned to it. To release
    /// allocations, see
    /// [ReleaseIpamPoolAllocation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ReleaseIpamPoolAllocation.html). To deprovision pool
    /// CIDRs, see
    /// [DeprovisionIpamPoolCidr](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeprovisionIpamPoolCidr.html).
    ///
    /// For more information, see [Delete a
    /// pool](https://docs.aws.amazon.com/vpc/latest/ipam/delete-pool-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    pub fn deleteIpamPool(self: *Self, allocator: std.mem.Allocator, input: delete_ipam_pool.DeleteIpamPoolInput, options: CallOptions) !delete_ipam_pool.DeleteIpamPoolOutput {
        return delete_ipam_pool.execute(self, allocator, input, options);
    }

    /// Deletes an IPAM prefix list resolver. Before deleting a resolver, you must
    /// first delete all resolver targets associated with it.
    pub fn deleteIpamPrefixListResolver(self: *Self, allocator: std.mem.Allocator, input: delete_ipam_prefix_list_resolver.DeleteIpamPrefixListResolverInput, options: CallOptions) !delete_ipam_prefix_list_resolver.DeleteIpamPrefixListResolverOutput {
        return delete_ipam_prefix_list_resolver.execute(self, allocator, input, options);
    }

    /// Deletes an IPAM prefix list resolver target. This removes the association
    /// between the resolver and the managed prefix list, stopping automatic CIDR
    /// synchronization.
    ///
    /// For more information about IPAM prefix list resolver, see [Automate prefix
    /// list updates with
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/automate-prefix-list-updates.html) in the *Amazon VPC IPAM User Guide*.
    pub fn deleteIpamPrefixListResolverTarget(self: *Self, allocator: std.mem.Allocator, input: delete_ipam_prefix_list_resolver_target.DeleteIpamPrefixListResolverTargetInput, options: CallOptions) !delete_ipam_prefix_list_resolver_target.DeleteIpamPrefixListResolverTargetOutput {
        return delete_ipam_prefix_list_resolver_target.execute(self, allocator, input, options);
    }

    /// Deletes an IPAM resource discovery. A resource discovery is an IPAM
    /// component that enables IPAM to manage and monitor resources that belong to
    /// the owning account.
    pub fn deleteIpamResourceDiscovery(self: *Self, allocator: std.mem.Allocator, input: delete_ipam_resource_discovery.DeleteIpamResourceDiscoveryInput, options: CallOptions) !delete_ipam_resource_discovery.DeleteIpamResourceDiscoveryOutput {
        return delete_ipam_resource_discovery.execute(self, allocator, input, options);
    }

    /// Delete the scope for an IPAM. You cannot delete the default scopes.
    ///
    /// For more information, see [Delete a
    /// scope](https://docs.aws.amazon.com/vpc/latest/ipam/delete-scope-ipam.html)
    /// in the *Amazon VPC IPAM User Guide*.
    pub fn deleteIpamScope(self: *Self, allocator: std.mem.Allocator, input: delete_ipam_scope.DeleteIpamScopeInput, options: CallOptions) !delete_ipam_scope.DeleteIpamScopeOutput {
        return delete_ipam_scope.execute(self, allocator, input, options);
    }

    /// Deletes the specified key pair, by removing the public key from Amazon EC2.
    pub fn deleteKeyPair(self: *Self, allocator: std.mem.Allocator, input: delete_key_pair.DeleteKeyPairInput, options: CallOptions) !delete_key_pair.DeleteKeyPairOutput {
        return delete_key_pair.execute(self, allocator, input, options);
    }

    /// Deletes a launch template. Deleting a launch template deletes all of its
    /// versions.
    pub fn deleteLaunchTemplate(self: *Self, allocator: std.mem.Allocator, input: delete_launch_template.DeleteLaunchTemplateInput, options: CallOptions) !delete_launch_template.DeleteLaunchTemplateOutput {
        return delete_launch_template.execute(self, allocator, input, options);
    }

    /// Deletes one or more versions of a launch template.
    ///
    /// You can't delete the default version of a launch template; you must first
    /// assign a
    /// different version as the default. If the default version is the only version
    /// for the
    /// launch template, you must delete the entire launch template using
    /// DeleteLaunchTemplate.
    ///
    /// You can delete up to 200 launch template versions in a single request. To
    /// delete more
    /// than 200 versions in a single request, use DeleteLaunchTemplate, which
    /// deletes the launch template and all of its versions.
    ///
    /// For more information, see [Delete a launch template
    /// version](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/delete-launch-template.html#delete-launch-template-version) in the
    /// *Amazon EC2 User Guide*.
    pub fn deleteLaunchTemplateVersions(self: *Self, allocator: std.mem.Allocator, input: delete_launch_template_versions.DeleteLaunchTemplateVersionsInput, options: CallOptions) !delete_launch_template_versions.DeleteLaunchTemplateVersionsOutput {
        return delete_launch_template_versions.execute(self, allocator, input, options);
    }

    /// Deletes the specified route from the specified local gateway route table.
    pub fn deleteLocalGatewayRoute(self: *Self, allocator: std.mem.Allocator, input: delete_local_gateway_route.DeleteLocalGatewayRouteInput, options: CallOptions) !delete_local_gateway_route.DeleteLocalGatewayRouteOutput {
        return delete_local_gateway_route.execute(self, allocator, input, options);
    }

    /// Deletes a local gateway route table.
    pub fn deleteLocalGatewayRouteTable(self: *Self, allocator: std.mem.Allocator, input: delete_local_gateway_route_table.DeleteLocalGatewayRouteTableInput, options: CallOptions) !delete_local_gateway_route_table.DeleteLocalGatewayRouteTableOutput {
        return delete_local_gateway_route_table.execute(self, allocator, input, options);
    }

    /// Deletes a local gateway route table virtual interface group association.
    pub fn deleteLocalGatewayRouteTableVirtualInterfaceGroupAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_local_gateway_route_table_virtual_interface_group_association.DeleteLocalGatewayRouteTableVirtualInterfaceGroupAssociationInput, options: CallOptions) !delete_local_gateway_route_table_virtual_interface_group_association.DeleteLocalGatewayRouteTableVirtualInterfaceGroupAssociationOutput {
        return delete_local_gateway_route_table_virtual_interface_group_association.execute(self, allocator, input, options);
    }

    /// Deletes the specified association between a VPC and local gateway route
    /// table.
    pub fn deleteLocalGatewayRouteTableVpcAssociation(self: *Self, allocator: std.mem.Allocator, input: delete_local_gateway_route_table_vpc_association.DeleteLocalGatewayRouteTableVpcAssociationInput, options: CallOptions) !delete_local_gateway_route_table_vpc_association.DeleteLocalGatewayRouteTableVpcAssociationOutput {
        return delete_local_gateway_route_table_vpc_association.execute(self, allocator, input, options);
    }

    /// Deletes the specified local gateway virtual interface.
    pub fn deleteLocalGatewayVirtualInterface(self: *Self, allocator: std.mem.Allocator, input: delete_local_gateway_virtual_interface.DeleteLocalGatewayVirtualInterfaceInput, options: CallOptions) !delete_local_gateway_virtual_interface.DeleteLocalGatewayVirtualInterfaceOutput {
        return delete_local_gateway_virtual_interface.execute(self, allocator, input, options);
    }

    /// Delete the specified local gateway interface group.
    pub fn deleteLocalGatewayVirtualInterfaceGroup(self: *Self, allocator: std.mem.Allocator, input: delete_local_gateway_virtual_interface_group.DeleteLocalGatewayVirtualInterfaceGroupInput, options: CallOptions) !delete_local_gateway_virtual_interface_group.DeleteLocalGatewayVirtualInterfaceGroupOutput {
        return delete_local_gateway_virtual_interface_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified managed prefix list. You must first remove all
    /// references to the prefix list in your resources.
    pub fn deleteManagedPrefixList(self: *Self, allocator: std.mem.Allocator, input: delete_managed_prefix_list.DeleteManagedPrefixListInput, options: CallOptions) !delete_managed_prefix_list.DeleteManagedPrefixListOutput {
        return delete_managed_prefix_list.execute(self, allocator, input, options);
    }

    /// Deletes the specified NAT gateway. Deleting a public NAT gateway
    /// disassociates its Elastic IP address,
    /// but does not release the address from your account. Deleting a NAT gateway
    /// does not delete any NAT gateway
    /// routes in your route tables.
    pub fn deleteNatGateway(self: *Self, allocator: std.mem.Allocator, input: delete_nat_gateway.DeleteNatGatewayInput, options: CallOptions) !delete_nat_gateway.DeleteNatGatewayOutput {
        return delete_nat_gateway.execute(self, allocator, input, options);
    }

    /// Deletes the specified network ACL. You can't delete the ACL if it's
    /// associated with any subnets. You can't delete the default network ACL.
    pub fn deleteNetworkAcl(self: *Self, allocator: std.mem.Allocator, input: delete_network_acl.DeleteNetworkAclInput, options: CallOptions) !delete_network_acl.DeleteNetworkAclOutput {
        return delete_network_acl.execute(self, allocator, input, options);
    }

    /// Deletes the specified ingress or egress entry (rule) from the specified
    /// network ACL.
    pub fn deleteNetworkAclEntry(self: *Self, allocator: std.mem.Allocator, input: delete_network_acl_entry.DeleteNetworkAclEntryInput, options: CallOptions) !delete_network_acl_entry.DeleteNetworkAclEntryOutput {
        return delete_network_acl_entry.execute(self, allocator, input, options);
    }

    /// Deletes the specified Network Access Scope.
    pub fn deleteNetworkInsightsAccessScope(self: *Self, allocator: std.mem.Allocator, input: delete_network_insights_access_scope.DeleteNetworkInsightsAccessScopeInput, options: CallOptions) !delete_network_insights_access_scope.DeleteNetworkInsightsAccessScopeOutput {
        return delete_network_insights_access_scope.execute(self, allocator, input, options);
    }

    /// Deletes the specified Network Access Scope analysis.
    pub fn deleteNetworkInsightsAccessScopeAnalysis(self: *Self, allocator: std.mem.Allocator, input: delete_network_insights_access_scope_analysis.DeleteNetworkInsightsAccessScopeAnalysisInput, options: CallOptions) !delete_network_insights_access_scope_analysis.DeleteNetworkInsightsAccessScopeAnalysisOutput {
        return delete_network_insights_access_scope_analysis.execute(self, allocator, input, options);
    }

    /// Deletes the specified network insights analysis.
    pub fn deleteNetworkInsightsAnalysis(self: *Self, allocator: std.mem.Allocator, input: delete_network_insights_analysis.DeleteNetworkInsightsAnalysisInput, options: CallOptions) !delete_network_insights_analysis.DeleteNetworkInsightsAnalysisOutput {
        return delete_network_insights_analysis.execute(self, allocator, input, options);
    }

    /// Deletes the specified path.
    pub fn deleteNetworkInsightsPath(self: *Self, allocator: std.mem.Allocator, input: delete_network_insights_path.DeleteNetworkInsightsPathInput, options: CallOptions) !delete_network_insights_path.DeleteNetworkInsightsPathOutput {
        return delete_network_insights_path.execute(self, allocator, input, options);
    }

    /// Deletes the specified network interface. You must detach the network
    /// interface before
    /// you can delete it.
    pub fn deleteNetworkInterface(self: *Self, allocator: std.mem.Allocator, input: delete_network_interface.DeleteNetworkInterfaceInput, options: CallOptions) !delete_network_interface.DeleteNetworkInterfaceOutput {
        return delete_network_interface.execute(self, allocator, input, options);
    }

    /// Deletes a permission for a network interface. By default, you cannot delete
    /// the
    /// permission if the account for which you're removing the permission has
    /// attached the
    /// network interface to an instance. However, you can force delete the
    /// permission,
    /// regardless of any attachment.
    pub fn deleteNetworkInterfacePermission(self: *Self, allocator: std.mem.Allocator, input: delete_network_interface_permission.DeleteNetworkInterfacePermissionInput, options: CallOptions) !delete_network_interface_permission.DeleteNetworkInterfacePermissionOutput {
        return delete_network_interface_permission.execute(self, allocator, input, options);
    }

    /// Deletes the specified placement group. You must terminate all instances in
    /// the
    /// placement group before you can delete the placement group. For more
    /// information, see
    /// [Placement
    /// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html) in the *Amazon EC2 User Guide*.
    pub fn deletePlacementGroup(self: *Self, allocator: std.mem.Allocator, input: delete_placement_group.DeletePlacementGroupInput, options: CallOptions) !delete_placement_group.DeletePlacementGroupOutput {
        return delete_placement_group.execute(self, allocator, input, options);
    }

    /// Delete a public IPv4 pool. A public IPv4 pool is an EC2 IP address pool
    /// required for the public IPv4 CIDRs that you own and bring to Amazon Web
    /// Services to manage with IPAM. IPv6 addresses you bring to Amazon Web
    /// Services, however, use IPAM pools only.
    pub fn deletePublicIpv4Pool(self: *Self, allocator: std.mem.Allocator, input: delete_public_ipv_4_pool.DeletePublicIpv4PoolInput, options: CallOptions) !delete_public_ipv_4_pool.DeletePublicIpv4PoolOutput {
        return delete_public_ipv_4_pool.execute(self, allocator, input, options);
    }

    /// Deletes the queued purchases for the specified Reserved Instances.
    pub fn deleteQueuedReservedInstances(self: *Self, allocator: std.mem.Allocator, input: delete_queued_reserved_instances.DeleteQueuedReservedInstancesInput, options: CallOptions) !delete_queued_reserved_instances.DeleteQueuedReservedInstancesOutput {
        return delete_queued_reserved_instances.execute(self, allocator, input, options);
    }

    /// Deletes the specified route from the specified route table.
    pub fn deleteRoute(self: *Self, allocator: std.mem.Allocator, input: delete_route.DeleteRouteInput, options: CallOptions) !delete_route.DeleteRouteOutput {
        return delete_route.execute(self, allocator, input, options);
    }

    /// Deletes the specified route server.
    ///
    /// Amazon VPC Route Server simplifies routing for traffic between workloads
    /// that are deployed within a VPC and its internet gateways. With this feature,
    /// VPC Route Server dynamically updates VPC and internet gateway route tables
    /// with your preferred IPv4 or IPv6 routes to achieve routing fault tolerance
    /// for those workloads. This enables you to automatically reroute traffic
    /// within a VPC, which increases the manageability of VPC routing and
    /// interoperability with third-party workloads.
    ///
    /// Route server supports the follow route table types:
    ///
    /// * VPC route tables not associated with subnets
    ///
    /// * Subnet route tables
    ///
    /// * Internet gateway route tables
    ///
    /// Route server does not support route tables associated with virtual private
    /// gateways. To propagate routes into a transit gateway route table, use
    /// [Transit Gateway
    /// Connect](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html).
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn deleteRouteServer(self: *Self, allocator: std.mem.Allocator, input: delete_route_server.DeleteRouteServerInput, options: CallOptions) !delete_route_server.DeleteRouteServerOutput {
        return delete_route_server.execute(self, allocator, input, options);
    }

    /// Deletes the specified route server endpoint.
    ///
    /// A route server endpoint is an Amazon Web Services-managed component inside a
    /// subnet that facilitates [BGP (Border Gateway
    /// Protocol)](https://en.wikipedia.org/wiki/Border_Gateway_Protocol)
    /// connections between your route server and your BGP peers.
    pub fn deleteRouteServerEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_route_server_endpoint.DeleteRouteServerEndpointInput, options: CallOptions) !delete_route_server_endpoint.DeleteRouteServerEndpointOutput {
        return delete_route_server_endpoint.execute(self, allocator, input, options);
    }

    /// Deletes the specified BGP peer from a route server.
    ///
    /// A route server peer is a session between a route server endpoint and the
    /// device deployed in Amazon Web Services (such as a firewall appliance or
    /// other network security function running on an EC2 instance). The device must
    /// meet these requirements:
    ///
    /// * Have an elastic network interface in the VPC
    ///
    /// * Support BGP (Border Gateway Protocol)
    ///
    /// * Can initiate BGP sessions
    pub fn deleteRouteServerPeer(self: *Self, allocator: std.mem.Allocator, input: delete_route_server_peer.DeleteRouteServerPeerInput, options: CallOptions) !delete_route_server_peer.DeleteRouteServerPeerOutput {
        return delete_route_server_peer.execute(self, allocator, input, options);
    }

    /// Deletes the specified route table. You must disassociate the route table
    /// from any subnets before you can delete it. You can't delete the main route
    /// table.
    pub fn deleteRouteTable(self: *Self, allocator: std.mem.Allocator, input: delete_route_table.DeleteRouteTableInput, options: CallOptions) !delete_route_table.DeleteRouteTableOutput {
        return delete_route_table.execute(self, allocator, input, options);
    }

    /// Deletes a security group.
    ///
    /// If you attempt to delete a security group that is associated with an
    /// instance or network interface, is
    /// referenced by another security group in the same VPC, or has a VPC
    /// association, the operation fails with
    /// `DependencyViolation`.
    pub fn deleteSecurityGroup(self: *Self, allocator: std.mem.Allocator, input: delete_security_group.DeleteSecurityGroupInput, options: CallOptions) !delete_security_group.DeleteSecurityGroupOutput {
        return delete_security_group.execute(self, allocator, input, options);
    }

    /// Deletes the specified snapshot.
    ///
    /// When you make periodic snapshots of a volume, the snapshots are incremental,
    /// and only the
    /// blocks on the device that have changed since your last snapshot are saved in
    /// the new snapshot.
    /// When you delete a snapshot, only the data not needed for any other snapshot
    /// is removed. So
    /// regardless of which prior snapshots have been deleted, all active snapshots
    /// will have access
    /// to all the information needed to restore the volume.
    ///
    /// You cannot delete a snapshot of the root device of an EBS volume used by a
    /// registered AMI.
    /// You must first deregister the AMI before you can delete the snapshot.
    ///
    /// For more information, see [Delete an Amazon EBS
    /// snapshot](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-deleting-snapshot.html) in the
    /// *Amazon EBS User Guide*.
    pub fn deleteSnapshot(self: *Self, allocator: std.mem.Allocator, input: delete_snapshot.DeleteSnapshotInput, options: CallOptions) !delete_snapshot.DeleteSnapshotOutput {
        return delete_snapshot.execute(self, allocator, input, options);
    }

    /// Deletes the data feed for Spot Instances.
    pub fn deleteSpotDatafeedSubscription(self: *Self, allocator: std.mem.Allocator, input: delete_spot_datafeed_subscription.DeleteSpotDatafeedSubscriptionInput, options: CallOptions) !delete_spot_datafeed_subscription.DeleteSpotDatafeedSubscriptionOutput {
        return delete_spot_datafeed_subscription.execute(self, allocator, input, options);
    }

    /// Deletes the specified subnet. You must terminate all running instances in
    /// the subnet before you can delete the subnet.
    pub fn deleteSubnet(self: *Self, allocator: std.mem.Allocator, input: delete_subnet.DeleteSubnetInput, options: CallOptions) !delete_subnet.DeleteSubnetOutput {
        return delete_subnet.execute(self, allocator, input, options);
    }

    /// Deletes a subnet CIDR reservation.
    pub fn deleteSubnetCidrReservation(self: *Self, allocator: std.mem.Allocator, input: delete_subnet_cidr_reservation.DeleteSubnetCidrReservationInput, options: CallOptions) !delete_subnet_cidr_reservation.DeleteSubnetCidrReservationOutput {
        return delete_subnet_cidr_reservation.execute(self, allocator, input, options);
    }

    /// Deletes the specified set of tags from the specified set of resources.
    ///
    /// To list the current tags, use DescribeTags. For more information about
    /// tags, see [Tag
    /// your Amazon EC2
    /// resources](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html) in the *Amazon Elastic Compute Cloud User
    /// Guide*.
    pub fn deleteTags(self: *Self, allocator: std.mem.Allocator, input: delete_tags.DeleteTagsInput, options: CallOptions) !delete_tags.DeleteTagsOutput {
        return delete_tags.execute(self, allocator, input, options);
    }

    /// Deletes the specified Traffic Mirror filter.
    ///
    /// You cannot delete a Traffic Mirror filter that is in use by a Traffic Mirror
    /// session.
    pub fn deleteTrafficMirrorFilter(self: *Self, allocator: std.mem.Allocator, input: delete_traffic_mirror_filter.DeleteTrafficMirrorFilterInput, options: CallOptions) !delete_traffic_mirror_filter.DeleteTrafficMirrorFilterOutput {
        return delete_traffic_mirror_filter.execute(self, allocator, input, options);
    }

    /// Deletes the specified Traffic Mirror rule.
    pub fn deleteTrafficMirrorFilterRule(self: *Self, allocator: std.mem.Allocator, input: delete_traffic_mirror_filter_rule.DeleteTrafficMirrorFilterRuleInput, options: CallOptions) !delete_traffic_mirror_filter_rule.DeleteTrafficMirrorFilterRuleOutput {
        return delete_traffic_mirror_filter_rule.execute(self, allocator, input, options);
    }

    /// Deletes the specified Traffic Mirror session.
    pub fn deleteTrafficMirrorSession(self: *Self, allocator: std.mem.Allocator, input: delete_traffic_mirror_session.DeleteTrafficMirrorSessionInput, options: CallOptions) !delete_traffic_mirror_session.DeleteTrafficMirrorSessionOutput {
        return delete_traffic_mirror_session.execute(self, allocator, input, options);
    }

    /// Deletes the specified Traffic Mirror target.
    ///
    /// You cannot delete a Traffic Mirror target that is in use by a Traffic Mirror
    /// session.
    pub fn deleteTrafficMirrorTarget(self: *Self, allocator: std.mem.Allocator, input: delete_traffic_mirror_target.DeleteTrafficMirrorTargetInput, options: CallOptions) !delete_traffic_mirror_target.DeleteTrafficMirrorTargetOutput {
        return delete_traffic_mirror_target.execute(self, allocator, input, options);
    }

    /// Deletes the specified transit gateway.
    pub fn deleteTransitGateway(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway.DeleteTransitGatewayInput, options: CallOptions) !delete_transit_gateway.DeleteTransitGatewayOutput {
        return delete_transit_gateway.execute(self, allocator, input, options);
    }

    /// Deletes the specified Connect attachment. You must first delete any Connect
    /// peers for
    /// the attachment.
    pub fn deleteTransitGatewayConnect(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_connect.DeleteTransitGatewayConnectInput, options: CallOptions) !delete_transit_gateway_connect.DeleteTransitGatewayConnectOutput {
        return delete_transit_gateway_connect.execute(self, allocator, input, options);
    }

    /// Deletes the specified Connect peer.
    pub fn deleteTransitGatewayConnectPeer(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_connect_peer.DeleteTransitGatewayConnectPeerInput, options: CallOptions) !delete_transit_gateway_connect_peer.DeleteTransitGatewayConnectPeerOutput {
        return delete_transit_gateway_connect_peer.execute(self, allocator, input, options);
    }

    /// Deletes a transit gateway metering policy.
    pub fn deleteTransitGatewayMeteringPolicy(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_metering_policy.DeleteTransitGatewayMeteringPolicyInput, options: CallOptions) !delete_transit_gateway_metering_policy.DeleteTransitGatewayMeteringPolicyOutput {
        return delete_transit_gateway_metering_policy.execute(self, allocator, input, options);
    }

    /// Deletes an entry from a transit gateway metering policy.
    pub fn deleteTransitGatewayMeteringPolicyEntry(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_metering_policy_entry.DeleteTransitGatewayMeteringPolicyEntryInput, options: CallOptions) !delete_transit_gateway_metering_policy_entry.DeleteTransitGatewayMeteringPolicyEntryOutput {
        return delete_transit_gateway_metering_policy_entry.execute(self, allocator, input, options);
    }

    /// Deletes the specified transit gateway multicast domain.
    pub fn deleteTransitGatewayMulticastDomain(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_multicast_domain.DeleteTransitGatewayMulticastDomainInput, options: CallOptions) !delete_transit_gateway_multicast_domain.DeleteTransitGatewayMulticastDomainOutput {
        return delete_transit_gateway_multicast_domain.execute(self, allocator, input, options);
    }

    /// Deletes a transit gateway peering attachment.
    pub fn deleteTransitGatewayPeeringAttachment(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_peering_attachment.DeleteTransitGatewayPeeringAttachmentInput, options: CallOptions) !delete_transit_gateway_peering_attachment.DeleteTransitGatewayPeeringAttachmentOutput {
        return delete_transit_gateway_peering_attachment.execute(self, allocator, input, options);
    }

    /// Deletes the specified transit gateway policy table.
    pub fn deleteTransitGatewayPolicyTable(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_policy_table.DeleteTransitGatewayPolicyTableInput, options: CallOptions) !delete_transit_gateway_policy_table.DeleteTransitGatewayPolicyTableOutput {
        return delete_transit_gateway_policy_table.execute(self, allocator, input, options);
    }

    /// Deletes a reference (route) to a prefix list in a specified transit gateway
    /// route table.
    pub fn deleteTransitGatewayPrefixListReference(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_prefix_list_reference.DeleteTransitGatewayPrefixListReferenceInput, options: CallOptions) !delete_transit_gateway_prefix_list_reference.DeleteTransitGatewayPrefixListReferenceOutput {
        return delete_transit_gateway_prefix_list_reference.execute(self, allocator, input, options);
    }

    /// Deletes the specified route from the specified transit gateway route table.
    pub fn deleteTransitGatewayRoute(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_route.DeleteTransitGatewayRouteInput, options: CallOptions) !delete_transit_gateway_route.DeleteTransitGatewayRouteOutput {
        return delete_transit_gateway_route.execute(self, allocator, input, options);
    }

    /// Deletes the specified transit gateway route table. If there are any route
    /// tables associated with
    /// the transit gateway route table, you must first run DisassociateRouteTable
    /// before you can delete the transit gateway route table. This removes any
    /// route tables associated with the transit gateway route table.
    pub fn deleteTransitGatewayRouteTable(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_route_table.DeleteTransitGatewayRouteTableInput, options: CallOptions) !delete_transit_gateway_route_table.DeleteTransitGatewayRouteTableOutput {
        return delete_transit_gateway_route_table.execute(self, allocator, input, options);
    }

    /// Advertises to the transit gateway that a transit gateway route table is
    /// deleted.
    pub fn deleteTransitGatewayRouteTableAnnouncement(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_route_table_announcement.DeleteTransitGatewayRouteTableAnnouncementInput, options: CallOptions) !delete_transit_gateway_route_table_announcement.DeleteTransitGatewayRouteTableAnnouncementOutput {
        return delete_transit_gateway_route_table_announcement.execute(self, allocator, input, options);
    }

    /// Deletes the specified VPC attachment.
    pub fn deleteTransitGatewayVpcAttachment(self: *Self, allocator: std.mem.Allocator, input: delete_transit_gateway_vpc_attachment.DeleteTransitGatewayVpcAttachmentInput, options: CallOptions) !delete_transit_gateway_vpc_attachment.DeleteTransitGatewayVpcAttachmentOutput {
        return delete_transit_gateway_vpc_attachment.execute(self, allocator, input, options);
    }

    /// Delete an Amazon Web Services Verified Access endpoint.
    pub fn deleteVerifiedAccessEndpoint(self: *Self, allocator: std.mem.Allocator, input: delete_verified_access_endpoint.DeleteVerifiedAccessEndpointInput, options: CallOptions) !delete_verified_access_endpoint.DeleteVerifiedAccessEndpointOutput {
        return delete_verified_access_endpoint.execute(self, allocator, input, options);
    }

    /// Delete an Amazon Web Services Verified Access group.
    pub fn deleteVerifiedAccessGroup(self: *Self, allocator: std.mem.Allocator, input: delete_verified_access_group.DeleteVerifiedAccessGroupInput, options: CallOptions) !delete_verified_access_group.DeleteVerifiedAccessGroupOutput {
        return delete_verified_access_group.execute(self, allocator, input, options);
    }

    /// Delete an Amazon Web Services Verified Access instance.
    pub fn deleteVerifiedAccessInstance(self: *Self, allocator: std.mem.Allocator, input: delete_verified_access_instance.DeleteVerifiedAccessInstanceInput, options: CallOptions) !delete_verified_access_instance.DeleteVerifiedAccessInstanceOutput {
        return delete_verified_access_instance.execute(self, allocator, input, options);
    }

    /// Delete an Amazon Web Services Verified Access trust provider.
    pub fn deleteVerifiedAccessTrustProvider(self: *Self, allocator: std.mem.Allocator, input: delete_verified_access_trust_provider.DeleteVerifiedAccessTrustProviderInput, options: CallOptions) !delete_verified_access_trust_provider.DeleteVerifiedAccessTrustProviderOutput {
        return delete_verified_access_trust_provider.execute(self, allocator, input, options);
    }

    /// Deletes the specified EBS volume. The volume must be in the `available`
    /// state
    /// (not attached to an instance).
    ///
    /// The volume can remain in the `deleting` state for several minutes.
    ///
    /// For more information, see [Delete an Amazon EBS
    /// volume](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-deleting-volume.html) in the
    /// *Amazon EBS User Guide*.
    pub fn deleteVolume(self: *Self, allocator: std.mem.Allocator, input: delete_volume.DeleteVolumeInput, options: CallOptions) !delete_volume.DeleteVolumeOutput {
        return delete_volume.execute(self, allocator, input, options);
    }

    /// Deletes the specified VPC. You must detach or delete all gateways and
    /// resources that are associated
    /// with the VPC before you can delete it. For example, you must terminate all
    /// instances running in the VPC,
    /// delete all security groups associated with the VPC (except the default one),
    /// delete all route tables
    /// associated with the VPC (except the default one), and so on. When you delete
    /// the VPC, it deletes the
    /// default security group, network ACL, and route table for the VPC.
    ///
    /// If you created a flow log for the VPC that you are deleting, note that flow
    /// logs for deleted
    /// VPCs are eventually automatically removed.
    pub fn deleteVpc(self: *Self, allocator: std.mem.Allocator, input: delete_vpc.DeleteVpcInput, options: CallOptions) !delete_vpc.DeleteVpcOutput {
        return delete_vpc.execute(self, allocator, input, options);
    }

    /// Delete a VPC Block Public Access (BPA) exclusion. A VPC BPA exclusion is a
    /// mode that can be applied to a single VPC or subnet that exempts it from the
    /// account’s BPA mode and will allow bidirectional or egress-only access. You
    /// can create BPA exclusions for VPCs and subnets even when BPA is not enabled
    /// on the account to ensure that there is no traffic disruption to the
    /// exclusions when VPC BPA is turned on. To learn more about VPC BPA, see
    /// [Block public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    pub fn deleteVpcBlockPublicAccessExclusion(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_block_public_access_exclusion.DeleteVpcBlockPublicAccessExclusionInput, options: CallOptions) !delete_vpc_block_public_access_exclusion.DeleteVpcBlockPublicAccessExclusionOutput {
        return delete_vpc_block_public_access_exclusion.execute(self, allocator, input, options);
    }

    /// Deletes a VPC Encryption Control configuration. This removes the encryption
    /// policy enforcement from the specified VPC.
    ///
    /// For more information, see [Enforce VPC encryption in
    /// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
    pub fn deleteVpcEncryptionControl(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_encryption_control.DeleteVpcEncryptionControlInput, options: CallOptions) !delete_vpc_encryption_control.DeleteVpcEncryptionControlOutput {
        return delete_vpc_encryption_control.execute(self, allocator, input, options);
    }

    /// Deletes the specified VPC endpoint connection notifications.
    pub fn deleteVpcEndpointConnectionNotifications(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_endpoint_connection_notifications.DeleteVpcEndpointConnectionNotificationsInput, options: CallOptions) !delete_vpc_endpoint_connection_notifications.DeleteVpcEndpointConnectionNotificationsOutput {
        return delete_vpc_endpoint_connection_notifications.execute(self, allocator, input, options);
    }

    /// Deletes the specified VPC endpoint service configurations. Before you can
    /// delete
    /// an endpoint service configuration, you must reject any `Available` or
    /// `PendingAcceptance` interface endpoint connections that are attached to
    /// the service.
    pub fn deleteVpcEndpointServiceConfigurations(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_endpoint_service_configurations.DeleteVpcEndpointServiceConfigurationsInput, options: CallOptions) !delete_vpc_endpoint_service_configurations.DeleteVpcEndpointServiceConfigurationsOutput {
        return delete_vpc_endpoint_service_configurations.execute(self, allocator, input, options);
    }

    /// Deletes the specified VPC endpoints.
    ///
    /// When you delete a gateway endpoint, we delete the endpoint routes in the
    /// route tables for the endpoint.
    ///
    /// When you delete a Gateway Load Balancer endpoint, we delete its endpoint
    /// network interfaces.
    /// You can only delete Gateway Load Balancer endpoints when the routes that are
    /// associated with the endpoint are deleted.
    ///
    /// When you delete an interface endpoint, we delete its endpoint network
    /// interfaces.
    pub fn deleteVpcEndpoints(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_endpoints.DeleteVpcEndpointsInput, options: CallOptions) !delete_vpc_endpoints.DeleteVpcEndpointsOutput {
        return delete_vpc_endpoints.execute(self, allocator, input, options);
    }

    /// Deletes a VPC peering connection. Either the owner of the requester VPC or
    /// the owner
    /// of the accepter VPC can delete the VPC peering connection if it's in the
    /// `active` state. The owner of the requester VPC can delete a VPC peering
    /// connection in the `pending-acceptance` state. You cannot delete a VPC
    /// peering
    /// connection that's in the `failed` or `rejected` state.
    pub fn deleteVpcPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: delete_vpc_peering_connection.DeleteVpcPeeringConnectionInput, options: CallOptions) !delete_vpc_peering_connection.DeleteVpcPeeringConnectionOutput {
        return delete_vpc_peering_connection.execute(self, allocator, input, options);
    }

    /// Deletes the specified VPN concentrator.
    pub fn deleteVpnConcentrator(self: *Self, allocator: std.mem.Allocator, input: delete_vpn_concentrator.DeleteVpnConcentratorInput, options: CallOptions) !delete_vpn_concentrator.DeleteVpnConcentratorOutput {
        return delete_vpn_concentrator.execute(self, allocator, input, options);
    }

    /// Deletes the specified VPN connection.
    ///
    /// If you're deleting the VPC and its associated components, we recommend that
    /// you detach
    /// the virtual private gateway from the VPC and delete the VPC before deleting
    /// the VPN
    /// connection. If you believe that the tunnel credentials for your VPN
    /// connection have been
    /// compromised, you can delete the VPN connection and create a new one that has
    /// new keys,
    /// without needing to delete the VPC or virtual private gateway. If you create
    /// a new VPN
    /// connection, you must reconfigure the customer gateway device using the new
    /// configuration
    /// information returned with the new VPN connection ID.
    ///
    /// For certificate-based authentication, delete all Certificate Manager (ACM)
    /// private
    /// certificates used for the Amazon Web Services-side tunnel endpoints for the
    /// VPN
    /// connection before deleting the VPN connection.
    pub fn deleteVpnConnection(self: *Self, allocator: std.mem.Allocator, input: delete_vpn_connection.DeleteVpnConnectionInput, options: CallOptions) !delete_vpn_connection.DeleteVpnConnectionOutput {
        return delete_vpn_connection.execute(self, allocator, input, options);
    }

    /// Deletes the specified static route associated with a VPN connection between
    /// an
    /// existing virtual private gateway and a VPN customer gateway. The static
    /// route allows
    /// traffic to be routed from the virtual private gateway to the VPN customer
    /// gateway.
    pub fn deleteVpnConnectionRoute(self: *Self, allocator: std.mem.Allocator, input: delete_vpn_connection_route.DeleteVpnConnectionRouteInput, options: CallOptions) !delete_vpn_connection_route.DeleteVpnConnectionRouteOutput {
        return delete_vpn_connection_route.execute(self, allocator, input, options);
    }

    /// Deletes the specified virtual private gateway. You must first detach the
    /// virtual
    /// private gateway from the VPC. Note that you don't need to delete the virtual
    /// private
    /// gateway if you plan to delete and recreate the VPN connection between your
    /// VPC and your
    /// network.
    pub fn deleteVpnGateway(self: *Self, allocator: std.mem.Allocator, input: delete_vpn_gateway.DeleteVpnGatewayInput, options: CallOptions) !delete_vpn_gateway.DeleteVpnGatewayOutput {
        return delete_vpn_gateway.execute(self, allocator, input, options);
    }

    /// Releases the specified address range that you provisioned for use with your
    /// Amazon Web Services resources
    /// through bring your own IP addresses (BYOIP) and deletes the corresponding
    /// address pool.
    ///
    /// Before you can release an address range, you must stop advertising it and
    /// you must not
    /// have any IP addresses allocated from its address range.
    pub fn deprovisionByoipCidr(self: *Self, allocator: std.mem.Allocator, input: deprovision_byoip_cidr.DeprovisionByoipCidrInput, options: CallOptions) !deprovision_byoip_cidr.DeprovisionByoipCidrOutput {
        return deprovision_byoip_cidr.execute(self, allocator, input, options);
    }

    /// Deprovisions your Autonomous System Number (ASN) from your Amazon Web
    /// Services account. This action can only be called after any BYOIP CIDR
    /// associations are removed from your Amazon Web Services account with
    /// [DisassociateIpamByoasn](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DisassociateIpamByoasn.html).
    /// For more information, see [Tutorial: Bring your ASN to
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoasn.html) in
    /// the *Amazon VPC IPAM guide*.
    pub fn deprovisionIpamByoasn(self: *Self, allocator: std.mem.Allocator, input: deprovision_ipam_byoasn.DeprovisionIpamByoasnInput, options: CallOptions) !deprovision_ipam_byoasn.DeprovisionIpamByoasnOutput {
        return deprovision_ipam_byoasn.execute(self, allocator, input, options);
    }

    /// Deprovision a CIDR provisioned from an IPAM pool. If you deprovision a CIDR
    /// from a pool that has a source pool, the CIDR is recycled back into the
    /// source pool. For more information, see [Deprovision pool
    /// CIDRs](https://docs.aws.amazon.com/vpc/latest/ipam/depro-pool-cidr-ipam.html) in the *Amazon VPC IPAM User Guide*.
    pub fn deprovisionIpamPoolCidr(self: *Self, allocator: std.mem.Allocator, input: deprovision_ipam_pool_cidr.DeprovisionIpamPoolCidrInput, options: CallOptions) !deprovision_ipam_pool_cidr.DeprovisionIpamPoolCidrOutput {
        return deprovision_ipam_pool_cidr.execute(self, allocator, input, options);
    }

    /// Deprovision a CIDR from a public IPv4 pool.
    pub fn deprovisionPublicIpv4PoolCidr(self: *Self, allocator: std.mem.Allocator, input: deprovision_public_ipv_4_pool_cidr.DeprovisionPublicIpv4PoolCidrInput, options: CallOptions) !deprovision_public_ipv_4_pool_cidr.DeprovisionPublicIpv4PoolCidrOutput {
        return deprovision_public_ipv_4_pool_cidr.execute(self, allocator, input, options);
    }

    /// Deregisters the specified AMI. A deregistered AMI can't be used to launch
    /// new
    /// instances.
    ///
    /// If a deregistered EBS-backed AMI matches a Recycle Bin retention rule, it
    /// moves to the
    /// Recycle Bin for the specified retention period. It can be restored before
    /// its retention period
    /// expires, after which it is permanently deleted. If the deregistered AMI
    /// doesn't match a
    /// retention rule, it is permanently deleted immediately. For more information,
    /// see [Recover deleted Amazon EBS
    /// snapshots and EBS-backed AMIs with Recycle
    /// Bin](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recycle-bin.html)
    /// in the *Amazon EBS User
    /// Guide*.
    ///
    /// When deregistering an EBS-backed AMI, you can optionally delete its
    /// associated snapshots
    /// at the same time. However, if a snapshot is associated with multiple AMIs,
    /// it won't be deleted
    /// even if specified for deletion, although the AMI will still be deregistered.
    ///
    /// Deregistering an AMI does not delete the following:
    ///
    /// * Instances already launched from the AMI. You'll continue to incur usage
    ///   costs for the
    /// instances until you terminate them.
    ///
    /// * For EBS-backed AMIs: Snapshots that are associated with multiple AMIs.
    ///   You'll continue
    /// to incur snapshot storage costs.
    ///
    /// * For instance store-backed AMIs: The files uploaded to Amazon S3 during AMI
    ///   creation. You'll
    /// continue to incur S3 storage costs.
    ///
    /// For more information, see [Deregister an Amazon EC2
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/deregister-ami.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn deregisterImage(self: *Self, allocator: std.mem.Allocator, input: deregister_image.DeregisterImageInput, options: CallOptions) !deregister_image.DeregisterImageOutput {
        return deregister_image.execute(self, allocator, input, options);
    }

    /// Deregisters tag keys to prevent tags that have the specified tag keys from
    /// being
    /// included in scheduled event notifications for resources in the Region.
    pub fn deregisterInstanceEventNotificationAttributes(self: *Self, allocator: std.mem.Allocator, input: deregister_instance_event_notification_attributes.DeregisterInstanceEventNotificationAttributesInput, options: CallOptions) !deregister_instance_event_notification_attributes.DeregisterInstanceEventNotificationAttributesOutput {
        return deregister_instance_event_notification_attributes.execute(self, allocator, input, options);
    }

    /// Deregisters the specified members (network interfaces) from the transit
    /// gateway multicast group.
    pub fn deregisterTransitGatewayMulticastGroupMembers(self: *Self, allocator: std.mem.Allocator, input: deregister_transit_gateway_multicast_group_members.DeregisterTransitGatewayMulticastGroupMembersInput, options: CallOptions) !deregister_transit_gateway_multicast_group_members.DeregisterTransitGatewayMulticastGroupMembersOutput {
        return deregister_transit_gateway_multicast_group_members.execute(self, allocator, input, options);
    }

    /// Deregisters the specified sources (network interfaces) from the transit
    /// gateway multicast group.
    pub fn deregisterTransitGatewayMulticastGroupSources(self: *Self, allocator: std.mem.Allocator, input: deregister_transit_gateway_multicast_group_sources.DeregisterTransitGatewayMulticastGroupSourcesInput, options: CallOptions) !deregister_transit_gateway_multicast_group_sources.DeregisterTransitGatewayMulticastGroupSourcesOutput {
        return deregister_transit_gateway_multicast_group_sources.execute(self, allocator, input, options);
    }

    /// Describes attributes of your Amazon Web Services account. The following are
    /// the supported account attributes:
    ///
    /// * `default-vpc`: The ID of the default VPC for your account, or `none`.
    ///
    /// * `max-instances`: This attribute is no longer supported. The returned
    /// value does not reflect your actual vCPU limit for running On-Demand
    /// Instances.
    /// For more information, see [On-Demand Instance
    /// Limits](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-on-demand-instances.html#ec2-on-demand-instances-limits) in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    ///
    /// * `max-elastic-ips`: The maximum number of Elastic IP addresses that you can
    ///   allocate.
    ///
    /// * `supported-platforms`: This attribute is deprecated.
    ///
    /// * `vpc-max-elastic-ips`: The maximum number of Elastic IP addresses that you
    ///   can allocate.
    ///
    /// * `vpc-max-security-groups-per-interface`: The maximum number of security
    ///   groups
    /// that you can assign to a network interface.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures, might vary. Applications should not assume the elements appear
    /// in a
    /// particular order.
    pub fn describeAccountAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_account_attributes.DescribeAccountAttributesInput, options: CallOptions) !describe_account_attributes.DescribeAccountAttributesOutput {
        return describe_account_attributes.execute(self, allocator, input, options);
    }

    /// Describes an Elastic IP address transfer. For more information, see
    /// [Transfer Elastic IP
    /// addresses](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-eips.html#transfer-EIPs-intro) in the *Amazon VPC User Guide*.
    ///
    /// When you transfer an Elastic IP address, there is a two-step handshake
    /// between the source and transfer Amazon Web Services accounts. When the
    /// source account starts the transfer,
    /// the transfer account has seven days to accept the Elastic IP address
    /// transfer. During those seven days, the source account can view the
    /// pending transfer by using this action. After seven days, the
    /// transfer expires and ownership of the Elastic IP
    /// address returns to the source
    /// account. Accepted transfers are visible to the source account for 14 days
    /// after the transfers have been accepted.
    pub fn describeAddressTransfers(self: *Self, allocator: std.mem.Allocator, input: describe_address_transfers.DescribeAddressTransfersInput, options: CallOptions) !describe_address_transfers.DescribeAddressTransfersOutput {
        return describe_address_transfers.execute(self, allocator, input, options);
    }

    /// Describes the specified Elastic IP addresses or all of your Elastic IP
    /// addresses.
    pub fn describeAddresses(self: *Self, allocator: std.mem.Allocator, input: describe_addresses.DescribeAddressesInput, options: CallOptions) !describe_addresses.DescribeAddressesOutput {
        return describe_addresses.execute(self, allocator, input, options);
    }

    /// Describes the attributes of the specified Elastic IP addresses. For
    /// requirements, see [Using reverse DNS for email
    /// applications](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#Using_Elastic_Addressing_Reverse_DNS).
    pub fn describeAddressesAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_addresses_attribute.DescribeAddressesAttributeInput, options: CallOptions) !describe_addresses_attribute.DescribeAddressesAttributeOutput {
        return describe_addresses_attribute.execute(self, allocator, input, options);
    }

    /// Describes the longer ID format settings for all resource types in a specific
    /// Region. This request is useful for performing a quick audit to determine
    /// whether a
    /// specific Region is fully opted in for longer IDs (17-character IDs).
    ///
    /// This request only returns information about resource types that support
    /// longer IDs.
    ///
    /// The following resource types support longer IDs: `bundle` |
    /// `conversion-task` | `customer-gateway` | `dhcp-options` |
    /// `elastic-ip-allocation` | `elastic-ip-association` |
    /// `export-task` | `flow-log` | `image` |
    /// `import-task` | `instance` | `internet-gateway` |
    /// `network-acl` | `network-acl-association` |
    /// `network-interface` | `network-interface-attachment` |
    /// `prefix-list` | `reservation` | `route-table` |
    /// `route-table-association` | `security-group` |
    /// `snapshot` | `subnet` |
    /// `subnet-cidr-block-association` | `volume` | `vpc` |
    /// `vpc-cidr-block-association` | `vpc-endpoint` |
    /// `vpc-peering-connection` | `vpn-connection` | `vpn-gateway`.
    pub fn describeAggregateIdFormat(self: *Self, allocator: std.mem.Allocator, input: describe_aggregate_id_format.DescribeAggregateIdFormatInput, options: CallOptions) !describe_aggregate_id_format.DescribeAggregateIdFormatOutput {
        return describe_aggregate_id_format.execute(self, allocator, input, options);
    }

    /// Describes the Availability Zones, Local Zones, and Wavelength Zones that are
    /// available to
    /// you.
    ///
    /// For more information about Availability Zones, Local Zones, and Wavelength
    /// Zones, see
    /// [Regions and
    /// zones](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-regions-availability-zones.html)
    /// in the *Amazon EC2 User Guide*.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures, might vary. Applications should not assume the elements appear
    /// in a
    /// particular order.
    pub fn describeAvailabilityZones(self: *Self, allocator: std.mem.Allocator, input: describe_availability_zones.DescribeAvailabilityZonesInput, options: CallOptions) !describe_availability_zones.DescribeAvailabilityZonesOutput {
        return describe_availability_zones.execute(self, allocator, input, options);
    }

    /// Describes the current Infrastructure Performance metric subscriptions.
    pub fn describeAwsNetworkPerformanceMetricSubscriptions(self: *Self, allocator: std.mem.Allocator, input: describe_aws_network_performance_metric_subscriptions.DescribeAwsNetworkPerformanceMetricSubscriptionsInput, options: CallOptions) !describe_aws_network_performance_metric_subscriptions.DescribeAwsNetworkPerformanceMetricSubscriptionsOutput {
        return describe_aws_network_performance_metric_subscriptions.execute(self, allocator, input, options);
    }

    /// Describes the specified bundle tasks or all of your bundle tasks.
    ///
    /// Completed bundle tasks are listed for only a limited time. If your bundle
    /// task is no
    /// longer in the list, you can still register an AMI from it. Just use
    /// `RegisterImage` with the Amazon S3 bucket name and image manifest name you
    /// provided
    /// to the bundle task.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures,
    /// might vary. Applications should not assume the elements appear in a
    /// particular order.
    pub fn describeBundleTasks(self: *Self, allocator: std.mem.Allocator, input: describe_bundle_tasks.DescribeBundleTasksInput, options: CallOptions) !describe_bundle_tasks.DescribeBundleTasksOutput {
        return describe_bundle_tasks.execute(self, allocator, input, options);
    }

    /// Describes the IP address ranges that were provisioned for use with Amazon
    /// Web Services resources
    /// through through bring your own IP addresses (BYOIP).
    pub fn describeByoipCidrs(self: *Self, allocator: std.mem.Allocator, input: describe_byoip_cidrs.DescribeByoipCidrsInput, options: CallOptions) !describe_byoip_cidrs.DescribeByoipCidrsOutput {
        return describe_byoip_cidrs.execute(self, allocator, input, options);
    }

    /// Describes the events for the specified Capacity Block extension during the
    /// specified
    /// time.
    pub fn describeCapacityBlockExtensionHistory(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_block_extension_history.DescribeCapacityBlockExtensionHistoryInput, options: CallOptions) !describe_capacity_block_extension_history.DescribeCapacityBlockExtensionHistoryOutput {
        return describe_capacity_block_extension_history.execute(self, allocator, input, options);
    }

    /// Describes Capacity Block extension offerings available for purchase in the
    /// Amazon Web Services
    /// Region that you're currently using.
    pub fn describeCapacityBlockExtensionOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_block_extension_offerings.DescribeCapacityBlockExtensionOfferingsInput, options: CallOptions) !describe_capacity_block_extension_offerings.DescribeCapacityBlockExtensionOfferingsOutput {
        return describe_capacity_block_extension_offerings.execute(self, allocator, input, options);
    }

    /// Describes Capacity Block offerings available for purchase in the Amazon Web
    /// Services Region that you're currently using. With Capacity Blocks, you can
    /// purchase a specific GPU instance type or EC2 UltraServer for a period of
    /// time.
    ///
    /// To search for an available Capacity Block offering, you specify a
    /// reservation duration
    /// and instance count.
    pub fn describeCapacityBlockOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_block_offerings.DescribeCapacityBlockOfferingsInput, options: CallOptions) !describe_capacity_block_offerings.DescribeCapacityBlockOfferingsOutput {
        return describe_capacity_block_offerings.execute(self, allocator, input, options);
    }

    /// Describes the availability of capacity for the specified Capacity blocks, or
    /// all of your Capacity Blocks.
    pub fn describeCapacityBlockStatus(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_block_status.DescribeCapacityBlockStatusInput, options: CallOptions) !describe_capacity_block_status.DescribeCapacityBlockStatusOutput {
        return describe_capacity_block_status.execute(self, allocator, input, options);
    }

    /// Describes details about Capacity Blocks in the Amazon Web Services Region
    /// that you're currently using.
    pub fn describeCapacityBlocks(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_blocks.DescribeCapacityBlocksInput, options: CallOptions) !describe_capacity_blocks.DescribeCapacityBlocksOutput {
        return describe_capacity_blocks.execute(self, allocator, input, options);
    }

    /// Describes one or more Capacity Manager data export configurations. Returns
    /// information about export settings, delivery status, and recent export
    /// activity.
    pub fn describeCapacityManagerDataExports(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_manager_data_exports.DescribeCapacityManagerDataExportsInput, options: CallOptions) !describe_capacity_manager_data_exports.DescribeCapacityManagerDataExportsOutput {
        return describe_capacity_manager_data_exports.execute(self, allocator, input, options);
    }

    /// Describes a request to assign the billing of the unused capacity of a
    /// Capacity
    /// Reservation. For more information, see [ Billing assignment for shared
    /// Amazon EC2 Capacity
    /// Reservations](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/transfer-billing.html).
    pub fn describeCapacityReservationBillingRequests(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_reservation_billing_requests.DescribeCapacityReservationBillingRequestsInput, options: CallOptions) !describe_capacity_reservation_billing_requests.DescribeCapacityReservationBillingRequestsOutput {
        return describe_capacity_reservation_billing_requests.execute(self, allocator, input, options);
    }

    /// Describes one or more Capacity Reservation Fleets.
    pub fn describeCapacityReservationFleets(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_reservation_fleets.DescribeCapacityReservationFleetsInput, options: CallOptions) !describe_capacity_reservation_fleets.DescribeCapacityReservationFleetsOutput {
        return describe_capacity_reservation_fleets.execute(self, allocator, input, options);
    }

    /// Describes a tree-based hierarchy that represents the physical host placement
    /// of your
    /// pending or active Capacity Reservations within an Availability Zone or Local
    /// Zone. You
    /// can use this information to determine the relative proximity of your
    /// capacity within the
    /// Amazon Web Services network before it is launched and use this information
    /// to allocate capacity
    /// together to support your tightly coupled workloads.
    ///
    /// Capacity Reservation topology is supported for specific instance types only.
    /// For more
    /// information, see [Prerequisites
    /// for Amazon EC2 instance
    /// topology](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-topology-prerequisites.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// The Amazon EC2 API follows an eventual consistency model due to the
    /// distributed nature of the system supporting it. As a result, when you call
    /// the
    /// DescribeCapacityReservationTopology API command immediately after launching
    /// instances, the response might return a `null` value for
    /// `capacityBlockId` because the data might not have fully propagated
    /// across all subsystems. For more information, see [Eventual consistency in
    /// the
    /// Amazon EC2
    /// API](https://docs.aws.amazon.com/ec2/latest/devguide/eventual-consistency.html) in the *Amazon EC2 Developer
    /// Guide*.
    ///
    /// For more information, see [Amazon EC2
    /// topology](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-topology.html) in
    /// the *Amazon EC2 User Guide*.
    pub fn describeCapacityReservationTopology(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_reservation_topology.DescribeCapacityReservationTopologyInput, options: CallOptions) !describe_capacity_reservation_topology.DescribeCapacityReservationTopologyOutput {
        return describe_capacity_reservation_topology.execute(self, allocator, input, options);
    }

    /// Describes one or more of your Capacity Reservations. The results describe
    /// only the
    /// Capacity Reservations in the Amazon Web Services Region that you're
    /// currently
    /// using.
    pub fn describeCapacityReservations(self: *Self, allocator: std.mem.Allocator, input: describe_capacity_reservations.DescribeCapacityReservationsInput, options: CallOptions) !describe_capacity_reservations.DescribeCapacityReservationsOutput {
        return describe_capacity_reservations.execute(self, allocator, input, options);
    }

    /// Describes one or more of your carrier gateways.
    pub fn describeCarrierGateways(self: *Self, allocator: std.mem.Allocator, input: describe_carrier_gateways.DescribeCarrierGatewaysInput, options: CallOptions) !describe_carrier_gateways.DescribeCarrierGatewaysOutput {
        return describe_carrier_gateways.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Describes your linked EC2-Classic instances. This request only returns
    /// information about EC2-Classic instances linked to a VPC through ClassicLink.
    /// You cannot
    /// use this request to return information about other instances.
    pub fn describeClassicLinkInstances(self: *Self, allocator: std.mem.Allocator, input: describe_classic_link_instances.DescribeClassicLinkInstancesInput, options: CallOptions) !describe_classic_link_instances.DescribeClassicLinkInstancesOutput {
        return describe_classic_link_instances.execute(self, allocator, input, options);
    }

    /// Describes the authorization rules for a specified Client VPN endpoint.
    pub fn describeClientVpnAuthorizationRules(self: *Self, allocator: std.mem.Allocator, input: describe_client_vpn_authorization_rules.DescribeClientVpnAuthorizationRulesInput, options: CallOptions) !describe_client_vpn_authorization_rules.DescribeClientVpnAuthorizationRulesOutput {
        return describe_client_vpn_authorization_rules.execute(self, allocator, input, options);
    }

    /// Describes active client connections and connections that have been
    /// terminated within the last 60
    /// minutes for the specified Client VPN endpoint.
    pub fn describeClientVpnConnections(self: *Self, allocator: std.mem.Allocator, input: describe_client_vpn_connections.DescribeClientVpnConnectionsInput, options: CallOptions) !describe_client_vpn_connections.DescribeClientVpnConnectionsOutput {
        return describe_client_vpn_connections.execute(self, allocator, input, options);
    }

    /// Describes one or more Client VPN endpoints in the account.
    pub fn describeClientVpnEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_client_vpn_endpoints.DescribeClientVpnEndpointsInput, options: CallOptions) !describe_client_vpn_endpoints.DescribeClientVpnEndpointsOutput {
        return describe_client_vpn_endpoints.execute(self, allocator, input, options);
    }

    /// Describes the routes for the specified Client VPN endpoint.
    pub fn describeClientVpnRoutes(self: *Self, allocator: std.mem.Allocator, input: describe_client_vpn_routes.DescribeClientVpnRoutesInput, options: CallOptions) !describe_client_vpn_routes.DescribeClientVpnRoutesOutput {
        return describe_client_vpn_routes.execute(self, allocator, input, options);
    }

    /// Describes the target networks associated with the specified Client VPN
    /// endpoint.
    pub fn describeClientVpnTargetNetworks(self: *Self, allocator: std.mem.Allocator, input: describe_client_vpn_target_networks.DescribeClientVpnTargetNetworksInput, options: CallOptions) !describe_client_vpn_target_networks.DescribeClientVpnTargetNetworksOutput {
        return describe_client_vpn_target_networks.execute(self, allocator, input, options);
    }

    /// Describes the specified customer-owned address pools or all of your
    /// customer-owned address pools.
    pub fn describeCoipPools(self: *Self, allocator: std.mem.Allocator, input: describe_coip_pools.DescribeCoipPoolsInput, options: CallOptions) !describe_coip_pools.DescribeCoipPoolsOutput {
        return describe_coip_pools.execute(self, allocator, input, options);
    }

    /// Describes the specified conversion tasks or all your conversion tasks. For
    /// more information, see the
    /// [VM Import/Export User
    /// Guide](https://docs.aws.amazon.com/vm-import/latest/userguide/).
    ///
    /// For information about the import manifest referenced by this API action, see
    /// [VM Import
    /// Manifest](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/manifest.html).
    pub fn describeConversionTasks(self: *Self, allocator: std.mem.Allocator, input: describe_conversion_tasks.DescribeConversionTasksInput, options: CallOptions) !describe_conversion_tasks.DescribeConversionTasksOutput {
        return describe_conversion_tasks.execute(self, allocator, input, options);
    }

    /// Describes one or more of your VPN customer gateways.
    ///
    /// For more information, see [Amazon Web Services Site-to-Site
    /// VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html) in the
    /// *Amazon Web Services Site-to-Site VPN
    /// User Guide*.
    pub fn describeCustomerGateways(self: *Self, allocator: std.mem.Allocator, input: describe_customer_gateways.DescribeCustomerGatewaysInput, options: CallOptions) !describe_customer_gateways.DescribeCustomerGatewaysOutput {
        return describe_customer_gateways.execute(self, allocator, input, options);
    }

    /// Describes the metadata of an account status report, including the status of
    /// the
    /// report.
    ///
    /// To view the full report, download it from the Amazon S3 bucket where it was
    /// saved.
    /// Reports are accessible only when they have the `complete` status. Reports
    /// with other statuses (`running`, `cancelled`, or
    /// `error`) are not available in the S3 bucket. For more information about
    /// downloading objects from an S3 bucket, see [Downloading
    /// objects](https://docs.aws.amazon.com/AmazonS3/latest/userguide/download-objects.html) in
    /// the *Amazon Simple Storage Service User Guide*.
    ///
    /// For more information, see [Generating the account status report for
    /// declarative
    /// policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_declarative_status-report.html) in the
    /// *Amazon Web Services Organizations User Guide*.
    pub fn describeDeclarativePoliciesReports(self: *Self, allocator: std.mem.Allocator, input: describe_declarative_policies_reports.DescribeDeclarativePoliciesReportsInput, options: CallOptions) !describe_declarative_policies_reports.DescribeDeclarativePoliciesReportsOutput {
        return describe_declarative_policies_reports.execute(self, allocator, input, options);
    }

    /// Describes your DHCP option sets. The default is to describe all your DHCP
    /// option sets.
    /// Alternatively, you can specify specific DHCP option set IDs or filter the
    /// results to
    /// include only the DHCP option sets that match specific criteria.
    ///
    /// For more information, see [DHCP option
    /// sets](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_DHCP_Options.html) in the
    /// *Amazon VPC User Guide*.
    pub fn describeDhcpOptions(self: *Self, allocator: std.mem.Allocator, input: describe_dhcp_options.DescribeDhcpOptionsInput, options: CallOptions) !describe_dhcp_options.DescribeDhcpOptionsOutput {
        return describe_dhcp_options.execute(self, allocator, input, options);
    }

    /// Describes your egress-only internet gateways. The default is to describe all
    /// your egress-only internet gateways.
    /// Alternatively, you can specify specific egress-only internet gateway IDs or
    /// filter the results to
    /// include only the egress-only internet gateways that match specific criteria.
    pub fn describeEgressOnlyInternetGateways(self: *Self, allocator: std.mem.Allocator, input: describe_egress_only_internet_gateways.DescribeEgressOnlyInternetGatewaysInput, options: CallOptions) !describe_egress_only_internet_gateways.DescribeEgressOnlyInternetGatewaysOutput {
        return describe_egress_only_internet_gateways.execute(self, allocator, input, options);
    }

    /// Amazon Elastic Graphics reached end of life on January 8, 2024.
    ///
    /// Describes the Elastic Graphics accelerator associated with your instances.
    pub fn describeElasticGpus(self: *Self, allocator: std.mem.Allocator, input: describe_elastic_gpus.DescribeElasticGpusInput, options: CallOptions) !describe_elastic_gpus.DescribeElasticGpusOutput {
        return describe_elastic_gpus.execute(self, allocator, input, options);
    }

    /// Describes the specified export image tasks or all of your export image
    /// tasks.
    pub fn describeExportImageTasks(self: *Self, allocator: std.mem.Allocator, input: describe_export_image_tasks.DescribeExportImageTasksInput, options: CallOptions) !describe_export_image_tasks.DescribeExportImageTasksOutput {
        return describe_export_image_tasks.execute(self, allocator, input, options);
    }

    /// Describes the specified export instance tasks or all of your export instance
    /// tasks.
    pub fn describeExportTasks(self: *Self, allocator: std.mem.Allocator, input: describe_export_tasks.DescribeExportTasksInput, options: CallOptions) !describe_export_tasks.DescribeExportTasksOutput {
        return describe_export_tasks.execute(self, allocator, input, options);
    }

    /// Describe details for Windows AMIs that are configured for Windows fast
    /// launch.
    pub fn describeFastLaunchImages(self: *Self, allocator: std.mem.Allocator, input: describe_fast_launch_images.DescribeFastLaunchImagesInput, options: CallOptions) !describe_fast_launch_images.DescribeFastLaunchImagesOutput {
        return describe_fast_launch_images.execute(self, allocator, input, options);
    }

    /// Describes the state of fast snapshot restores for your snapshots.
    pub fn describeFastSnapshotRestores(self: *Self, allocator: std.mem.Allocator, input: describe_fast_snapshot_restores.DescribeFastSnapshotRestoresInput, options: CallOptions) !describe_fast_snapshot_restores.DescribeFastSnapshotRestoresOutput {
        return describe_fast_snapshot_restores.execute(self, allocator, input, options);
    }

    /// Describes the events for the specified EC2 Fleet during the specified time.
    ///
    /// EC2 Fleet events are delayed by up to 30 seconds before they can be
    /// described. This ensures
    /// that you can query by the last evaluated time and not miss a recorded event.
    /// EC2 Fleet events
    /// are available for 48 hours.
    ///
    /// For more information, see [Monitor fleet events using Amazon
    /// EventBridge](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/fleet-monitor.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn describeFleetHistory(self: *Self, allocator: std.mem.Allocator, input: describe_fleet_history.DescribeFleetHistoryInput, options: CallOptions) !describe_fleet_history.DescribeFleetHistoryOutput {
        return describe_fleet_history.execute(self, allocator, input, options);
    }

    /// Describes the running instances for the specified EC2 Fleet.
    ///
    /// Currently, `DescribeFleetInstances` does not support fleets of type
    /// `instant`. Instead, use `DescribeFleets`, specifying the
    /// `instant` fleet ID in the request.
    ///
    /// For more information, see [Describe your
    /// EC2
    /// Fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/manage-ec2-fleet.html#monitor-ec2-fleet) in the *Amazon EC2 User Guide*.
    pub fn describeFleetInstances(self: *Self, allocator: std.mem.Allocator, input: describe_fleet_instances.DescribeFleetInstancesInput, options: CallOptions) !describe_fleet_instances.DescribeFleetInstancesOutput {
        return describe_fleet_instances.execute(self, allocator, input, options);
    }

    /// Describes the specified EC2 Fleet or all of your EC2 Fleets.
    ///
    /// If a fleet is of type `instant`, you must specify the fleet ID in the
    /// request, otherwise the fleet does not appear in the response.
    ///
    /// For more information, see [Describe your
    /// EC2
    /// Fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/manage-ec2-fleet.html#monitor-ec2-fleet) in the *Amazon EC2 User Guide*.
    pub fn describeFleets(self: *Self, allocator: std.mem.Allocator, input: describe_fleets.DescribeFleetsInput, options: CallOptions) !describe_fleets.DescribeFleetsOutput {
        return describe_fleets.execute(self, allocator, input, options);
    }

    /// Describes one or more flow logs.
    ///
    /// To view the published flow log records, you must view the log destination.
    /// For example,
    /// the CloudWatch Logs log group, the Amazon S3 bucket, or the Kinesis Data
    /// Firehose delivery stream.
    pub fn describeFlowLogs(self: *Self, allocator: std.mem.Allocator, input: describe_flow_logs.DescribeFlowLogsInput, options: CallOptions) !describe_flow_logs.DescribeFlowLogsOutput {
        return describe_flow_logs.execute(self, allocator, input, options);
    }

    /// Describes the specified attribute of the specified Amazon FPGA Image (AFI).
    pub fn describeFpgaImageAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_fpga_image_attribute.DescribeFpgaImageAttributeInput, options: CallOptions) !describe_fpga_image_attribute.DescribeFpgaImageAttributeOutput {
        return describe_fpga_image_attribute.execute(self, allocator, input, options);
    }

    /// Describes the Amazon FPGA Images (AFIs) available to you. These include
    /// public AFIs,
    /// private AFIs that you own, and AFIs owned by other Amazon Web Services
    /// accounts for which you have load
    /// permissions.
    pub fn describeFpgaImages(self: *Self, allocator: std.mem.Allocator, input: describe_fpga_images.DescribeFpgaImagesInput, options: CallOptions) !describe_fpga_images.DescribeFpgaImagesOutput {
        return describe_fpga_images.execute(self, allocator, input, options);
    }

    /// Describes the Dedicated Host reservations that are available to purchase.
    ///
    /// The results describe all of the Dedicated Host reservation offerings,
    /// including
    /// offerings that might not match the instance family and Region of your
    /// Dedicated Hosts.
    /// When purchasing an offering, ensure that the instance family and Region of
    /// the offering
    /// matches that of the Dedicated Hosts with which it is to be associated. For
    /// more
    /// information about supported instance types, see [Dedicated
    /// Hosts](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-overview.html)
    /// in the *Amazon EC2 User Guide*.
    pub fn describeHostReservationOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_host_reservation_offerings.DescribeHostReservationOfferingsInput, options: CallOptions) !describe_host_reservation_offerings.DescribeHostReservationOfferingsOutput {
        return describe_host_reservation_offerings.execute(self, allocator, input, options);
    }

    /// Describes reservations that are associated with Dedicated Hosts in your
    /// account.
    pub fn describeHostReservations(self: *Self, allocator: std.mem.Allocator, input: describe_host_reservations.DescribeHostReservationsInput, options: CallOptions) !describe_host_reservations.DescribeHostReservationsOutput {
        return describe_host_reservations.execute(self, allocator, input, options);
    }

    /// Describes the specified Dedicated Hosts or all your Dedicated Hosts.
    ///
    /// The results describe only the Dedicated Hosts in the Region you're currently
    /// using.
    /// All listed instances consume capacity on your Dedicated Host. Dedicated
    /// Hosts that have
    /// recently been released are listed with the state `released`.
    pub fn describeHosts(self: *Self, allocator: std.mem.Allocator, input: describe_hosts.DescribeHostsInput, options: CallOptions) !describe_hosts.DescribeHostsOutput {
        return describe_hosts.execute(self, allocator, input, options);
    }

    /// Describes your IAM instance profile associations.
    pub fn describeIamInstanceProfileAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_iam_instance_profile_associations.DescribeIamInstanceProfileAssociationsInput, options: CallOptions) !describe_iam_instance_profile_associations.DescribeIamInstanceProfileAssociationsOutput {
        return describe_iam_instance_profile_associations.execute(self, allocator, input, options);
    }

    /// Describes the ID format settings for your resources on a per-Region basis,
    /// for example, to view which resource types are enabled for longer IDs. This
    /// request only returns information about resource types whose ID formats can
    /// be modified; it does not return information about other resource types.
    ///
    /// The following resource types support longer IDs: `bundle` |
    /// `conversion-task` | `customer-gateway` | `dhcp-options` |
    /// `elastic-ip-allocation` | `elastic-ip-association` |
    /// `export-task` | `flow-log` | `image` |
    /// `import-task` | `instance` | `internet-gateway` |
    /// `network-acl` | `network-acl-association` |
    /// `network-interface` | `network-interface-attachment` |
    /// `prefix-list` | `reservation` | `route-table` |
    /// `route-table-association` | `security-group` |
    /// `snapshot` | `subnet` |
    /// `subnet-cidr-block-association` | `volume` | `vpc`
    /// | `vpc-cidr-block-association` | `vpc-endpoint` |
    /// `vpc-peering-connection` | `vpn-connection` | `vpn-gateway`.
    ///
    /// These settings apply to the IAM user who makes the request; they do not
    /// apply to the entire
    /// Amazon Web Services account. By default, an IAM user defaults to the same
    /// settings as the root user, unless
    /// they explicitly override the settings by running the ModifyIdFormat command.
    /// Resources
    /// created with longer IDs are visible to all IAM users, regardless of these
    /// settings and
    /// provided that they have permission to use the relevant `Describe` command
    /// for the
    /// resource type.
    pub fn describeIdFormat(self: *Self, allocator: std.mem.Allocator, input: describe_id_format.DescribeIdFormatInput, options: CallOptions) !describe_id_format.DescribeIdFormatOutput {
        return describe_id_format.execute(self, allocator, input, options);
    }

    /// Describes the ID format settings for resources for the specified IAM user,
    /// IAM role, or root
    /// user. For example, you can view the resource types that are enabled for
    /// longer IDs. This request only
    /// returns information about resource types whose ID formats can be modified;
    /// it does not return
    /// information about other resource types. For more information, see [Resource
    /// IDs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/resource-ids.html)
    /// in the *Amazon Elastic Compute Cloud User Guide*.
    ///
    /// The following resource types support longer IDs: `bundle` |
    /// `conversion-task` | `customer-gateway` | `dhcp-options` |
    /// `elastic-ip-allocation` | `elastic-ip-association` |
    /// `export-task` | `flow-log` | `image` |
    /// `import-task` | `instance` | `internet-gateway` |
    /// `network-acl` | `network-acl-association` |
    /// `network-interface` | `network-interface-attachment` |
    /// `prefix-list` | `reservation` | `route-table` |
    /// `route-table-association` | `security-group` |
    /// `snapshot` | `subnet` |
    /// `subnet-cidr-block-association` | `volume` | `vpc`
    /// | `vpc-cidr-block-association` | `vpc-endpoint` |
    /// `vpc-peering-connection` | `vpn-connection` | `vpn-gateway`.
    ///
    /// These settings apply to the principal specified in the request. They do not
    /// apply to the
    /// principal that makes the request.
    pub fn describeIdentityIdFormat(self: *Self, allocator: std.mem.Allocator, input: describe_identity_id_format.DescribeIdentityIdFormatInput, options: CallOptions) !describe_identity_id_format.DescribeIdentityIdFormatOutput {
        return describe_identity_id_format.execute(self, allocator, input, options);
    }

    /// Describes the specified attribute of the specified AMI. You can specify only
    /// one attribute
    /// at a time.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures,
    /// might vary. Applications should not assume the elements appear in a
    /// particular order.
    pub fn describeImageAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_image_attribute.DescribeImageAttributeInput, options: CallOptions) !describe_image_attribute.DescribeImageAttributeOutput {
        return describe_image_attribute.execute(self, allocator, input, options);
    }

    /// Describes your Amazon Web Services resources that are referencing the
    /// specified images.
    ///
    /// For more information, see [Identify your resources referencing
    /// specified
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-ami-references.html) in the *Amazon EC2 User Guide*.
    pub fn describeImageReferences(self: *Self, allocator: std.mem.Allocator, input: describe_image_references.DescribeImageReferencesInput, options: CallOptions) !describe_image_references.DescribeImageReferencesOutput {
        return describe_image_references.execute(self, allocator, input, options);
    }

    /// Describes the entries in image usage reports, showing how your images are
    /// used across
    /// other Amazon Web Services accounts.
    ///
    /// For more information, see [View your AMI
    /// usage](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/your-ec2-ami-usage.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn describeImageUsageReportEntries(self: *Self, allocator: std.mem.Allocator, input: describe_image_usage_report_entries.DescribeImageUsageReportEntriesInput, options: CallOptions) !describe_image_usage_report_entries.DescribeImageUsageReportEntriesOutput {
        return describe_image_usage_report_entries.execute(self, allocator, input, options);
    }

    /// Describes the configuration and status of image usage reports, filtered by
    /// report IDs or
    /// image IDs.
    ///
    /// For more information, see [View your AMI
    /// usage](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/your-ec2-ami-usage.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn describeImageUsageReports(self: *Self, allocator: std.mem.Allocator, input: describe_image_usage_reports.DescribeImageUsageReportsInput, options: CallOptions) !describe_image_usage_reports.DescribeImageUsageReportsOutput {
        return describe_image_usage_reports.execute(self, allocator, input, options);
    }

    /// Describes the specified images (AMIs, AKIs, and ARIs) available to you or
    /// all of the
    /// images available to you.
    ///
    /// The images available to you include public images, private images that you
    /// own, and
    /// private images owned by other Amazon Web Services accounts for which you
    /// have explicit launch
    /// permissions.
    ///
    /// Recently deregistered images appear in the returned results for a short
    /// interval and then
    /// return empty results. After all instances that reference a deregistered AMI
    /// are terminated,
    /// specifying the ID of the image will eventually return an error indicating
    /// that the AMI ID
    /// cannot be found.
    ///
    /// When Allowed AMIs is set to `enabled`, only allowed images are returned in
    /// the
    /// results, with the `imageAllowed` field set to `true` for each image. In
    /// `audit-mode`, the `imageAllowed` field is set to `true` for
    /// images that meet the account's Allowed AMIs criteria, and `false` for images
    /// that
    /// don't meet the criteria. For more information, see [Allowed
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html).
    ///
    /// The Amazon EC2 API follows an eventual consistency model. This means that
    /// the result of an API
    /// command you run that creates or modifies resources might not be immediately
    /// available to all
    /// subsequent commands you run. For guidance on how to manage eventual
    /// consistency, see [Eventual
    /// consistency in the Amazon EC2
    /// API](https://docs.aws.amazon.com/ec2/latest/devguide/eventual-consistency.html) in the *Amazon EC2 Developer
    /// Guide*.
    ///
    /// We strongly recommend using only paginated requests. Unpaginated requests
    /// are
    /// susceptible to throttling and timeouts.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures,
    /// might vary. Applications should not assume the elements appear in a
    /// particular order.
    pub fn describeImages(self: *Self, allocator: std.mem.Allocator, input: describe_images.DescribeImagesInput, options: CallOptions) !describe_images.DescribeImagesOutput {
        return describe_images.execute(self, allocator, input, options);
    }

    /// Displays details about an import virtual machine or import snapshot tasks
    /// that are already created.
    pub fn describeImportImageTasks(self: *Self, allocator: std.mem.Allocator, input: describe_import_image_tasks.DescribeImportImageTasksInput, options: CallOptions) !describe_import_image_tasks.DescribeImportImageTasksOutput {
        return describe_import_image_tasks.execute(self, allocator, input, options);
    }

    /// Describes your import snapshot tasks.
    pub fn describeImportSnapshotTasks(self: *Self, allocator: std.mem.Allocator, input: describe_import_snapshot_tasks.DescribeImportSnapshotTasksInput, options: CallOptions) !describe_import_snapshot_tasks.DescribeImportSnapshotTasksOutput {
        return describe_import_snapshot_tasks.execute(self, allocator, input, options);
    }

    /// Describes the specified attribute of the specified instance. You can specify
    /// only one
    /// attribute at a time. Available attributes include SQL license exemption
    /// configuration
    /// for instances registered with the SQL LE service.
    pub fn describeInstanceAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_instance_attribute.DescribeInstanceAttributeInput, options: CallOptions) !describe_instance_attribute.DescribeInstanceAttributeOutput {
        return describe_instance_attribute.execute(self, allocator, input, options);
    }

    /// Describes the specified EC2 Instance Connect Endpoints or all EC2 Instance
    /// Connect Endpoints.
    pub fn describeInstanceConnectEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_instance_connect_endpoints.DescribeInstanceConnectEndpointsInput, options: CallOptions) !describe_instance_connect_endpoints.DescribeInstanceConnectEndpointsOutput {
        return describe_instance_connect_endpoints.execute(self, allocator, input, options);
    }

    /// Describes the credit option for CPU usage of the specified burstable
    /// performance
    /// instances. The credit options are `standard` and
    /// `unlimited`.
    ///
    /// If you do not specify an instance ID, Amazon EC2 returns burstable
    /// performance
    /// instances with the `unlimited` credit option, as well as instances that were
    /// previously configured as T2, T3, and T3a with the `unlimited` credit option.
    /// For example, if you resize a T2 instance, while it is configured as
    /// `unlimited`, to an M4 instance, Amazon EC2 returns the M4
    /// instance.
    ///
    /// If you specify one or more instance IDs, Amazon EC2 returns the credit
    /// option
    /// (`standard` or `unlimited`) of those instances. If you specify
    /// an instance ID that is not valid, such as an instance that is not a
    /// burstable
    /// performance instance, an error is returned.
    ///
    /// Recently terminated instances might appear in the returned results. This
    /// interval is
    /// usually less than one hour.
    ///
    /// If an Availability Zone is experiencing a service disruption and you specify
    /// instance
    /// IDs in the affected zone, or do not specify any instance IDs at all, the
    /// call fails. If
    /// you specify only instance IDs in an unaffected zone, the call works
    /// normally.
    ///
    /// For more information, see [Burstable
    /// performance
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html) in the *Amazon EC2 User Guide*.
    pub fn describeInstanceCreditSpecifications(self: *Self, allocator: std.mem.Allocator, input: describe_instance_credit_specifications.DescribeInstanceCreditSpecificationsInput, options: CallOptions) !describe_instance_credit_specifications.DescribeInstanceCreditSpecificationsOutput {
        return describe_instance_credit_specifications.execute(self, allocator, input, options);
    }

    /// Describes the tag keys that are registered to appear in scheduled event
    /// notifications
    /// for resources in the current Region.
    pub fn describeInstanceEventNotificationAttributes(self: *Self, allocator: std.mem.Allocator, input: describe_instance_event_notification_attributes.DescribeInstanceEventNotificationAttributesInput, options: CallOptions) !describe_instance_event_notification_attributes.DescribeInstanceEventNotificationAttributesOutput {
        return describe_instance_event_notification_attributes.execute(self, allocator, input, options);
    }

    /// Describes the specified event windows or all event windows.
    ///
    /// If you specify event window IDs, the output includes information for only
    /// the specified
    /// event windows. If you specify filters, the output includes information for
    /// only those event
    /// windows that meet the filter criteria. If you do not specify event windows
    /// IDs or filters,
    /// the output includes information for all event windows, which can affect
    /// performance. We
    /// recommend that you use pagination to ensure that the operation returns
    /// quickly and
    /// successfully.
    ///
    /// For more information, see [Define event windows for scheduled
    /// events](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/event-windows.html) in the *Amazon EC2 User Guide*.
    pub fn describeInstanceEventWindows(self: *Self, allocator: std.mem.Allocator, input: describe_instance_event_windows.DescribeInstanceEventWindowsInput, options: CallOptions) !describe_instance_event_windows.DescribeInstanceEventWindowsOutput {
        return describe_instance_event_windows.execute(self, allocator, input, options);
    }

    /// Describes the AMI that was used to launch an instance, even if the AMI is
    /// deprecated,
    /// deregistered, made private (no longer public or shared with your account),
    /// or not
    /// allowed.
    ///
    /// If you specify instance IDs, the output includes information for only the
    /// specified
    /// instances. If you specify filters, the output includes information for only
    /// those instances
    /// that meet the filter criteria. If you do not specify instance IDs or
    /// filters, the output
    /// includes information for all instances, which can affect performance.
    ///
    /// If you specify an instance ID that is not valid, an instance that doesn't
    /// exist, or an
    /// instance that you do not own, an error (`InvalidInstanceID.NotFound`) is
    /// returned.
    ///
    /// Recently terminated instances might appear in the returned results. This
    /// interval is
    /// usually less than one hour.
    ///
    /// In the rare case where an Availability Zone is experiencing a service
    /// disruption and you
    /// specify instance IDs that are in the affected Availability Zone, or do not
    /// specify any
    /// instance IDs at all, the call fails. If you specify only instance IDs that
    /// are in an
    /// unaffected Availability Zone, the call works normally.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures,
    /// might vary. Applications should not assume the elements appear in a
    /// particular order.
    pub fn describeInstanceImageMetadata(self: *Self, allocator: std.mem.Allocator, input: describe_instance_image_metadata.DescribeInstanceImageMetadataInput, options: CallOptions) !describe_instance_image_metadata.DescribeInstanceImageMetadataOutput {
        return describe_instance_image_metadata.execute(self, allocator, input, options);
    }

    /// Describes the historical SQL Server High Availability states for Amazon EC2
    /// instances that are enabled for Amazon EC2 High Availability for SQL Server
    /// monitoring.
    pub fn describeInstanceSqlHaHistoryStates(self: *Self, allocator: std.mem.Allocator, input: describe_instance_sql_ha_history_states.DescribeInstanceSqlHaHistoryStatesInput, options: CallOptions) !describe_instance_sql_ha_history_states.DescribeInstanceSqlHaHistoryStatesOutput {
        return describe_instance_sql_ha_history_states.execute(self, allocator, input, options);
    }

    /// Describes the SQL Server High Availability states for Amazon EC2 instances
    /// that are
    /// enabled for Amazon EC2 High Availability for SQL Server monitoring.
    pub fn describeInstanceSqlHaStates(self: *Self, allocator: std.mem.Allocator, input: describe_instance_sql_ha_states.DescribeInstanceSqlHaStatesInput, options: CallOptions) !describe_instance_sql_ha_states.DescribeInstanceSqlHaStatesOutput {
        return describe_instance_sql_ha_states.execute(self, allocator, input, options);
    }

    /// Describes the status of the specified instances or all of your instances. By
    /// default,
    /// only running instances are described, unless you specifically indicate to
    /// return the
    /// status of all instances.
    ///
    /// Instance status includes the following components:
    ///
    /// * **Status checks** - Amazon EC2 performs status
    /// checks on running EC2 instances to identify hardware and software issues.
    /// For
    /// more information, see [Status checks for your
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitoring-system-instance-status-check.html) and [Troubleshoot
    /// instances with failed status
    /// checks](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstances.html) in the *Amazon EC2 User
    /// Guide*.
    ///
    /// * **Scheduled events** - Amazon EC2 can schedule
    /// events (such as reboot, stop, or terminate) for your instances related to
    /// hardware issues, software updates, or system maintenance. For more
    /// information,
    /// see [Scheduled events for your
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitoring-instances-status-check_sched.html) in the *Amazon EC2 User
    /// Guide*.
    ///
    /// * **Instance state** - You can manage your instances
    /// from the moment you launch them through their termination. For more
    /// information,
    /// see [Instance
    /// lifecycle](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-lifecycle.html) in the *Amazon EC2 User Guide*.
    ///
    /// The Amazon EC2 API follows an eventual consistency model. This means that
    /// the result of an
    /// API command you run that creates or modifies resources might not be
    /// immediately
    /// available to all subsequent commands you run. For guidance on how to manage
    /// eventual
    /// consistency, see [Eventual consistency in the
    /// Amazon EC2
    /// API](https://docs.aws.amazon.com/ec2/latest/devguide/eventual-consistency.html) in the *Amazon EC2 Developer
    /// Guide*.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures, might vary. Applications should not assume the elements appear
    /// in a
    /// particular order.
    pub fn describeInstanceStatus(self: *Self, allocator: std.mem.Allocator, input: describe_instance_status.DescribeInstanceStatusInput, options: CallOptions) !describe_instance_status.DescribeInstanceStatusOutput {
        return describe_instance_status.execute(self, allocator, input, options);
    }

    /// Describes a tree-based hierarchy that represents the physical host placement
    /// of your
    /// EC2 instances within an Availability Zone or Local Zone. You can use this
    /// information to
    /// determine the relative proximity of your EC2 instances within the Amazon Web
    /// Services network to
    /// support your tightly coupled workloads.
    ///
    /// Instance topology is supported for specific instance types only. For more
    /// information,
    /// see [Prerequisites
    /// for Amazon EC2 instance
    /// topology](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-topology-prerequisites.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// The Amazon EC2 API follows an eventual consistency model due to the
    /// distributed nature of the system supporting it. As a result, when you call
    /// the
    /// DescribeInstanceTopology API command immediately after launching instances,
    /// the
    /// response might return a `null` value for `capacityBlockId`
    /// because the data might not have fully propagated across all subsystems. For
    /// more
    /// information, see [Eventual consistency in the
    /// Amazon EC2
    /// API](https://docs.aws.amazon.com/ec2/latest/devguide/eventual-consistency.html) in the *Amazon EC2 Developer
    /// Guide*.
    ///
    /// For more information, see [Amazon EC2
    /// topology](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-topology.html) in
    /// the *Amazon EC2 User Guide*.
    pub fn describeInstanceTopology(self: *Self, allocator: std.mem.Allocator, input: describe_instance_topology.DescribeInstanceTopologyInput, options: CallOptions) !describe_instance_topology.DescribeInstanceTopologyOutput {
        return describe_instance_topology.execute(self, allocator, input, options);
    }

    /// Lists the instance types that are offered for the specified location. If no
    /// location is
    /// specified, the default is to list the instance types that are offered in the
    /// current
    /// Region.
    pub fn describeInstanceTypeOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_instance_type_offerings.DescribeInstanceTypeOfferingsInput, options: CallOptions) !describe_instance_type_offerings.DescribeInstanceTypeOfferingsOutput {
        return describe_instance_type_offerings.execute(self, allocator, input, options);
    }

    /// Describes the specified instance types. By default, all instance types for
    /// the current
    /// Region are described. Alternatively, you can filter the results.
    pub fn describeInstanceTypes(self: *Self, allocator: std.mem.Allocator, input: describe_instance_types.DescribeInstanceTypesInput, options: CallOptions) !describe_instance_types.DescribeInstanceTypesOutput {
        return describe_instance_types.execute(self, allocator, input, options);
    }

    /// Describes the specified instances or all instances.
    ///
    /// If you specify instance IDs, the output includes information for only the
    /// specified
    /// instances. If you specify filters, the output includes information for only
    /// those
    /// instances that meet the filter criteria. If you do not specify instance IDs
    /// or filters,
    /// the output includes information for all instances, which can affect
    /// performance. We
    /// recommend that you use pagination to ensure that the operation returns
    /// quickly and
    /// successfully.
    ///
    /// The response includes SQL license exemption status information for instances
    /// registered
    /// with the SQL LE service, providing visibility into license exemption
    /// configuration and status.
    ///
    /// If you specify an instance ID that is not valid, an error is returned. If
    /// you specify
    /// an instance that you do not own, it is not included in the output.
    ///
    /// Recently terminated instances might appear in the returned results. This
    /// interval is
    /// usually less than one hour.
    ///
    /// If you describe instances in the rare case where an Availability Zone is
    /// experiencing
    /// a service disruption and you specify instance IDs that are in the affected
    /// zone, or do
    /// not specify any instance IDs at all, the call fails. If you describe
    /// instances and
    /// specify only instance IDs that are in an unaffected zone, the call works
    /// normally.
    ///
    /// The Amazon EC2 API follows an eventual consistency model. This means that
    /// the result of an
    /// API command you run that creates or modifies resources might not be
    /// immediately
    /// available to all subsequent commands you run. For guidance on how to manage
    /// eventual
    /// consistency, see [Eventual consistency in the
    /// Amazon EC2
    /// API](https://docs.aws.amazon.com/ec2/latest/devguide/eventual-consistency.html) in the *Amazon EC2 Developer
    /// Guide*.
    ///
    /// We strongly recommend using only paginated requests. Unpaginated requests
    /// are
    /// susceptible to throttling and timeouts.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures, might vary. Applications should not assume the elements appear
    /// in a
    /// particular order.
    pub fn describeInstances(self: *Self, allocator: std.mem.Allocator, input: describe_instances.DescribeInstancesInput, options: CallOptions) !describe_instances.DescribeInstancesOutput {
        return describe_instances.execute(self, allocator, input, options);
    }

    /// Describes your internet gateways. The default is to describe all your
    /// internet gateways.
    /// Alternatively, you can specify specific internet gateway IDs or filter the
    /// results to
    /// include only the internet gateways that match specific criteria.
    pub fn describeInternetGateways(self: *Self, allocator: std.mem.Allocator, input: describe_internet_gateways.DescribeInternetGatewaysInput, options: CallOptions) !describe_internet_gateways.DescribeInternetGatewaysOutput {
        return describe_internet_gateways.execute(self, allocator, input, options);
    }

    /// Describes your Autonomous System Numbers (ASNs), their provisioning
    /// statuses, and the BYOIP CIDRs with which they are associated. For more
    /// information, see [Tutorial: Bring your ASN to
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoasn.html) in
    /// the *Amazon VPC IPAM guide*.
    pub fn describeIpamByoasn(self: *Self, allocator: std.mem.Allocator, input: describe_ipam_byoasn.DescribeIpamByoasnInput, options: CallOptions) !describe_ipam_byoasn.DescribeIpamByoasnOutput {
        return describe_ipam_byoasn.execute(self, allocator, input, options);
    }

    /// Describe verification tokens.
    ///
    /// A verification token is an Amazon Web Services-generated random value that
    /// you can use to prove ownership of an external resource. For example, you can
    /// use a verification token to validate that you control a public IP address
    /// range when you bring an IP address range to Amazon Web Services (BYOIP).
    pub fn describeIpamExternalResourceVerificationTokens(self: *Self, allocator: std.mem.Allocator, input: describe_ipam_external_resource_verification_tokens.DescribeIpamExternalResourceVerificationTokensInput, options: CallOptions) !describe_ipam_external_resource_verification_tokens.DescribeIpamExternalResourceVerificationTokensOutput {
        return describe_ipam_external_resource_verification_tokens.execute(self, allocator, input, options);
    }

    /// Describes one or more IPAM policies.
    ///
    /// An IPAM policy is a set of rules that define how public IPv4 addresses from
    /// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
    /// Amazon Web Services service to IPAM pools that the service will use to get
    /// IP addresses. A single policy can have multiple rules and be applied to
    /// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
    /// then the services fallback to Amazon-provided IP addresses. A policy can be
    /// applied to an individual Amazon Web Services account or an entity within
    /// Amazon Web Services Organizations.
    pub fn describeIpamPolicies(self: *Self, allocator: std.mem.Allocator, input: describe_ipam_policies.DescribeIpamPoliciesInput, options: CallOptions) !describe_ipam_policies.DescribeIpamPoliciesOutput {
        return describe_ipam_policies.execute(self, allocator, input, options);
    }

    /// Get information about your IPAM pools.
    pub fn describeIpamPools(self: *Self, allocator: std.mem.Allocator, input: describe_ipam_pools.DescribeIpamPoolsInput, options: CallOptions) !describe_ipam_pools.DescribeIpamPoolsOutput {
        return describe_ipam_pools.execute(self, allocator, input, options);
    }

    /// Describes one or more IPAM prefix list resolver Targets. Use this operation
    /// to view the configuration and status of resolver targets.
    pub fn describeIpamPrefixListResolverTargets(self: *Self, allocator: std.mem.Allocator, input: describe_ipam_prefix_list_resolver_targets.DescribeIpamPrefixListResolverTargetsInput, options: CallOptions) !describe_ipam_prefix_list_resolver_targets.DescribeIpamPrefixListResolverTargetsOutput {
        return describe_ipam_prefix_list_resolver_targets.execute(self, allocator, input, options);
    }

    /// Describes one or more IPAM prefix list resolvers. Use this operation to view
    /// the configuration, status, and properties of your resolvers.
    pub fn describeIpamPrefixListResolvers(self: *Self, allocator: std.mem.Allocator, input: describe_ipam_prefix_list_resolvers.DescribeIpamPrefixListResolversInput, options: CallOptions) !describe_ipam_prefix_list_resolvers.DescribeIpamPrefixListResolversOutput {
        return describe_ipam_prefix_list_resolvers.execute(self, allocator, input, options);
    }

    /// Describes IPAM resource discoveries. A resource discovery is an IPAM
    /// component that enables IPAM to manage and monitor resources that belong to
    /// the owning account.
    pub fn describeIpamResourceDiscoveries(self: *Self, allocator: std.mem.Allocator, input: describe_ipam_resource_discoveries.DescribeIpamResourceDiscoveriesInput, options: CallOptions) !describe_ipam_resource_discoveries.DescribeIpamResourceDiscoveriesOutput {
        return describe_ipam_resource_discoveries.execute(self, allocator, input, options);
    }

    /// Describes resource discovery association with an Amazon VPC IPAM. An
    /// associated resource discovery is a resource discovery that has been
    /// associated with an IPAM..
    pub fn describeIpamResourceDiscoveryAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_ipam_resource_discovery_associations.DescribeIpamResourceDiscoveryAssociationsInput, options: CallOptions) !describe_ipam_resource_discovery_associations.DescribeIpamResourceDiscoveryAssociationsOutput {
        return describe_ipam_resource_discovery_associations.execute(self, allocator, input, options);
    }

    /// Get information about your IPAM scopes.
    pub fn describeIpamScopes(self: *Self, allocator: std.mem.Allocator, input: describe_ipam_scopes.DescribeIpamScopesInput, options: CallOptions) !describe_ipam_scopes.DescribeIpamScopesOutput {
        return describe_ipam_scopes.execute(self, allocator, input, options);
    }

    /// Get information about your IPAM pools.
    ///
    /// For more information, see [What is
    /// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    pub fn describeIpams(self: *Self, allocator: std.mem.Allocator, input: describe_ipams.DescribeIpamsInput, options: CallOptions) !describe_ipams.DescribeIpamsOutput {
        return describe_ipams.execute(self, allocator, input, options);
    }

    /// Describes your IPv6 address pools.
    pub fn describeIpv6Pools(self: *Self, allocator: std.mem.Allocator, input: describe_ipv_6_pools.DescribeIpv6PoolsInput, options: CallOptions) !describe_ipv_6_pools.DescribeIpv6PoolsOutput {
        return describe_ipv_6_pools.execute(self, allocator, input, options);
    }

    /// Describes the specified key pairs or all of your key pairs.
    ///
    /// For more information about key pairs, see [Amazon EC2 key
    /// pairs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html)
    /// in the *Amazon EC2 User Guide*.
    pub fn describeKeyPairs(self: *Self, allocator: std.mem.Allocator, input: describe_key_pairs.DescribeKeyPairsInput, options: CallOptions) !describe_key_pairs.DescribeKeyPairsOutput {
        return describe_key_pairs.execute(self, allocator, input, options);
    }

    /// Describes one or more versions of a specified launch template. You can
    /// describe all
    /// versions, individual versions, or a range of versions. You can also describe
    /// all the
    /// latest versions or all the default versions of all the launch templates in
    /// your
    /// account.
    pub fn describeLaunchTemplateVersions(self: *Self, allocator: std.mem.Allocator, input: describe_launch_template_versions.DescribeLaunchTemplateVersionsInput, options: CallOptions) !describe_launch_template_versions.DescribeLaunchTemplateVersionsOutput {
        return describe_launch_template_versions.execute(self, allocator, input, options);
    }

    /// Describes one or more launch templates.
    pub fn describeLaunchTemplates(self: *Self, allocator: std.mem.Allocator, input: describe_launch_templates.DescribeLaunchTemplatesInput, options: CallOptions) !describe_launch_templates.DescribeLaunchTemplatesOutput {
        return describe_launch_templates.execute(self, allocator, input, options);
    }

    /// Describes the associations between virtual interface groups and local
    /// gateway route tables.
    pub fn describeLocalGatewayRouteTableVirtualInterfaceGroupAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_local_gateway_route_table_virtual_interface_group_associations.DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociationsInput, options: CallOptions) !describe_local_gateway_route_table_virtual_interface_group_associations.DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociationsOutput {
        return describe_local_gateway_route_table_virtual_interface_group_associations.execute(self, allocator, input, options);
    }

    /// Describes the specified associations between VPCs and local gateway route
    /// tables.
    pub fn describeLocalGatewayRouteTableVpcAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_local_gateway_route_table_vpc_associations.DescribeLocalGatewayRouteTableVpcAssociationsInput, options: CallOptions) !describe_local_gateway_route_table_vpc_associations.DescribeLocalGatewayRouteTableVpcAssociationsOutput {
        return describe_local_gateway_route_table_vpc_associations.execute(self, allocator, input, options);
    }

    /// Describes one or more local gateway route tables. By default, all local
    /// gateway route tables are described.
    /// Alternatively, you can filter the results.
    pub fn describeLocalGatewayRouteTables(self: *Self, allocator: std.mem.Allocator, input: describe_local_gateway_route_tables.DescribeLocalGatewayRouteTablesInput, options: CallOptions) !describe_local_gateway_route_tables.DescribeLocalGatewayRouteTablesOutput {
        return describe_local_gateway_route_tables.execute(self, allocator, input, options);
    }

    /// Describes the specified local gateway virtual interface groups.
    pub fn describeLocalGatewayVirtualInterfaceGroups(self: *Self, allocator: std.mem.Allocator, input: describe_local_gateway_virtual_interface_groups.DescribeLocalGatewayVirtualInterfaceGroupsInput, options: CallOptions) !describe_local_gateway_virtual_interface_groups.DescribeLocalGatewayVirtualInterfaceGroupsOutput {
        return describe_local_gateway_virtual_interface_groups.execute(self, allocator, input, options);
    }

    /// Describes the specified local gateway virtual interfaces.
    pub fn describeLocalGatewayVirtualInterfaces(self: *Self, allocator: std.mem.Allocator, input: describe_local_gateway_virtual_interfaces.DescribeLocalGatewayVirtualInterfacesInput, options: CallOptions) !describe_local_gateway_virtual_interfaces.DescribeLocalGatewayVirtualInterfacesOutput {
        return describe_local_gateway_virtual_interfaces.execute(self, allocator, input, options);
    }

    /// Describes one or more local gateways. By default, all local gateways are
    /// described.
    /// Alternatively, you can filter the results.
    pub fn describeLocalGateways(self: *Self, allocator: std.mem.Allocator, input: describe_local_gateways.DescribeLocalGatewaysInput, options: CallOptions) !describe_local_gateways.DescribeLocalGatewaysOutput {
        return describe_local_gateways.execute(self, allocator, input, options);
    }

    /// Describes the lock status for a snapshot.
    pub fn describeLockedSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_locked_snapshots.DescribeLockedSnapshotsInput, options: CallOptions) !describe_locked_snapshots.DescribeLockedSnapshotsOutput {
        return describe_locked_snapshots.execute(self, allocator, input, options);
    }

    /// Describes the specified EC2 Mac Dedicated Host or all of your EC2 Mac
    /// Dedicated Hosts.
    pub fn describeMacHosts(self: *Self, allocator: std.mem.Allocator, input: describe_mac_hosts.DescribeMacHostsInput, options: CallOptions) !describe_mac_hosts.DescribeMacHostsOutput {
        return describe_mac_hosts.execute(self, allocator, input, options);
    }

    /// Describes a System Integrity Protection (SIP) modification task or volume
    /// ownership delegation
    /// task for an Amazon EC2 Mac instance. For more information, see [Configure
    /// SIP for Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/mac-sip-settings.html#mac-sip-configure) in the *Amazon EC2 User Guide*.
    pub fn describeMacModificationTasks(self: *Self, allocator: std.mem.Allocator, input: describe_mac_modification_tasks.DescribeMacModificationTasksInput, options: CallOptions) !describe_mac_modification_tasks.DescribeMacModificationTasksOutput {
        return describe_mac_modification_tasks.execute(self, allocator, input, options);
    }

    /// Describes your managed prefix lists and any Amazon Web Services-managed
    /// prefix lists.
    pub fn describeManagedPrefixLists(self: *Self, allocator: std.mem.Allocator, input: describe_managed_prefix_lists.DescribeManagedPrefixListsInput, options: CallOptions) !describe_managed_prefix_lists.DescribeManagedPrefixListsOutput {
        return describe_managed_prefix_lists.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Describes your Elastic IP addresses that are being moved from or being
    /// restored to the EC2-Classic platform.
    /// This request does not return information about any other Elastic IP
    /// addresses in your account.
    pub fn describeMovingAddresses(self: *Self, allocator: std.mem.Allocator, input: describe_moving_addresses.DescribeMovingAddressesInput, options: CallOptions) !describe_moving_addresses.DescribeMovingAddressesOutput {
        return describe_moving_addresses.execute(self, allocator, input, options);
    }

    /// Describes your NAT gateways. The default is to describe all your NAT
    /// gateways.
    /// Alternatively, you can specify specific NAT gateway IDs or filter the
    /// results to
    /// include only the NAT gateways that match specific criteria.
    pub fn describeNatGateways(self: *Self, allocator: std.mem.Allocator, input: describe_nat_gateways.DescribeNatGatewaysInput, options: CallOptions) !describe_nat_gateways.DescribeNatGatewaysOutput {
        return describe_nat_gateways.execute(self, allocator, input, options);
    }

    /// Describes your network ACLs. The default is to describe all your network
    /// ACLs.
    /// Alternatively, you can specify specific network ACL IDs or filter the
    /// results to
    /// include only the network ACLs that match specific criteria.
    ///
    /// For more information, see [Network
    /// ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) in the
    /// *Amazon VPC User Guide*.
    pub fn describeNetworkAcls(self: *Self, allocator: std.mem.Allocator, input: describe_network_acls.DescribeNetworkAclsInput, options: CallOptions) !describe_network_acls.DescribeNetworkAclsOutput {
        return describe_network_acls.execute(self, allocator, input, options);
    }

    /// Describes the specified Network Access Scope analyses.
    pub fn describeNetworkInsightsAccessScopeAnalyses(self: *Self, allocator: std.mem.Allocator, input: describe_network_insights_access_scope_analyses.DescribeNetworkInsightsAccessScopeAnalysesInput, options: CallOptions) !describe_network_insights_access_scope_analyses.DescribeNetworkInsightsAccessScopeAnalysesOutput {
        return describe_network_insights_access_scope_analyses.execute(self, allocator, input, options);
    }

    /// Describes the specified Network Access Scopes.
    pub fn describeNetworkInsightsAccessScopes(self: *Self, allocator: std.mem.Allocator, input: describe_network_insights_access_scopes.DescribeNetworkInsightsAccessScopesInput, options: CallOptions) !describe_network_insights_access_scopes.DescribeNetworkInsightsAccessScopesOutput {
        return describe_network_insights_access_scopes.execute(self, allocator, input, options);
    }

    /// Describes one or more of your network insights analyses.
    pub fn describeNetworkInsightsAnalyses(self: *Self, allocator: std.mem.Allocator, input: describe_network_insights_analyses.DescribeNetworkInsightsAnalysesInput, options: CallOptions) !describe_network_insights_analyses.DescribeNetworkInsightsAnalysesOutput {
        return describe_network_insights_analyses.execute(self, allocator, input, options);
    }

    /// Describes one or more of your paths.
    pub fn describeNetworkInsightsPaths(self: *Self, allocator: std.mem.Allocator, input: describe_network_insights_paths.DescribeNetworkInsightsPathsInput, options: CallOptions) !describe_network_insights_paths.DescribeNetworkInsightsPathsOutput {
        return describe_network_insights_paths.execute(self, allocator, input, options);
    }

    /// Describes a network interface attribute. You can specify only one attribute
    /// at a
    /// time.
    pub fn describeNetworkInterfaceAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_network_interface_attribute.DescribeNetworkInterfaceAttributeInput, options: CallOptions) !describe_network_interface_attribute.DescribeNetworkInterfaceAttributeOutput {
        return describe_network_interface_attribute.execute(self, allocator, input, options);
    }

    /// Describes the permissions for your network interfaces.
    pub fn describeNetworkInterfacePermissions(self: *Self, allocator: std.mem.Allocator, input: describe_network_interface_permissions.DescribeNetworkInterfacePermissionsInput, options: CallOptions) !describe_network_interface_permissions.DescribeNetworkInterfacePermissionsOutput {
        return describe_network_interface_permissions.execute(self, allocator, input, options);
    }

    /// Describes the specified network interfaces or all your network interfaces.
    ///
    /// If you have a large number of network interfaces, the operation fails unless
    /// you use
    /// pagination or one of the following filters: `group-id`,
    /// `mac-address`, `private-dns-name`,
    /// `private-ip-address`, `subnet-id`, or
    /// `vpc-id`.
    ///
    /// We strongly recommend using only paginated requests. Unpaginated requests
    /// are
    /// susceptible to throttling and timeouts.
    pub fn describeNetworkInterfaces(self: *Self, allocator: std.mem.Allocator, input: describe_network_interfaces.DescribeNetworkInterfacesInput, options: CallOptions) !describe_network_interfaces.DescribeNetworkInterfacesOutput {
        return describe_network_interfaces.execute(self, allocator, input, options);
    }

    /// Describes the Outposts link aggregation groups (LAGs).
    ///
    /// LAGs are only available for second-generation Outposts racks at this time.
    pub fn describeOutpostLags(self: *Self, allocator: std.mem.Allocator, input: describe_outpost_lags.DescribeOutpostLagsInput, options: CallOptions) !describe_outpost_lags.DescribeOutpostLagsOutput {
        return describe_outpost_lags.execute(self, allocator, input, options);
    }

    /// Describes the specified placement groups or all of your placement groups.
    ///
    /// To describe a specific placement group that is *shared* with
    /// your account, you must specify the ID of the placement group using the
    /// `GroupId` parameter. Specifying the name of a
    /// *shared* placement group using the `GroupNames`
    /// parameter will result in an error.
    ///
    /// For more information, see [Placement
    /// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn describePlacementGroups(self: *Self, allocator: std.mem.Allocator, input: describe_placement_groups.DescribePlacementGroupsInput, options: CallOptions) !describe_placement_groups.DescribePlacementGroupsOutput {
        return describe_placement_groups.execute(self, allocator, input, options);
    }

    /// Describes available Amazon Web Services services in a prefix list format,
    /// which includes the prefix list
    /// name and prefix list ID of the service and the IP address range for the
    /// service.
    pub fn describePrefixLists(self: *Self, allocator: std.mem.Allocator, input: describe_prefix_lists.DescribePrefixListsInput, options: CallOptions) !describe_prefix_lists.DescribePrefixListsOutput {
        return describe_prefix_lists.execute(self, allocator, input, options);
    }

    /// Describes the ID format settings for the root user and all IAM roles and IAM
    /// users
    /// that have explicitly specified a longer ID (17-character ID) preference.
    ///
    /// By default, all IAM roles and IAM users default to the same ID settings as
    /// the root user, unless they
    /// explicitly override the settings. This request is useful for identifying
    /// those IAM users and IAM roles
    /// that have overridden the default ID settings.
    ///
    /// The following resource types support longer IDs: `bundle` |
    /// `conversion-task` | `customer-gateway` | `dhcp-options` |
    /// `elastic-ip-allocation` | `elastic-ip-association` |
    /// `export-task` | `flow-log` | `image` |
    /// `import-task` | `instance` | `internet-gateway` |
    /// `network-acl` | `network-acl-association` |
    /// `network-interface` | `network-interface-attachment` |
    /// `prefix-list` | `reservation` | `route-table` |
    /// `route-table-association` | `security-group` |
    /// `snapshot` | `subnet` |
    /// `subnet-cidr-block-association` | `volume` | `vpc`
    /// | `vpc-cidr-block-association` | `vpc-endpoint` |
    /// `vpc-peering-connection` | `vpn-connection` | `vpn-gateway`.
    pub fn describePrincipalIdFormat(self: *Self, allocator: std.mem.Allocator, input: describe_principal_id_format.DescribePrincipalIdFormatInput, options: CallOptions) !describe_principal_id_format.DescribePrincipalIdFormatOutput {
        return describe_principal_id_format.execute(self, allocator, input, options);
    }

    /// Describes the specified IPv4 address pools.
    pub fn describePublicIpv4Pools(self: *Self, allocator: std.mem.Allocator, input: describe_public_ipv_4_pools.DescribePublicIpv4PoolsInput, options: CallOptions) !describe_public_ipv_4_pools.DescribePublicIpv4PoolsOutput {
        return describe_public_ipv_4_pools.execute(self, allocator, input, options);
    }

    /// Describes the Regions that are enabled for your account, or all Regions.
    ///
    /// For a list of the Regions supported by Amazon EC2, see [Amazon EC2 service
    /// endpoints](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-endpoints.html).
    ///
    /// For information about enabling and disabling Regions for your account, see
    /// [Specify which Amazon Web Services Regions
    /// your account can
    /// use](https://docs.aws.amazon.com/accounts/latest/reference/manage-acct-regions.html) in the *Amazon Web Services Account Management Reference Guide*.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures,
    /// might vary. Applications should not assume the elements appear in a
    /// particular order.
    pub fn describeRegions(self: *Self, allocator: std.mem.Allocator, input: describe_regions.DescribeRegionsInput, options: CallOptions) !describe_regions.DescribeRegionsOutput {
        return describe_regions.execute(self, allocator, input, options);
    }

    /// Describes a root volume replacement task. For more information, see
    /// [Replace a root
    /// volume](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/replace-root.html) in the *Amazon EC2 User Guide*.
    pub fn describeReplaceRootVolumeTasks(self: *Self, allocator: std.mem.Allocator, input: describe_replace_root_volume_tasks.DescribeReplaceRootVolumeTasksInput, options: CallOptions) !describe_replace_root_volume_tasks.DescribeReplaceRootVolumeTasksOutput {
        return describe_replace_root_volume_tasks.execute(self, allocator, input, options);
    }

    /// Describes one or more of the Reserved Instances that you purchased.
    ///
    /// For more information about Reserved Instances, see [Reserved
    /// Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts-on-demand-reserved-instances.html) in the *Amazon EC2 User Guide*.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures,
    /// might vary. Applications should not assume the elements appear in a
    /// particular order.
    pub fn describeReservedInstances(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_instances.DescribeReservedInstancesInput, options: CallOptions) !describe_reserved_instances.DescribeReservedInstancesOutput {
        return describe_reserved_instances.execute(self, allocator, input, options);
    }

    /// Describes your account's Reserved Instance listings in the Reserved Instance
    /// Marketplace.
    ///
    /// The Reserved Instance Marketplace matches sellers who want to resell
    /// Reserved Instance
    /// capacity that they no longer need with buyers who want to purchase
    /// additional capacity.
    /// Reserved Instances bought and sold through the Reserved Instance Marketplace
    /// work like any
    /// other Reserved Instances.
    ///
    /// As a seller, you choose to list some or all of your Reserved Instances, and
    /// you specify
    /// the upfront price to receive for them. Your Reserved Instances are then
    /// listed in the Reserved
    /// Instance Marketplace and are available for purchase.
    ///
    /// As a buyer, you specify the configuration of the Reserved Instance to
    /// purchase, and the
    /// Marketplace matches what you're searching for with what's available. The
    /// Marketplace first
    /// sells the lowest priced Reserved Instances to you, and continues to sell
    /// available Reserved
    /// Instance listings to you until your demand is met. You are charged based on
    /// the total price of
    /// all of the listings that you purchase.
    ///
    /// For more information, see [Sell in the Reserved Instance
    /// Marketplace](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-general.html) in the *Amazon EC2 User Guide*.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures,
    /// might vary. Applications should not assume the elements appear in a
    /// particular order.
    pub fn describeReservedInstancesListings(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_instances_listings.DescribeReservedInstancesListingsInput, options: CallOptions) !describe_reserved_instances_listings.DescribeReservedInstancesListingsOutput {
        return describe_reserved_instances_listings.execute(self, allocator, input, options);
    }

    /// Describes the modifications made to your Reserved Instances. If no parameter
    /// is specified,
    /// information about all your Reserved Instances modification requests is
    /// returned. If a
    /// modification ID is specified, only information about the specific
    /// modification is
    /// returned.
    ///
    /// For more information, see [Modify Reserved
    /// Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-modifying.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures,
    /// might vary. Applications should not assume the elements appear in a
    /// particular order.
    pub fn describeReservedInstancesModifications(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_instances_modifications.DescribeReservedInstancesModificationsInput, options: CallOptions) !describe_reserved_instances_modifications.DescribeReservedInstancesModificationsOutput {
        return describe_reserved_instances_modifications.execute(self, allocator, input, options);
    }

    /// Describes Reserved Instance offerings that are available for purchase. With
    /// Reserved
    /// Instances, you purchase the right to launch instances for a period of time.
    /// During that time
    /// period, you do not receive insufficient capacity errors, and you pay a lower
    /// usage rate than
    /// the rate charged for On-Demand instances for the actual time used.
    ///
    /// If you have listed your own Reserved Instances for sale in the Reserved
    /// Instance
    /// Marketplace, they will be excluded from these results. This is to ensure
    /// that you do not
    /// purchase your own Reserved Instances.
    ///
    /// For more information, see [Sell in the Reserved Instance
    /// Marketplace](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-general.html) in the *Amazon EC2 User Guide*.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures,
    /// might vary. Applications should not assume the elements appear in a
    /// particular order.
    pub fn describeReservedInstancesOfferings(self: *Self, allocator: std.mem.Allocator, input: describe_reserved_instances_offerings.DescribeReservedInstancesOfferingsInput, options: CallOptions) !describe_reserved_instances_offerings.DescribeReservedInstancesOfferingsOutput {
        return describe_reserved_instances_offerings.execute(self, allocator, input, options);
    }

    /// Describes one or more route server endpoints.
    ///
    /// A route server endpoint is an Amazon Web Services-managed component inside a
    /// subnet that facilitates [BGP (Border Gateway
    /// Protocol)](https://en.wikipedia.org/wiki/Border_Gateway_Protocol)
    /// connections between your route server and your BGP peers.
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn describeRouteServerEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_route_server_endpoints.DescribeRouteServerEndpointsInput, options: CallOptions) !describe_route_server_endpoints.DescribeRouteServerEndpointsOutput {
        return describe_route_server_endpoints.execute(self, allocator, input, options);
    }

    /// Describes one or more route server peers.
    ///
    /// A route server peer is a session between a route server endpoint and the
    /// device deployed in Amazon Web Services (such as a firewall appliance or
    /// other network security function running on an EC2 instance). The device must
    /// meet these requirements:
    ///
    /// * Have an elastic network interface in the VPC
    ///
    /// * Support BGP (Border Gateway Protocol)
    ///
    /// * Can initiate BGP sessions
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn describeRouteServerPeers(self: *Self, allocator: std.mem.Allocator, input: describe_route_server_peers.DescribeRouteServerPeersInput, options: CallOptions) !describe_route_server_peers.DescribeRouteServerPeersOutput {
        return describe_route_server_peers.execute(self, allocator, input, options);
    }

    /// Describes one or more route servers.
    ///
    /// Amazon VPC Route Server simplifies routing for traffic between workloads
    /// that are deployed within a VPC and its internet gateways. With this feature,
    /// VPC Route Server dynamically updates VPC and internet gateway route tables
    /// with your preferred IPv4 or IPv6 routes to achieve routing fault tolerance
    /// for those workloads. This enables you to automatically reroute traffic
    /// within a VPC, which increases the manageability of VPC routing and
    /// interoperability with third-party workloads.
    ///
    /// Route server supports the follow route table types:
    ///
    /// * VPC route tables not associated with subnets
    ///
    /// * Subnet route tables
    ///
    /// * Internet gateway route tables
    ///
    /// Route server does not support route tables associated with virtual private
    /// gateways. To propagate routes into a transit gateway route table, use
    /// [Transit Gateway
    /// Connect](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html).
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn describeRouteServers(self: *Self, allocator: std.mem.Allocator, input: describe_route_servers.DescribeRouteServersInput, options: CallOptions) !describe_route_servers.DescribeRouteServersOutput {
        return describe_route_servers.execute(self, allocator, input, options);
    }

    /// Describes your route tables. The default is to describe all your route
    /// tables.
    /// Alternatively, you can specify specific route table IDs or filter the
    /// results to
    /// include only the route tables that match specific criteria.
    ///
    /// Each subnet in your VPC must be associated with a route table. If a subnet
    /// is not explicitly associated with any route table, it is implicitly
    /// associated with the main route table. This command does not return the
    /// subnet ID for implicit associations.
    ///
    /// For more information, see [Route
    /// tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html) in the
    /// *Amazon VPC User Guide*.
    pub fn describeRouteTables(self: *Self, allocator: std.mem.Allocator, input: describe_route_tables.DescribeRouteTablesInput, options: CallOptions) !describe_route_tables.DescribeRouteTablesOutput {
        return describe_route_tables.execute(self, allocator, input, options);
    }

    /// Finds available schedules that meet the specified criteria.
    ///
    /// You can search for an available schedule no more than 3 months in advance.
    /// You must meet the minimum required duration of 1,200 hours per year. For
    /// example, the minimum daily schedule is 4 hours, the minimum weekly schedule
    /// is 24 hours, and the minimum monthly schedule is 100 hours.
    ///
    /// After you find a schedule that meets your needs, call
    /// PurchaseScheduledInstances
    /// to purchase Scheduled Instances with that schedule.
    pub fn describeScheduledInstanceAvailability(self: *Self, allocator: std.mem.Allocator, input: describe_scheduled_instance_availability.DescribeScheduledInstanceAvailabilityInput, options: CallOptions) !describe_scheduled_instance_availability.DescribeScheduledInstanceAvailabilityOutput {
        return describe_scheduled_instance_availability.execute(self, allocator, input, options);
    }

    /// Describes the specified Scheduled Instances or all your Scheduled Instances.
    pub fn describeScheduledInstances(self: *Self, allocator: std.mem.Allocator, input: describe_scheduled_instances.DescribeScheduledInstancesInput, options: CallOptions) !describe_scheduled_instances.DescribeScheduledInstancesOutput {
        return describe_scheduled_instances.execute(self, allocator, input, options);
    }

    /// Describes the VPCs on the other side of a VPC peering or Transit Gateway
    /// connection that are referencing the security groups you've specified in this
    /// request.
    pub fn describeSecurityGroupReferences(self: *Self, allocator: std.mem.Allocator, input: describe_security_group_references.DescribeSecurityGroupReferencesInput, options: CallOptions) !describe_security_group_references.DescribeSecurityGroupReferencesOutput {
        return describe_security_group_references.execute(self, allocator, input, options);
    }

    /// Describes one or more of your security group rules.
    pub fn describeSecurityGroupRules(self: *Self, allocator: std.mem.Allocator, input: describe_security_group_rules.DescribeSecurityGroupRulesInput, options: CallOptions) !describe_security_group_rules.DescribeSecurityGroupRulesOutput {
        return describe_security_group_rules.execute(self, allocator, input, options);
    }

    /// Describes security group VPC associations made with
    /// [AssociateSecurityGroupVpc](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AssociateSecurityGroupVpc.html).
    pub fn describeSecurityGroupVpcAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_security_group_vpc_associations.DescribeSecurityGroupVpcAssociationsInput, options: CallOptions) !describe_security_group_vpc_associations.DescribeSecurityGroupVpcAssociationsOutput {
        return describe_security_group_vpc_associations.execute(self, allocator, input, options);
    }

    /// Describes the specified security groups or all of your security groups.
    pub fn describeSecurityGroups(self: *Self, allocator: std.mem.Allocator, input: describe_security_groups.DescribeSecurityGroupsInput, options: CallOptions) !describe_security_groups.DescribeSecurityGroupsOutput {
        return describe_security_groups.execute(self, allocator, input, options);
    }

    /// Describes the Outpost service link virtual interfaces.
    pub fn describeServiceLinkVirtualInterfaces(self: *Self, allocator: std.mem.Allocator, input: describe_service_link_virtual_interfaces.DescribeServiceLinkVirtualInterfacesInput, options: CallOptions) !describe_service_link_virtual_interfaces.DescribeServiceLinkVirtualInterfacesOutput {
        return describe_service_link_virtual_interfaces.execute(self, allocator, input, options);
    }

    /// Describes the specified attribute of the specified snapshot. You can specify
    /// only one
    /// attribute at a time.
    ///
    /// For more information about EBS snapshots, see [Amazon EBS
    /// snapshots](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-snapshots.html) in the *Amazon EBS User Guide*.
    pub fn describeSnapshotAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_snapshot_attribute.DescribeSnapshotAttributeInput, options: CallOptions) !describe_snapshot_attribute.DescribeSnapshotAttributeOutput {
        return describe_snapshot_attribute.execute(self, allocator, input, options);
    }

    /// Describes the storage tier status of one or more Amazon EBS snapshots.
    pub fn describeSnapshotTierStatus(self: *Self, allocator: std.mem.Allocator, input: describe_snapshot_tier_status.DescribeSnapshotTierStatusInput, options: CallOptions) !describe_snapshot_tier_status.DescribeSnapshotTierStatusOutput {
        return describe_snapshot_tier_status.execute(self, allocator, input, options);
    }

    /// Describes the specified EBS snapshots available to you or all of the EBS
    /// snapshots
    /// available to you.
    ///
    /// The snapshots available to you include public snapshots, private snapshots
    /// that you own,
    /// and private snapshots owned by other Amazon Web Services accounts for which
    /// you have explicit create volume
    /// permissions.
    ///
    /// The create volume permissions fall into the following categories:
    ///
    /// * *public*: The owner of the snapshot granted create volume
    /// permissions for the snapshot to the `all` group. All Amazon Web Services
    /// accounts have create
    /// volume permissions for these snapshots.
    ///
    /// * *explicit*: The owner of the snapshot granted create volume
    /// permissions to a specific Amazon Web Services account.
    ///
    /// * *implicit*: An Amazon Web Services account has implicit create volume
    ///   permissions
    /// for all snapshots it owns.
    ///
    /// The list of snapshots returned can be filtered by specifying snapshot IDs,
    /// snapshot
    /// owners, or Amazon Web Services accounts with create volume permissions. If
    /// no options are specified,
    /// Amazon EC2 returns all snapshots for which you have create volume
    /// permissions.
    ///
    /// If you specify one or more snapshot IDs, only snapshots that have the
    /// specified IDs are
    /// returned. If you specify an invalid snapshot ID, an error is returned. If
    /// you specify a
    /// snapshot ID for which you do not have access, it is not included in the
    /// returned
    /// results.
    ///
    /// If you specify one or more snapshot owners using the `OwnerIds` option, only
    /// snapshots from the specified owners and for which you have access are
    /// returned. The results
    /// can include the Amazon Web Services account IDs of the specified owners,
    /// `amazon` for snapshots
    /// owned by Amazon, or `self` for snapshots that you own.
    ///
    /// If you specify a list of restorable users, only snapshots with create
    /// snapshot permissions
    /// for those users are returned. You can specify Amazon Web Services account
    /// IDs (if you own the snapshots),
    /// `self` for snapshots for which you own or have explicit permissions, or
    /// `all` for public snapshots.
    ///
    /// If you are describing a long list of snapshots, we recommend that you
    /// paginate the output to make the
    /// list more manageable. For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    ///
    /// For more information about EBS snapshots, see [Amazon EBS
    /// snapshots](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-snapshots.html) in the *Amazon EBS User Guide*.
    ///
    /// We strongly recommend using only paginated requests. Unpaginated requests
    /// are
    /// susceptible to throttling and timeouts.
    pub fn describeSnapshots(self: *Self, allocator: std.mem.Allocator, input: describe_snapshots.DescribeSnapshotsInput, options: CallOptions) !describe_snapshots.DescribeSnapshotsOutput {
        return describe_snapshots.execute(self, allocator, input, options);
    }

    /// Describes the data feed for Spot Instances. For more information, see [Spot
    /// Instance data
    /// feed](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-data-feeds.html) in the *Amazon EC2 User Guide*.
    pub fn describeSpotDatafeedSubscription(self: *Self, allocator: std.mem.Allocator, input: describe_spot_datafeed_subscription.DescribeSpotDatafeedSubscriptionInput, options: CallOptions) !describe_spot_datafeed_subscription.DescribeSpotDatafeedSubscriptionOutput {
        return describe_spot_datafeed_subscription.execute(self, allocator, input, options);
    }

    /// Describes the running instances for the specified Spot Fleet.
    pub fn describeSpotFleetInstances(self: *Self, allocator: std.mem.Allocator, input: describe_spot_fleet_instances.DescribeSpotFleetInstancesInput, options: CallOptions) !describe_spot_fleet_instances.DescribeSpotFleetInstancesOutput {
        return describe_spot_fleet_instances.execute(self, allocator, input, options);
    }

    /// Describes the events for the specified Spot Fleet request during the
    /// specified
    /// time.
    ///
    /// Spot Fleet events are delayed by up to 30 seconds before they can be
    /// described. This
    /// ensures that you can query by the last evaluated time and not miss a
    /// recorded event.
    /// Spot Fleet events are available for 48 hours.
    ///
    /// For more information, see [Monitor fleet events using Amazon
    /// EventBridge](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/fleet-monitor.html) in the *Amazon EC2 User Guide*.
    pub fn describeSpotFleetRequestHistory(self: *Self, allocator: std.mem.Allocator, input: describe_spot_fleet_request_history.DescribeSpotFleetRequestHistoryInput, options: CallOptions) !describe_spot_fleet_request_history.DescribeSpotFleetRequestHistoryOutput {
        return describe_spot_fleet_request_history.execute(self, allocator, input, options);
    }

    /// Describes your Spot Fleet requests.
    ///
    /// Spot Fleet requests are deleted 48 hours after they are canceled and their
    /// instances
    /// are terminated.
    pub fn describeSpotFleetRequests(self: *Self, allocator: std.mem.Allocator, input: describe_spot_fleet_requests.DescribeSpotFleetRequestsInput, options: CallOptions) !describe_spot_fleet_requests.DescribeSpotFleetRequestsOutput {
        return describe_spot_fleet_requests.execute(self, allocator, input, options);
    }

    /// Describes the specified Spot Instance requests.
    ///
    /// You can use `DescribeSpotInstanceRequests` to find a running Spot Instance
    /// by
    /// examining the response. If the status of the Spot Instance is `fulfilled`,
    /// the
    /// instance ID appears in the response and contains the identifier of the
    /// instance.
    /// Alternatively, you can use
    /// [DescribeInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeInstances)
    /// with a filter to look for instances where the instance lifecycle is
    /// `spot`.
    ///
    /// We recommend that you set `MaxResults` to a value between 5 and 1000 to
    /// limit the number of items returned. This paginates the output, which makes
    /// the list
    /// more manageable and returns the items faster. If the list of items exceeds
    /// your
    /// `MaxResults` value, then that number of items is returned along with a
    /// `NextToken` value that can be passed to a subsequent
    /// `DescribeSpotInstanceRequests` request to retrieve the remaining
    /// items.
    ///
    /// Spot Instance requests are deleted four hours after they are canceled and
    /// their instances are
    /// terminated.
    pub fn describeSpotInstanceRequests(self: *Self, allocator: std.mem.Allocator, input: describe_spot_instance_requests.DescribeSpotInstanceRequestsInput, options: CallOptions) !describe_spot_instance_requests.DescribeSpotInstanceRequestsOutput {
        return describe_spot_instance_requests.execute(self, allocator, input, options);
    }

    /// Describes the Spot price history. For more information, see [Spot Instance
    /// pricing
    /// history](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances-history.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// When you specify a start and end time, the operation returns the prices of
    /// the
    /// instance types within that time range. It also returns the last price change
    /// before the
    /// start time, which is the effective price as of the start time.
    pub fn describeSpotPriceHistory(self: *Self, allocator: std.mem.Allocator, input: describe_spot_price_history.DescribeSpotPriceHistoryInput, options: CallOptions) !describe_spot_price_history.DescribeSpotPriceHistoryOutput {
        return describe_spot_price_history.execute(self, allocator, input, options);
    }

    /// Describes the stale security group rules for security groups referenced
    /// across a VPC
    /// peering connection, transit gateway connection, or with a security group VPC
    /// association. Rules are stale when they reference a deleted security group.
    /// Rules can
    /// also be stale if they reference a security group in a peer VPC for which the
    /// VPC peering
    /// connection has been deleted, across a transit gateway where the transit
    /// gateway has been
    /// deleted (or [the transit
    /// gateway security group referencing
    /// feature](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-vpc-attachments.html#vpc-attachment-security) has been disabled), or if a
    /// security group VPC association has been disassociated.
    pub fn describeStaleSecurityGroups(self: *Self, allocator: std.mem.Allocator, input: describe_stale_security_groups.DescribeStaleSecurityGroupsInput, options: CallOptions) !describe_stale_security_groups.DescribeStaleSecurityGroupsOutput {
        return describe_stale_security_groups.execute(self, allocator, input, options);
    }

    /// Describes the progress of the AMI store tasks. You can describe the store
    /// tasks for
    /// specified AMIs. If you don't specify the AMIs, you get a paginated list of
    /// store tasks from
    /// the last 31 days.
    ///
    /// For each AMI task, the response indicates if the task is `InProgress`,
    /// `Completed`, or `Failed`. For tasks `InProgress`, the
    /// response shows the estimated progress as a percentage.
    ///
    /// Tasks are listed in reverse chronological order. Currently, only tasks from
    /// the past 31
    /// days can be viewed.
    ///
    /// To use this API, you must have the required permissions. For more
    /// information, see [Permissions for storing and restoring AMIs using
    /// S3](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-ami-store-restore.html#ami-s3-permissions) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// For more information, see [Store and restore an AMI using
    /// S3](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-store-restore.html) in the *Amazon EC2 User Guide*.
    pub fn describeStoreImageTasks(self: *Self, allocator: std.mem.Allocator, input: describe_store_image_tasks.DescribeStoreImageTasksInput, options: CallOptions) !describe_store_image_tasks.DescribeStoreImageTasksOutput {
        return describe_store_image_tasks.execute(self, allocator, input, options);
    }

    /// Describes your subnets. The default is to describe all your subnets.
    /// Alternatively, you can specify specific subnet IDs or filter the results to
    /// include only the subnets that match specific criteria.
    ///
    /// For more information, see
    /// [Subnets](https://docs.aws.amazon.com/vpc/latest/userguide/configure-subnets.html) in the
    /// *Amazon VPC User Guide*.
    pub fn describeSubnets(self: *Self, allocator: std.mem.Allocator, input: describe_subnets.DescribeSubnetsInput, options: CallOptions) !describe_subnets.DescribeSubnetsOutput {
        return describe_subnets.execute(self, allocator, input, options);
    }

    /// Describes the specified tags for your EC2 resources.
    ///
    /// For more information about tags, see [Tag your Amazon EC2
    /// resources](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html) in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    ///
    /// We strongly recommend using only paginated requests. Unpaginated requests
    /// are
    /// susceptible to throttling and timeouts.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures, might vary. Applications should not assume the elements appear
    /// in a
    /// particular order.
    pub fn describeTags(self: *Self, allocator: std.mem.Allocator, input: describe_tags.DescribeTagsInput, options: CallOptions) !describe_tags.DescribeTagsOutput {
        return describe_tags.execute(self, allocator, input, options);
    }

    /// Describe traffic mirror filters that determine the traffic that is mirrored.
    pub fn describeTrafficMirrorFilterRules(self: *Self, allocator: std.mem.Allocator, input: describe_traffic_mirror_filter_rules.DescribeTrafficMirrorFilterRulesInput, options: CallOptions) !describe_traffic_mirror_filter_rules.DescribeTrafficMirrorFilterRulesOutput {
        return describe_traffic_mirror_filter_rules.execute(self, allocator, input, options);
    }

    /// Describes one or more Traffic Mirror filters.
    pub fn describeTrafficMirrorFilters(self: *Self, allocator: std.mem.Allocator, input: describe_traffic_mirror_filters.DescribeTrafficMirrorFiltersInput, options: CallOptions) !describe_traffic_mirror_filters.DescribeTrafficMirrorFiltersOutput {
        return describe_traffic_mirror_filters.execute(self, allocator, input, options);
    }

    /// Describes one or more Traffic Mirror sessions. By default, all Traffic
    /// Mirror sessions are described. Alternatively, you can filter the results.
    pub fn describeTrafficMirrorSessions(self: *Self, allocator: std.mem.Allocator, input: describe_traffic_mirror_sessions.DescribeTrafficMirrorSessionsInput, options: CallOptions) !describe_traffic_mirror_sessions.DescribeTrafficMirrorSessionsOutput {
        return describe_traffic_mirror_sessions.execute(self, allocator, input, options);
    }

    /// Information about one or more Traffic Mirror targets.
    pub fn describeTrafficMirrorTargets(self: *Self, allocator: std.mem.Allocator, input: describe_traffic_mirror_targets.DescribeTrafficMirrorTargetsInput, options: CallOptions) !describe_traffic_mirror_targets.DescribeTrafficMirrorTargetsOutput {
        return describe_traffic_mirror_targets.execute(self, allocator, input, options);
    }

    /// Describes one or more attachments between resources and transit gateways. By
    /// default, all attachments are described.
    /// Alternatively, you can filter the results by attachment ID, attachment
    /// state, resource ID, or resource owner.
    pub fn describeTransitGatewayAttachments(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateway_attachments.DescribeTransitGatewayAttachmentsInput, options: CallOptions) !describe_transit_gateway_attachments.DescribeTransitGatewayAttachmentsOutput {
        return describe_transit_gateway_attachments.execute(self, allocator, input, options);
    }

    /// Describes one or more Connect peers.
    pub fn describeTransitGatewayConnectPeers(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateway_connect_peers.DescribeTransitGatewayConnectPeersInput, options: CallOptions) !describe_transit_gateway_connect_peers.DescribeTransitGatewayConnectPeersOutput {
        return describe_transit_gateway_connect_peers.execute(self, allocator, input, options);
    }

    /// Describes one or more Connect attachments.
    pub fn describeTransitGatewayConnects(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateway_connects.DescribeTransitGatewayConnectsInput, options: CallOptions) !describe_transit_gateway_connects.DescribeTransitGatewayConnectsOutput {
        return describe_transit_gateway_connects.execute(self, allocator, input, options);
    }

    /// Describes one or more transit gateway metering policies.
    pub fn describeTransitGatewayMeteringPolicies(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateway_metering_policies.DescribeTransitGatewayMeteringPoliciesInput, options: CallOptions) !describe_transit_gateway_metering_policies.DescribeTransitGatewayMeteringPoliciesOutput {
        return describe_transit_gateway_metering_policies.execute(self, allocator, input, options);
    }

    /// Describes one or more transit gateway multicast domains.
    pub fn describeTransitGatewayMulticastDomains(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateway_multicast_domains.DescribeTransitGatewayMulticastDomainsInput, options: CallOptions) !describe_transit_gateway_multicast_domains.DescribeTransitGatewayMulticastDomainsOutput {
        return describe_transit_gateway_multicast_domains.execute(self, allocator, input, options);
    }

    /// Describes your transit gateway peering attachments.
    pub fn describeTransitGatewayPeeringAttachments(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateway_peering_attachments.DescribeTransitGatewayPeeringAttachmentsInput, options: CallOptions) !describe_transit_gateway_peering_attachments.DescribeTransitGatewayPeeringAttachmentsOutput {
        return describe_transit_gateway_peering_attachments.execute(self, allocator, input, options);
    }

    /// Describes one or more transit gateway route policy tables.
    pub fn describeTransitGatewayPolicyTables(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateway_policy_tables.DescribeTransitGatewayPolicyTablesInput, options: CallOptions) !describe_transit_gateway_policy_tables.DescribeTransitGatewayPolicyTablesOutput {
        return describe_transit_gateway_policy_tables.execute(self, allocator, input, options);
    }

    /// Describes one or more transit gateway route table advertisements.
    pub fn describeTransitGatewayRouteTableAnnouncements(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateway_route_table_announcements.DescribeTransitGatewayRouteTableAnnouncementsInput, options: CallOptions) !describe_transit_gateway_route_table_announcements.DescribeTransitGatewayRouteTableAnnouncementsOutput {
        return describe_transit_gateway_route_table_announcements.execute(self, allocator, input, options);
    }

    /// Describes one or more transit gateway route tables. By default, all transit
    /// gateway route tables are described.
    /// Alternatively, you can filter the results.
    pub fn describeTransitGatewayRouteTables(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateway_route_tables.DescribeTransitGatewayRouteTablesInput, options: CallOptions) !describe_transit_gateway_route_tables.DescribeTransitGatewayRouteTablesOutput {
        return describe_transit_gateway_route_tables.execute(self, allocator, input, options);
    }

    /// Describes one or more VPC attachments. By default, all VPC attachments are
    /// described.
    /// Alternatively, you can filter the results.
    pub fn describeTransitGatewayVpcAttachments(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateway_vpc_attachments.DescribeTransitGatewayVpcAttachmentsInput, options: CallOptions) !describe_transit_gateway_vpc_attachments.DescribeTransitGatewayVpcAttachmentsOutput {
        return describe_transit_gateway_vpc_attachments.execute(self, allocator, input, options);
    }

    /// Describes one or more transit gateways. By default, all transit gateways are
    /// described. Alternatively, you can
    /// filter the results.
    pub fn describeTransitGateways(self: *Self, allocator: std.mem.Allocator, input: describe_transit_gateways.DescribeTransitGatewaysInput, options: CallOptions) !describe_transit_gateways.DescribeTransitGatewaysOutput {
        return describe_transit_gateways.execute(self, allocator, input, options);
    }

    /// Describes one or more network interface trunk associations.
    pub fn describeTrunkInterfaceAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_trunk_interface_associations.DescribeTrunkInterfaceAssociationsInput, options: CallOptions) !describe_trunk_interface_associations.DescribeTrunkInterfaceAssociationsOutput {
        return describe_trunk_interface_associations.execute(self, allocator, input, options);
    }

    /// Describes the specified Amazon Web Services Verified Access endpoints.
    pub fn describeVerifiedAccessEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_verified_access_endpoints.DescribeVerifiedAccessEndpointsInput, options: CallOptions) !describe_verified_access_endpoints.DescribeVerifiedAccessEndpointsOutput {
        return describe_verified_access_endpoints.execute(self, allocator, input, options);
    }

    /// Describes the specified Verified Access groups.
    pub fn describeVerifiedAccessGroups(self: *Self, allocator: std.mem.Allocator, input: describe_verified_access_groups.DescribeVerifiedAccessGroupsInput, options: CallOptions) !describe_verified_access_groups.DescribeVerifiedAccessGroupsOutput {
        return describe_verified_access_groups.execute(self, allocator, input, options);
    }

    /// Describes the specified Amazon Web Services Verified Access instances.
    pub fn describeVerifiedAccessInstanceLoggingConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_verified_access_instance_logging_configurations.DescribeVerifiedAccessInstanceLoggingConfigurationsInput, options: CallOptions) !describe_verified_access_instance_logging_configurations.DescribeVerifiedAccessInstanceLoggingConfigurationsOutput {
        return describe_verified_access_instance_logging_configurations.execute(self, allocator, input, options);
    }

    /// Describes the specified Amazon Web Services Verified Access instances.
    pub fn describeVerifiedAccessInstances(self: *Self, allocator: std.mem.Allocator, input: describe_verified_access_instances.DescribeVerifiedAccessInstancesInput, options: CallOptions) !describe_verified_access_instances.DescribeVerifiedAccessInstancesOutput {
        return describe_verified_access_instances.execute(self, allocator, input, options);
    }

    /// Describes the specified Amazon Web Services Verified Access trust providers.
    pub fn describeVerifiedAccessTrustProviders(self: *Self, allocator: std.mem.Allocator, input: describe_verified_access_trust_providers.DescribeVerifiedAccessTrustProvidersInput, options: CallOptions) !describe_verified_access_trust_providers.DescribeVerifiedAccessTrustProvidersOutput {
        return describe_verified_access_trust_providers.execute(self, allocator, input, options);
    }

    /// Describes the specified attribute of the specified volume. You can specify
    /// only one
    /// attribute at a time.
    ///
    /// For more information about EBS volumes, see [Amazon EBS
    /// volumes](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volumes.html)
    /// in the *Amazon EBS User Guide*.
    pub fn describeVolumeAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_volume_attribute.DescribeVolumeAttributeInput, options: CallOptions) !describe_volume_attribute.DescribeVolumeAttributeOutput {
        return describe_volume_attribute.execute(self, allocator, input, options);
    }

    /// Describes the status of the specified volumes. Volume status provides the
    /// result of the
    /// checks performed on your volumes to determine events that can impair the
    /// performance of your
    /// volumes. The performance of a volume can be affected if an issue occurs on
    /// the volume's
    /// underlying host. If the volume's underlying host experiences a power outage
    /// or system issue,
    /// after the system is restored, there could be data inconsistencies on the
    /// volume. Volume events
    /// notify you if this occurs. Volume actions notify you if any action needs to
    /// be taken in
    /// response to the event.
    ///
    /// The `DescribeVolumeStatus` operation provides the following information
    /// about
    /// the specified volumes:
    ///
    /// *Status*: Reflects the current status of the volume. The possible
    /// values are `ok`, `impaired` , `warning`, or
    /// `insufficient-data`. If all checks pass, the overall status of the volume is
    /// `ok`. If the check fails, the overall status is `impaired`. If the
    /// status is `insufficient-data`, then the checks might still be taking place
    /// on your
    /// volume at the time. We recommend that you retry the request. For more
    /// information about volume
    /// status, see [Monitor the status of your
    /// volumes](https://docs.aws.amazon.com/ebs/latest/userguide/monitoring-volume-status.html) in the *Amazon EBS User Guide*.
    ///
    /// *Events*: Reflect the cause of a volume status and might require you to
    /// take action. For example, if your volume returns an `impaired` status, then
    /// the
    /// volume event might be `potential-data-inconsistency`. This means that your
    /// volume
    /// has been affected by an issue with the underlying host, has all I/O
    /// operations disabled, and
    /// might have inconsistent data.
    ///
    /// *Actions*: Reflect the actions you might have to take in response to an
    /// event. For example, if the status of the volume is `impaired` and the volume
    /// event
    /// shows `potential-data-inconsistency`, then the action shows
    /// `enable-volume-io`. This means that you may want to enable the I/O
    /// operations for
    /// the volume and then check the volume for data consistency. For more
    /// information, see
    /// [Work with an
    /// impaired EBS
    /// volume](https://docs.aws.amazon.com/ebs/latest/userguide/work_volumes_impaired.html).
    ///
    /// Volume status is based on the volume status checks, and does not reflect the
    /// volume state.
    /// Therefore, volume status does not indicate volumes in the `error` state (for
    /// example, when a volume is incapable of accepting I/O.)
    ///
    /// The order of the elements in the response, including those within nested
    /// structures, might vary. Applications should not assume the elements appear
    /// in a
    /// particular order.
    pub fn describeVolumeStatus(self: *Self, allocator: std.mem.Allocator, input: describe_volume_status.DescribeVolumeStatusInput, options: CallOptions) !describe_volume_status.DescribeVolumeStatusOutput {
        return describe_volume_status.execute(self, allocator, input, options);
    }

    /// Describes the specified EBS volumes or all of your EBS volumes.
    ///
    /// If you are describing a long list of volumes, we recommend that you paginate
    /// the output to make the list
    /// more manageable. For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    ///
    /// For more information about EBS volumes, see [Amazon EBS
    /// volumes](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-volumes.html)
    /// in the *Amazon EBS User Guide*.
    ///
    /// We strongly recommend using only paginated requests. Unpaginated requests
    /// are
    /// susceptible to throttling and timeouts.
    ///
    /// The order of the elements in the response, including those within nested
    /// structures, might vary. Applications should not assume the elements appear
    /// in a
    /// particular order.
    pub fn describeVolumes(self: *Self, allocator: std.mem.Allocator, input: describe_volumes.DescribeVolumesInput, options: CallOptions) !describe_volumes.DescribeVolumesOutput {
        return describe_volumes.execute(self, allocator, input, options);
    }

    /// Describes the most recent volume modification request for the specified EBS
    /// volumes.
    ///
    /// For more information, see [
    /// Monitor the progress of volume
    /// modifications](https://docs.aws.amazon.com/ebs/latest/userguide/monitoring-volume-modifications.html) in the *Amazon EBS User Guide*.
    pub fn describeVolumesModifications(self: *Self, allocator: std.mem.Allocator, input: describe_volumes_modifications.DescribeVolumesModificationsInput, options: CallOptions) !describe_volumes_modifications.DescribeVolumesModificationsOutput {
        return describe_volumes_modifications.execute(self, allocator, input, options);
    }

    /// Describes the specified attribute of the specified VPC. You can specify only
    /// one attribute at a time.
    pub fn describeVpcAttribute(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_attribute.DescribeVpcAttributeInput, options: CallOptions) !describe_vpc_attribute.DescribeVpcAttributeOutput {
        return describe_vpc_attribute.execute(self, allocator, input, options);
    }

    /// Describe VPC Block Public Access (BPA) exclusions. A VPC BPA exclusion is a
    /// mode that can be applied to a single VPC or subnet that exempts it from the
    /// account’s BPA mode and will allow bidirectional or egress-only access. You
    /// can create BPA exclusions for VPCs and subnets even when BPA is not enabled
    /// on the account to ensure that there is no traffic disruption to the
    /// exclusions when VPC BPA is turned on. To learn more about VPC BPA, see
    /// [Block public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    pub fn describeVpcBlockPublicAccessExclusions(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_block_public_access_exclusions.DescribeVpcBlockPublicAccessExclusionsInput, options: CallOptions) !describe_vpc_block_public_access_exclusions.DescribeVpcBlockPublicAccessExclusionsOutput {
        return describe_vpc_block_public_access_exclusions.execute(self, allocator, input, options);
    }

    /// Describe VPC Block Public Access (BPA) options. VPC Block Public Access
    /// (BPA) enables you to block resources in VPCs and subnets that you own in a
    /// Region from reaching or being reached from the internet through internet
    /// gateways and egress-only internet gateways. To learn more about VPC BPA, see
    /// [Block public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    pub fn describeVpcBlockPublicAccessOptions(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_block_public_access_options.DescribeVpcBlockPublicAccessOptionsInput, options: CallOptions) !describe_vpc_block_public_access_options.DescribeVpcBlockPublicAccessOptionsOutput {
        return describe_vpc_block_public_access_options.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Describes the ClassicLink status of the specified VPCs.
    pub fn describeVpcClassicLink(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_classic_link.DescribeVpcClassicLinkInput, options: CallOptions) !describe_vpc_classic_link.DescribeVpcClassicLinkOutput {
        return describe_vpc_classic_link.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Describes the ClassicLink DNS support status of one or more VPCs. If
    /// enabled, the DNS
    /// hostname of a linked EC2-Classic instance resolves to its private IP address
    /// when
    /// addressed from an instance in the VPC to which it's linked. Similarly, the
    /// DNS hostname
    /// of an instance in a VPC resolves to its private IP address when addressed
    /// from a linked
    /// EC2-Classic instance.
    pub fn describeVpcClassicLinkDnsSupport(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_classic_link_dns_support.DescribeVpcClassicLinkDnsSupportInput, options: CallOptions) !describe_vpc_classic_link_dns_support.DescribeVpcClassicLinkDnsSupportOutput {
        return describe_vpc_classic_link_dns_support.execute(self, allocator, input, options);
    }

    /// Describes one or more VPC Encryption Control configurations. VPC Encryption
    /// Control enables you to enforce encryption for all data in transit within and
    /// between VPCs to meet compliance requirements You can filter the results to
    /// return information about specific encryption controls or VPCs.
    ///
    /// For more information, see [Enforce VPC encryption in
    /// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
    pub fn describeVpcEncryptionControls(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_encryption_controls.DescribeVpcEncryptionControlsInput, options: CallOptions) !describe_vpc_encryption_controls.DescribeVpcEncryptionControlsOutput {
        return describe_vpc_encryption_controls.execute(self, allocator, input, options);
    }

    /// Describes the VPC resources, VPC endpoint services, Amazon Lattice services,
    /// or service networks
    /// associated with the VPC endpoint.
    pub fn describeVpcEndpointAssociations(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_endpoint_associations.DescribeVpcEndpointAssociationsInput, options: CallOptions) !describe_vpc_endpoint_associations.DescribeVpcEndpointAssociationsOutput {
        return describe_vpc_endpoint_associations.execute(self, allocator, input, options);
    }

    /// Describes the connection notifications for VPC endpoints and VPC endpoint
    /// services.
    pub fn describeVpcEndpointConnectionNotifications(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_endpoint_connection_notifications.DescribeVpcEndpointConnectionNotificationsInput, options: CallOptions) !describe_vpc_endpoint_connection_notifications.DescribeVpcEndpointConnectionNotificationsOutput {
        return describe_vpc_endpoint_connection_notifications.execute(self, allocator, input, options);
    }

    /// Describes the VPC endpoint connections to your VPC endpoint services,
    /// including any
    /// endpoints that are pending your acceptance.
    pub fn describeVpcEndpointConnections(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_endpoint_connections.DescribeVpcEndpointConnectionsInput, options: CallOptions) !describe_vpc_endpoint_connections.DescribeVpcEndpointConnectionsOutput {
        return describe_vpc_endpoint_connections.execute(self, allocator, input, options);
    }

    /// Describes the VPC endpoint service configurations in your account (your
    /// services).
    pub fn describeVpcEndpointServiceConfigurations(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_endpoint_service_configurations.DescribeVpcEndpointServiceConfigurationsInput, options: CallOptions) !describe_vpc_endpoint_service_configurations.DescribeVpcEndpointServiceConfigurationsOutput {
        return describe_vpc_endpoint_service_configurations.execute(self, allocator, input, options);
    }

    /// Describes the principals (service consumers) that are permitted to discover
    /// your VPC
    /// endpoint service. Principal ARNs with path components aren't supported.
    pub fn describeVpcEndpointServicePermissions(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_endpoint_service_permissions.DescribeVpcEndpointServicePermissionsInput, options: CallOptions) !describe_vpc_endpoint_service_permissions.DescribeVpcEndpointServicePermissionsOutput {
        return describe_vpc_endpoint_service_permissions.execute(self, allocator, input, options);
    }

    /// Describes available services to which you can create a VPC endpoint.
    ///
    /// When the service provider and the consumer have different accounts in
    /// multiple
    /// Availability Zones, and the consumer views the VPC endpoint service
    /// information, the
    /// response only includes the common Availability Zones. For example, when the
    /// service
    /// provider account uses `us-east-1a` and `us-east-1c` and the
    /// consumer uses `us-east-1a` and `us-east-1b`, the response includes
    /// the VPC endpoint services in the common Availability Zone,
    /// `us-east-1a`.
    pub fn describeVpcEndpointServices(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_endpoint_services.DescribeVpcEndpointServicesInput, options: CallOptions) !describe_vpc_endpoint_services.DescribeVpcEndpointServicesOutput {
        return describe_vpc_endpoint_services.execute(self, allocator, input, options);
    }

    /// Describes your VPC endpoints. The default is to describe all your VPC
    /// endpoints.
    /// Alternatively, you can specify specific VPC endpoint IDs or filter the
    /// results to
    /// include only the VPC endpoints that match specific criteria.
    pub fn describeVpcEndpoints(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_endpoints.DescribeVpcEndpointsInput, options: CallOptions) !describe_vpc_endpoints.DescribeVpcEndpointsOutput {
        return describe_vpc_endpoints.execute(self, allocator, input, options);
    }

    /// Describes your VPC peering connections. The default is to describe all your
    /// VPC peering connections.
    /// Alternatively, you can specify specific VPC peering connection IDs or filter
    /// the results to
    /// include only the VPC peering connections that match specific criteria.
    pub fn describeVpcPeeringConnections(self: *Self, allocator: std.mem.Allocator, input: describe_vpc_peering_connections.DescribeVpcPeeringConnectionsInput, options: CallOptions) !describe_vpc_peering_connections.DescribeVpcPeeringConnectionsOutput {
        return describe_vpc_peering_connections.execute(self, allocator, input, options);
    }

    /// Describes your VPCs. The default is to describe all your VPCs.
    /// Alternatively, you can specify specific VPC IDs or filter the results to
    /// include only the VPCs that match specific criteria.
    pub fn describeVpcs(self: *Self, allocator: std.mem.Allocator, input: describe_vpcs.DescribeVpcsInput, options: CallOptions) !describe_vpcs.DescribeVpcsOutput {
        return describe_vpcs.execute(self, allocator, input, options);
    }

    /// Describes one or more of your VPN concentrators.
    pub fn describeVpnConcentrators(self: *Self, allocator: std.mem.Allocator, input: describe_vpn_concentrators.DescribeVpnConcentratorsInput, options: CallOptions) !describe_vpn_concentrators.DescribeVpnConcentratorsOutput {
        return describe_vpn_concentrators.execute(self, allocator, input, options);
    }

    /// Describes one or more of your VPN connections.
    ///
    /// For more information, see [Amazon Web Services Site-to-Site
    /// VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html) in the
    /// *Amazon Web Services Site-to-Site VPN
    /// User Guide*.
    pub fn describeVpnConnections(self: *Self, allocator: std.mem.Allocator, input: describe_vpn_connections.DescribeVpnConnectionsInput, options: CallOptions) !describe_vpn_connections.DescribeVpnConnectionsOutput {
        return describe_vpn_connections.execute(self, allocator, input, options);
    }

    /// Describes one or more of your virtual private gateways.
    ///
    /// For more information, see [Amazon Web Services Site-to-Site
    /// VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPC_VPN.html) in the
    /// *Amazon Web Services Site-to-Site VPN
    /// User Guide*.
    pub fn describeVpnGateways(self: *Self, allocator: std.mem.Allocator, input: describe_vpn_gateways.DescribeVpnGatewaysInput, options: CallOptions) !describe_vpn_gateways.DescribeVpnGatewaysOutput {
        return describe_vpn_gateways.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Unlinks (detaches) a linked EC2-Classic instance from a VPC. After the
    /// instance has been unlinked,
    /// the VPC security groups are no longer associated with it. An instance is
    /// automatically unlinked from
    /// a VPC when it's stopped.
    pub fn detachClassicLinkVpc(self: *Self, allocator: std.mem.Allocator, input: detach_classic_link_vpc.DetachClassicLinkVpcInput, options: CallOptions) !detach_classic_link_vpc.DetachClassicLinkVpcOutput {
        return detach_classic_link_vpc.execute(self, allocator, input, options);
    }

    /// Detaches an internet gateway from a VPC, disabling connectivity between the
    /// internet
    /// and the VPC. The VPC must not contain any running instances with Elastic IP
    /// addresses or
    /// public IPv4 addresses.
    pub fn detachInternetGateway(self: *Self, allocator: std.mem.Allocator, input: detach_internet_gateway.DetachInternetGatewayInput, options: CallOptions) !detach_internet_gateway.DetachInternetGatewayOutput {
        return detach_internet_gateway.execute(self, allocator, input, options);
    }

    /// Detaches a network interface from an instance.
    pub fn detachNetworkInterface(self: *Self, allocator: std.mem.Allocator, input: detach_network_interface.DetachNetworkInterfaceInput, options: CallOptions) !detach_network_interface.DetachNetworkInterfaceOutput {
        return detach_network_interface.execute(self, allocator, input, options);
    }

    /// Detaches the specified Amazon Web Services Verified Access trust provider
    /// from the specified Amazon Web Services Verified Access instance.
    pub fn detachVerifiedAccessTrustProvider(self: *Self, allocator: std.mem.Allocator, input: detach_verified_access_trust_provider.DetachVerifiedAccessTrustProviderInput, options: CallOptions) !detach_verified_access_trust_provider.DetachVerifiedAccessTrustProviderOutput {
        return detach_verified_access_trust_provider.execute(self, allocator, input, options);
    }

    /// Detaches an EBS volume from an instance. Make sure to unmount any file
    /// systems on the
    /// device within your operating system before detaching the volume. Failure to
    /// do so can result
    /// in the volume becoming stuck in the `busy` state while detaching. If this
    /// happens,
    /// detachment can be delayed indefinitely until you unmount the volume, force
    /// detachment, reboot
    /// the instance, or all three. If an EBS volume is the root device of an
    /// instance, it can't be
    /// detached while the instance is running. To detach the root volume, stop the
    /// instance
    /// first.
    ///
    /// When a volume with an Amazon Web Services Marketplace product code is
    /// detached from an instance, the
    /// product code is no longer associated with the instance.
    ///
    /// You can't detach or force detach volumes that are attached to Amazon Web
    /// Services-managed resources.
    /// Attempting to do this results in the `UnsupportedOperationException`
    /// exception.
    ///
    /// For more information, see [Detach an Amazon EBS
    /// volume](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-detaching-volume.html) in the
    /// *Amazon EBS User Guide*.
    pub fn detachVolume(self: *Self, allocator: std.mem.Allocator, input: detach_volume.DetachVolumeInput, options: CallOptions) !detach_volume.DetachVolumeOutput {
        return detach_volume.execute(self, allocator, input, options);
    }

    /// Detaches a virtual private gateway from a VPC. You do this if you're
    /// planning to turn
    /// off the VPC and not use it anymore. You can confirm a virtual private
    /// gateway has been
    /// completely detached from a VPC by describing the virtual private gateway
    /// (any
    /// attachments to the virtual private gateway are also described).
    ///
    /// You must wait for the attachment's state to switch to `detached` before you
    /// can delete the VPC or attach a different VPC to the virtual private gateway.
    pub fn detachVpnGateway(self: *Self, allocator: std.mem.Allocator, input: detach_vpn_gateway.DetachVpnGatewayInput, options: CallOptions) !detach_vpn_gateway.DetachVpnGatewayOutput {
        return detach_vpn_gateway.execute(self, allocator, input, options);
    }

    /// Disables Elastic IP address transfer. For more information, see [Transfer
    /// Elastic IP
    /// addresses](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-eips.html#transfer-EIPs-intro) in the *Amazon VPC User Guide*.
    pub fn disableAddressTransfer(self: *Self, allocator: std.mem.Allocator, input: disable_address_transfer.DisableAddressTransferInput, options: CallOptions) !disable_address_transfer.DisableAddressTransferOutput {
        return disable_address_transfer.execute(self, allocator, input, options);
    }

    /// Disables Allowed AMIs for your account in the specified Amazon Web Services
    /// Region. When set to
    /// `disabled`, the image criteria in your Allowed AMIs settings do not apply,
    /// and no
    /// restrictions are placed on AMI discoverability or usage. Users in your
    /// account can launch
    /// instances using any public AMI or AMI shared with your account.
    ///
    /// The Allowed AMIs feature does not restrict the AMIs owned by your account.
    /// Regardless of
    /// the criteria you set, the AMIs created by your account will always be
    /// discoverable and
    /// usable by users in your account.
    ///
    /// For more information, see [Control the discovery and use of AMIs in
    /// Amazon EC2 with Allowed
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html) in
    /// *Amazon EC2 User Guide*.
    pub fn disableAllowedImagesSettings(self: *Self, allocator: std.mem.Allocator, input: disable_allowed_images_settings.DisableAllowedImagesSettingsInput, options: CallOptions) !disable_allowed_images_settings.DisableAllowedImagesSettingsOutput {
        return disable_allowed_images_settings.execute(self, allocator, input, options);
    }

    /// Disables Infrastructure Performance metric subscriptions.
    pub fn disableAwsNetworkPerformanceMetricSubscription(self: *Self, allocator: std.mem.Allocator, input: disable_aws_network_performance_metric_subscription.DisableAwsNetworkPerformanceMetricSubscriptionInput, options: CallOptions) !disable_aws_network_performance_metric_subscription.DisableAwsNetworkPerformanceMetricSubscriptionOutput {
        return disable_aws_network_performance_metric_subscription.execute(self, allocator, input, options);
    }

    /// Disables EC2 Capacity Manager for your account. This stops data ingestion
    /// and removes access to capacity analytics and optimization recommendations.
    /// Previously collected data is retained but no new data will be processed.
    pub fn disableCapacityManager(self: *Self, allocator: std.mem.Allocator, input: disable_capacity_manager.DisableCapacityManagerInput, options: CallOptions) !disable_capacity_manager.DisableCapacityManagerOutput {
        return disable_capacity_manager.execute(self, allocator, input, options);
    }

    /// Disables EBS encryption by default for your account in the current Region.
    ///
    /// After you disable encryption by default, you can still create encrypted
    /// volumes by
    /// enabling encryption when you create each volume.
    ///
    /// Disabling encryption by default does not change the encryption status of
    /// your
    /// existing volumes.
    ///
    /// For more information, see [Amazon EBS
    /// encryption](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption.html) in the
    /// *Amazon EBS User Guide*.
    pub fn disableEbsEncryptionByDefault(self: *Self, allocator: std.mem.Allocator, input: disable_ebs_encryption_by_default.DisableEbsEncryptionByDefaultInput, options: CallOptions) !disable_ebs_encryption_by_default.DisableEbsEncryptionByDefaultOutput {
        return disable_ebs_encryption_by_default.execute(self, allocator, input, options);
    }

    /// Discontinue Windows fast launch for a Windows AMI, and clean up existing
    /// pre-provisioned
    /// snapshots. After you disable Windows fast launch, the AMI uses the standard
    /// launch process for
    /// each new instance. Amazon EC2 must remove all pre-provisioned snapshots
    /// before you can enable
    /// Windows fast launch again.
    ///
    /// You can only change these settings for Windows AMIs that you own or that
    /// have been
    /// shared with you.
    pub fn disableFastLaunch(self: *Self, allocator: std.mem.Allocator, input: disable_fast_launch.DisableFastLaunchInput, options: CallOptions) !disable_fast_launch.DisableFastLaunchOutput {
        return disable_fast_launch.execute(self, allocator, input, options);
    }

    /// Disables fast snapshot restores for the specified snapshots in the specified
    /// Availability Zones.
    pub fn disableFastSnapshotRestores(self: *Self, allocator: std.mem.Allocator, input: disable_fast_snapshot_restores.DisableFastSnapshotRestoresInput, options: CallOptions) !disable_fast_snapshot_restores.DisableFastSnapshotRestoresOutput {
        return disable_fast_snapshot_restores.execute(self, allocator, input, options);
    }

    /// Sets the AMI state to `disabled` and removes all launch permissions from the
    /// AMI. A disabled AMI can't be used for instance launches.
    ///
    /// A disabled AMI can't be shared. If an AMI was public or previously shared,
    /// it is made
    /// private. If an AMI was shared with an Amazon Web Services account,
    /// organization, or Organizational Unit,
    /// they lose access to the disabled AMI.
    ///
    /// A disabled AMI does not appear in
    /// [DescribeImages](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeImages.html) API calls by
    /// default.
    ///
    /// Only the AMI owner can disable an AMI.
    ///
    /// You can re-enable a disabled AMI using
    /// [EnableImage](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_EnableImage.html).
    ///
    /// For more information, see [Disable an
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/disable-an-ami.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn disableImage(self: *Self, allocator: std.mem.Allocator, input: disable_image.DisableImageInput, options: CallOptions) !disable_image.DisableImageOutput {
        return disable_image.execute(self, allocator, input, options);
    }

    /// Disables *block public access for AMIs* at the account level in the
    /// specified Amazon Web Services Region. This removes the *block public access*
    /// restriction
    /// from your account. With the restriction removed, you can publicly share your
    /// AMIs in the
    /// specified Amazon Web Services Region.
    ///
    /// For more information, see [Block
    /// public access to your
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-public-access-to-amis.html) in the *Amazon EC2 User Guide*.
    pub fn disableImageBlockPublicAccess(self: *Self, allocator: std.mem.Allocator, input: disable_image_block_public_access.DisableImageBlockPublicAccessInput, options: CallOptions) !disable_image_block_public_access.DisableImageBlockPublicAccessOutput {
        return disable_image_block_public_access.execute(self, allocator, input, options);
    }

    /// Cancels the deprecation of the specified AMI.
    ///
    /// For more information, see [Deprecate an Amazon EC2
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-deprecate.html)
    /// in the
    /// *Amazon EC2 User Guide*.
    pub fn disableImageDeprecation(self: *Self, allocator: std.mem.Allocator, input: disable_image_deprecation.DisableImageDeprecationInput, options: CallOptions) !disable_image_deprecation.DisableImageDeprecationOutput {
        return disable_image_deprecation.execute(self, allocator, input, options);
    }

    /// Disables deregistration protection for an AMI. When deregistration
    /// protection is disabled,
    /// the AMI can be deregistered.
    ///
    /// If you chose to include a 24-hour cooldown period when you enabled
    /// deregistration
    /// protection for the AMI, then, when you disable deregistration protection,
    /// you won’t
    /// immediately be able to deregister the AMI.
    ///
    /// For more information, see [Protect an Amazon EC2 AMI from
    /// deregistration](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-deregistration-protection.html) in the *Amazon EC2 User Guide*.
    pub fn disableImageDeregistrationProtection(self: *Self, allocator: std.mem.Allocator, input: disable_image_deregistration_protection.DisableImageDeregistrationProtectionInput, options: CallOptions) !disable_image_deregistration_protection.DisableImageDeregistrationProtectionOutput {
        return disable_image_deregistration_protection.execute(self, allocator, input, options);
    }

    /// Disable Amazon EC2 instances running in an SQL Server High Availability
    /// cluster from SQL Server High Availability
    /// instance standby detection monitoring. Once disabled, Amazon Web Services no
    /// longer monitors the
    /// metadata for the instances to determine whether they are active or standby
    /// nodes in the
    /// SQL Server High Availability cluster.
    pub fn disableInstanceSqlHaStandbyDetections(self: *Self, allocator: std.mem.Allocator, input: disable_instance_sql_ha_standby_detections.DisableInstanceSqlHaStandbyDetectionsInput, options: CallOptions) !disable_instance_sql_ha_standby_detections.DisableInstanceSqlHaStandbyDetectionsOutput {
        return disable_instance_sql_ha_standby_detections.execute(self, allocator, input, options);
    }

    /// Disable the IPAM account. For more information, see [Enable integration with
    /// Organizations](https://docs.aws.amazon.com/vpc/latest/ipam/enable-integ-ipam.html) in the *Amazon VPC IPAM User Guide*.
    pub fn disableIpamOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: disable_ipam_organization_admin_account.DisableIpamOrganizationAdminAccountInput, options: CallOptions) !disable_ipam_organization_admin_account.DisableIpamOrganizationAdminAccountOutput {
        return disable_ipam_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Disables an IPAM policy.
    ///
    /// An IPAM policy is a set of rules that define how public IPv4 addresses from
    /// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
    /// Amazon Web Services service to IPAM pools that the service will use to get
    /// IP addresses. A single policy can have multiple rules and be applied to
    /// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
    /// then the services fallback to Amazon-provided IP addresses. A policy can be
    /// applied to an individual Amazon Web Services account or an entity within
    /// Amazon Web Services Organizations.
    pub fn disableIpamPolicy(self: *Self, allocator: std.mem.Allocator, input: disable_ipam_policy.DisableIpamPolicyInput, options: CallOptions) !disable_ipam_policy.DisableIpamPolicyOutput {
        return disable_ipam_policy.execute(self, allocator, input, options);
    }

    /// Disables route propagation from a route server to a specified route table.
    ///
    /// When enabled, route server propagation installs the routes in the FIB on the
    /// route table you've specified. Route server supports IPv4 and IPv6 route
    /// propagation.
    ///
    /// Amazon VPC Route Server simplifies routing for traffic between workloads
    /// that are deployed within a VPC and its internet gateways. With this feature,
    /// VPC Route Server dynamically updates VPC and internet gateway route tables
    /// with your preferred IPv4 or IPv6 routes to achieve routing fault tolerance
    /// for those workloads. This enables you to automatically reroute traffic
    /// within a VPC, which increases the manageability of VPC routing and
    /// interoperability with third-party workloads.
    ///
    /// Route server supports the follow route table types:
    ///
    /// * VPC route tables not associated with subnets
    ///
    /// * Subnet route tables
    ///
    /// * Internet gateway route tables
    ///
    /// Route server does not support route tables associated with virtual private
    /// gateways. To propagate routes into a transit gateway route table, use
    /// [Transit Gateway
    /// Connect](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html).
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn disableRouteServerPropagation(self: *Self, allocator: std.mem.Allocator, input: disable_route_server_propagation.DisableRouteServerPropagationInput, options: CallOptions) !disable_route_server_propagation.DisableRouteServerPropagationOutput {
        return disable_route_server_propagation.execute(self, allocator, input, options);
    }

    /// Disables access to the EC2 serial console of all instances for your account.
    /// By default,
    /// access to the EC2 serial console is disabled for your account. For more
    /// information, see
    /// [Manage account access to the EC2 serial
    /// console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configure-access-to-serial-console.html#serial-console-account-access) in the *Amazon EC2
    /// User Guide*.
    pub fn disableSerialConsoleAccess(self: *Self, allocator: std.mem.Allocator, input: disable_serial_console_access.DisableSerialConsoleAccessInput, options: CallOptions) !disable_serial_console_access.DisableSerialConsoleAccessOutput {
        return disable_serial_console_access.execute(self, allocator, input, options);
    }

    /// Disables the *block public access for snapshots* setting at
    /// the account level for the specified Amazon Web Services Region. After you
    /// disable block public
    /// access for snapshots in a Region, users can publicly share snapshots in that
    /// Region.
    ///
    /// Enabling block public access for snapshots in *block-all-sharing*
    /// mode does not change the permissions for snapshots that are already publicly
    /// shared.
    /// Instead, it prevents these snapshots from be publicly visible and publicly
    /// accessible.
    /// Therefore, the attributes for these snapshots still indicate that they are
    /// publicly
    /// shared, even though they are not publicly available.
    ///
    /// If you disable block public access , these snapshots will become publicly
    /// available
    /// again.
    ///
    /// For more information, see [
    /// Block public access for
    /// snapshots](https://docs.aws.amazon.com/ebs/latest/userguide/block-public-access-snapshots.html) in the *Amazon EBS User Guide* .
    pub fn disableSnapshotBlockPublicAccess(self: *Self, allocator: std.mem.Allocator, input: disable_snapshot_block_public_access.DisableSnapshotBlockPublicAccessInput, options: CallOptions) !disable_snapshot_block_public_access.DisableSnapshotBlockPublicAccessOutput {
        return disable_snapshot_block_public_access.execute(self, allocator, input, options);
    }

    /// Disables the specified resource attachment from propagating routes to the
    /// specified
    /// propagation route table.
    pub fn disableTransitGatewayRouteTablePropagation(self: *Self, allocator: std.mem.Allocator, input: disable_transit_gateway_route_table_propagation.DisableTransitGatewayRouteTablePropagationInput, options: CallOptions) !disable_transit_gateway_route_table_propagation.DisableTransitGatewayRouteTablePropagationOutput {
        return disable_transit_gateway_route_table_propagation.execute(self, allocator, input, options);
    }

    /// Disables a virtual private gateway (VGW) from propagating routes to a
    /// specified route
    /// table of a VPC.
    pub fn disableVgwRoutePropagation(self: *Self, allocator: std.mem.Allocator, input: disable_vgw_route_propagation.DisableVgwRoutePropagationInput, options: CallOptions) !disable_vgw_route_propagation.DisableVgwRoutePropagationOutput {
        return disable_vgw_route_propagation.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Disables ClassicLink for a VPC. You cannot disable ClassicLink for a VPC
    /// that has EC2-Classic instances
    /// linked to it.
    pub fn disableVpcClassicLink(self: *Self, allocator: std.mem.Allocator, input: disable_vpc_classic_link.DisableVpcClassicLinkInput, options: CallOptions) !disable_vpc_classic_link.DisableVpcClassicLinkOutput {
        return disable_vpc_classic_link.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Disables ClassicLink DNS support for a VPC. If disabled, DNS hostnames
    /// resolve to
    /// public IP addresses when addressed between a linked EC2-Classic instance and
    /// instances
    /// in the VPC to which it's linked.
    ///
    /// You must specify a VPC ID in the request.
    pub fn disableVpcClassicLinkDnsSupport(self: *Self, allocator: std.mem.Allocator, input: disable_vpc_classic_link_dns_support.DisableVpcClassicLinkDnsSupportInput, options: CallOptions) !disable_vpc_classic_link_dns_support.DisableVpcClassicLinkDnsSupportOutput {
        return disable_vpc_classic_link_dns_support.execute(self, allocator, input, options);
    }

    /// Disassociates an Elastic IP address from the instance or network interface
    /// it's associated with.
    ///
    /// This is an idempotent operation. If you perform the operation more than
    /// once, Amazon EC2 doesn't return an error.
    ///
    /// An address cannot be disassociated if the all of the following conditions
    /// are met:
    ///
    /// * Network interface has a `publicDualStackDnsName` publicDnsName
    ///
    /// * Public IPv4 address is the primary public IPv4 address
    ///
    /// * Network interface only has one remaining public IPv4 address
    pub fn disassociateAddress(self: *Self, allocator: std.mem.Allocator, input: disassociate_address.DisassociateAddressInput, options: CallOptions) !disassociate_address.DisassociateAddressOutput {
        return disassociate_address.execute(self, allocator, input, options);
    }

    /// Cancels a pending request to assign billing of the unused capacity of a
    /// Capacity
    /// Reservation to a consumer account, or revokes a request that has already
    /// been accepted.
    /// For more information, see [Billing assignment for shared
    /// Amazon EC2 Capacity
    /// Reservations](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/assign-billing.html).
    pub fn disassociateCapacityReservationBillingOwner(self: *Self, allocator: std.mem.Allocator, input: disassociate_capacity_reservation_billing_owner.DisassociateCapacityReservationBillingOwnerInput, options: CallOptions) !disassociate_capacity_reservation_billing_owner.DisassociateCapacityReservationBillingOwnerOutput {
        return disassociate_capacity_reservation_billing_owner.execute(self, allocator, input, options);
    }

    /// Disassociates a target network from the specified Client VPN endpoint. When
    /// you disassociate the
    /// last target network from a Client VPN, the following happens:
    ///
    /// * The route that was automatically added for the VPC is deleted
    ///
    /// * All active client connections are terminated
    ///
    /// * New client connections are disallowed
    ///
    /// * The Client VPN endpoint's status changes to `pending-associate`
    pub fn disassociateClientVpnTargetNetwork(self: *Self, allocator: std.mem.Allocator, input: disassociate_client_vpn_target_network.DisassociateClientVpnTargetNetworkInput, options: CallOptions) !disassociate_client_vpn_target_network.DisassociateClientVpnTargetNetworkOutput {
        return disassociate_client_vpn_target_network.execute(self, allocator, input, options);
    }

    /// Disassociates an IAM role from an Certificate Manager (ACM) certificate.
    /// Disassociating an IAM role
    /// from an ACM certificate removes the Amazon S3 object that contains the
    /// certificate, certificate chain, and
    /// encrypted private key from the Amazon S3 bucket. It also revokes the IAM
    /// role's permission to use the
    /// KMS key used to encrypt the private key. This effectively revokes the role's
    /// permission
    /// to use the certificate.
    pub fn disassociateEnclaveCertificateIamRole(self: *Self, allocator: std.mem.Allocator, input: disassociate_enclave_certificate_iam_role.DisassociateEnclaveCertificateIamRoleInput, options: CallOptions) !disassociate_enclave_certificate_iam_role.DisassociateEnclaveCertificateIamRoleOutput {
        return disassociate_enclave_certificate_iam_role.execute(self, allocator, input, options);
    }

    /// Disassociates an IAM instance profile from a running or stopped instance.
    ///
    /// Use DescribeIamInstanceProfileAssociations to get the association
    /// ID.
    pub fn disassociateIamInstanceProfile(self: *Self, allocator: std.mem.Allocator, input: disassociate_iam_instance_profile.DisassociateIamInstanceProfileInput, options: CallOptions) !disassociate_iam_instance_profile.DisassociateIamInstanceProfileOutput {
        return disassociate_iam_instance_profile.execute(self, allocator, input, options);
    }

    /// Disassociates one or more targets from an event window.
    ///
    /// For more information, see [Define event windows for scheduled
    /// events](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/event-windows.html) in the *Amazon EC2 User Guide*.
    pub fn disassociateInstanceEventWindow(self: *Self, allocator: std.mem.Allocator, input: disassociate_instance_event_window.DisassociateInstanceEventWindowInput, options: CallOptions) !disassociate_instance_event_window.DisassociateInstanceEventWindowOutput {
        return disassociate_instance_event_window.execute(self, allocator, input, options);
    }

    /// Remove the association between your Autonomous System Number (ASN) and your
    /// BYOIP CIDR. You may want to use this action to disassociate an ASN from a
    /// CIDR or if you want to swap ASNs.
    /// For more information, see [Tutorial: Bring your ASN to
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoasn.html) in
    /// the *Amazon VPC IPAM guide*.
    pub fn disassociateIpamByoasn(self: *Self, allocator: std.mem.Allocator, input: disassociate_ipam_byoasn.DisassociateIpamByoasnInput, options: CallOptions) !disassociate_ipam_byoasn.DisassociateIpamByoasnOutput {
        return disassociate_ipam_byoasn.execute(self, allocator, input, options);
    }

    /// Disassociates a resource discovery from an Amazon VPC IPAM. A resource
    /// discovery is an IPAM component that enables IPAM to manage and monitor
    /// resources that belong to the owning account.
    pub fn disassociateIpamResourceDiscovery(self: *Self, allocator: std.mem.Allocator, input: disassociate_ipam_resource_discovery.DisassociateIpamResourceDiscoveryInput, options: CallOptions) !disassociate_ipam_resource_discovery.DisassociateIpamResourceDiscoveryOutput {
        return disassociate_ipam_resource_discovery.execute(self, allocator, input, options);
    }

    /// Disassociates secondary Elastic IP addresses (EIPs) from a public NAT
    /// gateway.
    /// You cannot disassociate your primary EIP. For more information, see [Edit
    /// secondary IP address
    /// associations](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html#nat-gateway-edit-secondary) in the *Amazon VPC User Guide*.
    ///
    /// While disassociating is in progress, you cannot associate/disassociate
    /// additional EIPs while the connections are being drained. You are, however,
    /// allowed to delete the NAT gateway.
    ///
    /// An EIP is released only at the end of MaxDrainDurationSeconds. It stays
    /// associated and supports the existing connections but does not support any
    /// new connections
    /// (new connections are distributed across the remaining associated EIPs). As
    /// the existing
    /// connections drain out, the EIPs (and the corresponding private IP addresses
    /// mapped to them)
    /// are released.
    pub fn disassociateNatGatewayAddress(self: *Self, allocator: std.mem.Allocator, input: disassociate_nat_gateway_address.DisassociateNatGatewayAddressInput, options: CallOptions) !disassociate_nat_gateway_address.DisassociateNatGatewayAddressOutput {
        return disassociate_nat_gateway_address.execute(self, allocator, input, options);
    }

    /// Disassociates a route server from a VPC.
    ///
    /// A route server association is the connection established between a route
    /// server and a VPC.
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn disassociateRouteServer(self: *Self, allocator: std.mem.Allocator, input: disassociate_route_server.DisassociateRouteServerInput, options: CallOptions) !disassociate_route_server.DisassociateRouteServerOutput {
        return disassociate_route_server.execute(self, allocator, input, options);
    }

    /// Disassociates a subnet or gateway from a route table.
    ///
    /// After you perform this action, the subnet no longer uses the routes in the
    /// route table.
    /// Instead, it uses the routes in the VPC's main route table. For more
    /// information
    /// about route tables, see [Route
    /// tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html) in the *Amazon VPC User Guide*.
    pub fn disassociateRouteTable(self: *Self, allocator: std.mem.Allocator, input: disassociate_route_table.DisassociateRouteTableInput, options: CallOptions) !disassociate_route_table.DisassociateRouteTableOutput {
        return disassociate_route_table.execute(self, allocator, input, options);
    }

    /// Disassociates a security group from a VPC. You cannot disassociate the
    /// security group if any Elastic network interfaces in the associated VPC are
    /// still associated with the security group.
    ///
    /// Note that the disassociation is asynchronous and you can check the status of
    /// the request with
    /// [DescribeSecurityGroupVpcAssociations](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DescribeSecurityGroupVpcAssociations.html).
    pub fn disassociateSecurityGroupVpc(self: *Self, allocator: std.mem.Allocator, input: disassociate_security_group_vpc.DisassociateSecurityGroupVpcInput, options: CallOptions) !disassociate_security_group_vpc.DisassociateSecurityGroupVpcOutput {
        return disassociate_security_group_vpc.execute(self, allocator, input, options);
    }

    /// Disassociates a CIDR block from a subnet. Currently, you can disassociate an
    /// IPv6 CIDR block only. You must detach or delete all gateways and resources
    /// that are associated with the CIDR block before you can disassociate it.
    pub fn disassociateSubnetCidrBlock(self: *Self, allocator: std.mem.Allocator, input: disassociate_subnet_cidr_block.DisassociateSubnetCidrBlockInput, options: CallOptions) !disassociate_subnet_cidr_block.DisassociateSubnetCidrBlockOutput {
        return disassociate_subnet_cidr_block.execute(self, allocator, input, options);
    }

    /// Disassociates the specified subnets from the transit gateway multicast
    /// domain.
    pub fn disassociateTransitGatewayMulticastDomain(self: *Self, allocator: std.mem.Allocator, input: disassociate_transit_gateway_multicast_domain.DisassociateTransitGatewayMulticastDomainInput, options: CallOptions) !disassociate_transit_gateway_multicast_domain.DisassociateTransitGatewayMulticastDomainOutput {
        return disassociate_transit_gateway_multicast_domain.execute(self, allocator, input, options);
    }

    /// Removes the association between an an attachment and a policy table.
    pub fn disassociateTransitGatewayPolicyTable(self: *Self, allocator: std.mem.Allocator, input: disassociate_transit_gateway_policy_table.DisassociateTransitGatewayPolicyTableInput, options: CallOptions) !disassociate_transit_gateway_policy_table.DisassociateTransitGatewayPolicyTableOutput {
        return disassociate_transit_gateway_policy_table.execute(self, allocator, input, options);
    }

    /// Disassociates a resource attachment from a transit gateway route table.
    pub fn disassociateTransitGatewayRouteTable(self: *Self, allocator: std.mem.Allocator, input: disassociate_transit_gateway_route_table.DisassociateTransitGatewayRouteTableInput, options: CallOptions) !disassociate_transit_gateway_route_table.DisassociateTransitGatewayRouteTableOutput {
        return disassociate_transit_gateway_route_table.execute(self, allocator, input, options);
    }

    /// Removes an association between a branch network interface with a trunk
    /// network interface.
    pub fn disassociateTrunkInterface(self: *Self, allocator: std.mem.Allocator, input: disassociate_trunk_interface.DisassociateTrunkInterfaceInput, options: CallOptions) !disassociate_trunk_interface.DisassociateTrunkInterfaceOutput {
        return disassociate_trunk_interface.execute(self, allocator, input, options);
    }

    /// Disassociates a CIDR block from a VPC. To disassociate the CIDR block, you
    /// must
    /// specify its association ID. You can get the association ID by using
    /// DescribeVpcs. You must detach or delete all gateways and resources that
    /// are associated with the CIDR block before you can disassociate it.
    ///
    /// You cannot disassociate the CIDR block with which you originally created the
    /// VPC (the
    /// primary CIDR block).
    pub fn disassociateVpcCidrBlock(self: *Self, allocator: std.mem.Allocator, input: disassociate_vpc_cidr_block.DisassociateVpcCidrBlockInput, options: CallOptions) !disassociate_vpc_cidr_block.DisassociateVpcCidrBlockOutput {
        return disassociate_vpc_cidr_block.execute(self, allocator, input, options);
    }

    /// Enables Elastic IP address transfer. For more information, see [Transfer
    /// Elastic IP
    /// addresses](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-eips.html#transfer-EIPs-intro) in the *Amazon VPC User Guide*.
    pub fn enableAddressTransfer(self: *Self, allocator: std.mem.Allocator, input: enable_address_transfer.EnableAddressTransferInput, options: CallOptions) !enable_address_transfer.EnableAddressTransferOutput {
        return enable_address_transfer.execute(self, allocator, input, options);
    }

    /// Enables Allowed AMIs for your account in the specified Amazon Web Services
    /// Region. Two values are
    /// accepted:
    ///
    /// * `enabled`: The image criteria in your Allowed AMIs settings are applied.
    ///   As
    /// a result, only AMIs matching these criteria are discoverable and can be used
    /// by your
    /// account to launch instances.
    ///
    /// * `audit-mode`: The image criteria in your Allowed AMIs settings are not
    /// applied. No restrictions are placed on AMI discoverability or usage. Users
    /// in your account
    /// can launch instances using any public AMI or AMI shared with your account.
    ///
    /// The purpose of `audit-mode` is to indicate which AMIs will be affected when
    /// Allowed AMIs is `enabled`. In `audit-mode`, each AMI displays either
    /// `"ImageAllowed": true` or `"ImageAllowed": false` to indicate
    /// whether the AMI will be discoverable and available to users in the account
    /// when Allowed
    /// AMIs is enabled.
    ///
    /// The Allowed AMIs feature does not restrict the AMIs owned by your account.
    /// Regardless of
    /// the criteria you set, the AMIs created by your account will always be
    /// discoverable and
    /// usable by users in your account.
    ///
    /// For more information, see [Control the discovery and use of AMIs in
    /// Amazon EC2 with Allowed
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html) in
    /// *Amazon EC2 User Guide*.
    pub fn enableAllowedImagesSettings(self: *Self, allocator: std.mem.Allocator, input: enable_allowed_images_settings.EnableAllowedImagesSettingsInput, options: CallOptions) !enable_allowed_images_settings.EnableAllowedImagesSettingsOutput {
        return enable_allowed_images_settings.execute(self, allocator, input, options);
    }

    /// Enables Infrastructure Performance subscriptions.
    pub fn enableAwsNetworkPerformanceMetricSubscription(self: *Self, allocator: std.mem.Allocator, input: enable_aws_network_performance_metric_subscription.EnableAwsNetworkPerformanceMetricSubscriptionInput, options: CallOptions) !enable_aws_network_performance_metric_subscription.EnableAwsNetworkPerformanceMetricSubscriptionOutput {
        return enable_aws_network_performance_metric_subscription.execute(self, allocator, input, options);
    }

    /// Enables EC2 Capacity Manager for your account. This starts data ingestion
    /// for your EC2 capacity usage across On-Demand, Spot, and Capacity
    /// Reservations.
    /// Initial data processing may take several hours to complete.
    pub fn enableCapacityManager(self: *Self, allocator: std.mem.Allocator, input: enable_capacity_manager.EnableCapacityManagerInput, options: CallOptions) !enable_capacity_manager.EnableCapacityManagerOutput {
        return enable_capacity_manager.execute(self, allocator, input, options);
    }

    /// Enables EBS encryption by default for your account in the current Region.
    ///
    /// After you enable encryption by default, the EBS volumes that you create are
    /// always encrypted, either using the default KMS key or the KMS key that you
    /// specified
    /// when you created each volume. For more information, see [Amazon EBS
    /// encryption](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption.html) in the
    /// *Amazon EBS User Guide*.
    ///
    /// Enabling encryption by default has no effect on the encryption status of
    /// your
    /// existing volumes.
    ///
    /// After you enable encryption by default, you can no longer launch instances
    /// using instance types that do not support encryption. For more information,
    /// see [Supported
    /// instance
    /// types](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption-requirements.html#ebs-encryption_supported_instances).
    pub fn enableEbsEncryptionByDefault(self: *Self, allocator: std.mem.Allocator, input: enable_ebs_encryption_by_default.EnableEbsEncryptionByDefaultInput, options: CallOptions) !enable_ebs_encryption_by_default.EnableEbsEncryptionByDefaultOutput {
        return enable_ebs_encryption_by_default.execute(self, allocator, input, options);
    }

    /// When you enable Windows fast launch for a Windows AMI, images are
    /// pre-provisioned, using
    /// snapshots to launch instances up to 65% faster. To create the optimized
    /// Windows image, Amazon EC2
    /// launches an instance and runs through Sysprep steps, rebooting as required.
    /// Then it creates a
    /// set of reserved snapshots that are used for subsequent launches. The
    /// reserved snapshots are
    /// automatically replenished as they are used, depending on your settings for
    /// launch
    /// frequency.
    ///
    /// You can only change these settings for Windows AMIs that you own or that
    /// have been
    /// shared with you.
    pub fn enableFastLaunch(self: *Self, allocator: std.mem.Allocator, input: enable_fast_launch.EnableFastLaunchInput, options: CallOptions) !enable_fast_launch.EnableFastLaunchOutput {
        return enable_fast_launch.execute(self, allocator, input, options);
    }

    /// Enables fast snapshot restores for the specified snapshots in the specified
    /// Availability Zones.
    ///
    /// You get the full benefit of fast snapshot restores after they enter the
    /// `enabled` state.
    ///
    /// For more information, see [Amazon EBS fast snapshot
    /// restore](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-fast-snapshot-restore.html) in the *Amazon EBS User Guide*.
    pub fn enableFastSnapshotRestores(self: *Self, allocator: std.mem.Allocator, input: enable_fast_snapshot_restores.EnableFastSnapshotRestoresInput, options: CallOptions) !enable_fast_snapshot_restores.EnableFastSnapshotRestoresOutput {
        return enable_fast_snapshot_restores.execute(self, allocator, input, options);
    }

    /// Re-enables a disabled AMI. The re-enabled AMI is marked as `available` and
    /// can
    /// be used for instance launches, appears in describe operations, and can be
    /// shared. Amazon Web Services
    /// accounts, organizations, and Organizational Units that lost access to the
    /// AMI when it was
    /// disabled do not regain access automatically. Once the AMI is available, it
    /// can be shared with
    /// them again.
    ///
    /// Only the AMI owner can re-enable a disabled AMI.
    ///
    /// For more information, see [Disable an Amazon EC2
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/disable-an-ami.html)
    /// in the *Amazon EC2 User Guide*.
    pub fn enableImage(self: *Self, allocator: std.mem.Allocator, input: enable_image.EnableImageInput, options: CallOptions) !enable_image.EnableImageOutput {
        return enable_image.execute(self, allocator, input, options);
    }

    /// Enables *block public access for AMIs* at the account level in the
    /// specified Amazon Web Services Region. This prevents the public sharing of
    /// your AMIs. However, if you already
    /// have public AMIs, they will remain publicly available.
    ///
    /// The API can take up to 10 minutes to configure this setting. During this
    /// time, if you run
    /// [GetImageBlockPublicAccessState](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_GetImageBlockPublicAccessState.html), the response will be `unblocked`. When
    /// the API has completed the configuration, the response will be
    /// `block-new-sharing`.
    ///
    /// For more information, see [Block
    /// public access to your
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-public-access-to-amis.html) in the *Amazon EC2 User Guide*.
    pub fn enableImageBlockPublicAccess(self: *Self, allocator: std.mem.Allocator, input: enable_image_block_public_access.EnableImageBlockPublicAccessInput, options: CallOptions) !enable_image_block_public_access.EnableImageBlockPublicAccessOutput {
        return enable_image_block_public_access.execute(self, allocator, input, options);
    }

    /// Enables deprecation of the specified AMI at the specified date and time.
    ///
    /// For more information, see [Deprecate an
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-deprecate.html)
    /// in the
    /// *Amazon EC2 User Guide*.
    pub fn enableImageDeprecation(self: *Self, allocator: std.mem.Allocator, input: enable_image_deprecation.EnableImageDeprecationInput, options: CallOptions) !enable_image_deprecation.EnableImageDeprecationOutput {
        return enable_image_deprecation.execute(self, allocator, input, options);
    }

    /// Enables deregistration protection for an AMI. When deregistration protection
    /// is enabled,
    /// the AMI can't be deregistered.
    ///
    /// To allow the AMI to be deregistered, you must first disable deregistration
    /// protection.
    ///
    /// For more information, see [Protect an
    /// Amazon EC2 AMI from
    /// deregistration](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-deregistration-protection.html) in the *Amazon EC2 User Guide*.
    pub fn enableImageDeregistrationProtection(self: *Self, allocator: std.mem.Allocator, input: enable_image_deregistration_protection.EnableImageDeregistrationProtectionInput, options: CallOptions) !enable_image_deregistration_protection.EnableImageDeregistrationProtectionOutput {
        return enable_image_deregistration_protection.execute(self, allocator, input, options);
    }

    /// Enable Amazon EC2 instances running in an SQL Server High Availability
    /// cluster for SQL Server High Availability
    /// instance standby detection monitoring. Once enabled, Amazon Web Services
    /// monitors the metadata for
    /// the instances to determine whether they are active or standby nodes in the
    /// SQL Server High Availability cluster.
    /// If the instances are determined to be standby failover nodes, Amazon Web
    /// Services
    /// automatically applies SQL Server licensing fee waiver for those instances.
    ///
    /// To register an instance, it must be running a Windows SQL Server
    /// license-included
    /// AMI and have the Amazon Web Services Systems Manager agent installed and
    /// running. Only Windows Server 2019 and later
    /// and SQL Server (Standard and Enterprise editions) 2017 and later are
    /// supported. For more
    /// information, see [
    /// Prerequisites for using SQL Server High Availability instance standby
    /// detection](https://docs.aws.amazon.com/sql-server-ec2/latest/userguide/prerequisites-and-requirements.html).
    pub fn enableInstanceSqlHaStandbyDetections(self: *Self, allocator: std.mem.Allocator, input: enable_instance_sql_ha_standby_detections.EnableInstanceSqlHaStandbyDetectionsInput, options: CallOptions) !enable_instance_sql_ha_standby_detections.EnableInstanceSqlHaStandbyDetectionsOutput {
        return enable_instance_sql_ha_standby_detections.execute(self, allocator, input, options);
    }

    /// Enable an Organizations member account as the IPAM admin account. You cannot
    /// select the Organizations management account as the IPAM admin account. For
    /// more information, see [Enable integration with
    /// Organizations](https://docs.aws.amazon.com/vpc/latest/ipam/enable-integ-ipam.html) in the *Amazon VPC IPAM User Guide*.
    pub fn enableIpamOrganizationAdminAccount(self: *Self, allocator: std.mem.Allocator, input: enable_ipam_organization_admin_account.EnableIpamOrganizationAdminAccountInput, options: CallOptions) !enable_ipam_organization_admin_account.EnableIpamOrganizationAdminAccountOutput {
        return enable_ipam_organization_admin_account.execute(self, allocator, input, options);
    }

    /// Enables an IPAM policy.
    ///
    /// An IPAM policy is a set of rules that define how public IPv4 addresses from
    /// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
    /// Amazon Web Services service to IPAM pools that the service will use to get
    /// IP addresses. A single policy can have multiple rules and be applied to
    /// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
    /// then the services fallback to Amazon-provided IP addresses. A policy can be
    /// applied to an individual Amazon Web Services account or an entity within
    /// Amazon Web Services Organizations.
    ///
    /// For more information, see [Define public IPv4 allocation strategy with IPAM
    /// policies](https://docs.aws.amazon.com/vpc/latest/ipam/define-public-ipv4-allocation-strategy-with-ipam-policies.html) in the *Amazon VPC IPAM User Guide*.
    pub fn enableIpamPolicy(self: *Self, allocator: std.mem.Allocator, input: enable_ipam_policy.EnableIpamPolicyInput, options: CallOptions) !enable_ipam_policy.EnableIpamPolicyOutput {
        return enable_ipam_policy.execute(self, allocator, input, options);
    }

    /// Establishes a trust relationship between Reachability Analyzer and
    /// Organizations.
    /// This operation must be performed by the management account for the
    /// organization.
    ///
    /// After you establish a trust relationship, a user in the management account
    /// or
    /// a delegated administrator account can run a cross-account analysis using
    /// resources
    /// from the member accounts.
    pub fn enableReachabilityAnalyzerOrganizationSharing(self: *Self, allocator: std.mem.Allocator, input: enable_reachability_analyzer_organization_sharing.EnableReachabilityAnalyzerOrganizationSharingInput, options: CallOptions) !enable_reachability_analyzer_organization_sharing.EnableReachabilityAnalyzerOrganizationSharingOutput {
        return enable_reachability_analyzer_organization_sharing.execute(self, allocator, input, options);
    }

    /// Defines which route tables the route server can update with routes.
    ///
    /// When enabled, route server propagation installs the routes in the FIB on the
    /// route table you've specified. Route server supports IPv4 and IPv6 route
    /// propagation.
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn enableRouteServerPropagation(self: *Self, allocator: std.mem.Allocator, input: enable_route_server_propagation.EnableRouteServerPropagationInput, options: CallOptions) !enable_route_server_propagation.EnableRouteServerPropagationOutput {
        return enable_route_server_propagation.execute(self, allocator, input, options);
    }

    /// Enables access to the EC2 serial console of all instances for your account.
    /// By default,
    /// access to the EC2 serial console is disabled for your account. For more
    /// information, see [Manage account access to the EC2 serial
    /// console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configure-access-to-serial-console.html#serial-console-account-access)
    /// in the *Amazon EC2 User Guide*.
    pub fn enableSerialConsoleAccess(self: *Self, allocator: std.mem.Allocator, input: enable_serial_console_access.EnableSerialConsoleAccessInput, options: CallOptions) !enable_serial_console_access.EnableSerialConsoleAccessOutput {
        return enable_serial_console_access.execute(self, allocator, input, options);
    }

    /// Enables or modifies the *block public access for snapshots*
    /// setting at the account level for the specified Amazon Web Services Region.
    /// After you enable block
    /// public access for snapshots in a Region, users can no longer request public
    /// sharing
    /// for snapshots in that Region. Snapshots that are already publicly shared are
    /// either
    /// treated as private or they remain publicly shared, depending on the
    /// **State** that you specify.
    ///
    /// Enabling block public access for snapshots in *block all sharing*
    /// mode does not change the permissions for snapshots that are already publicly
    /// shared.
    /// Instead, it prevents these snapshots from be publicly visible and publicly
    /// accessible.
    /// Therefore, the attributes for these snapshots still indicate that they are
    /// publicly
    /// shared, even though they are not publicly available.
    ///
    /// If you later disable block public access or change the mode to *block new
    /// sharing*, these snapshots will become publicly available again.
    ///
    /// For more information, see [
    /// Block public access for
    /// snapshots](https://docs.aws.amazon.com/ebs/latest/userguide/block-public-access-snapshots.html) in the *Amazon EBS User Guide*.
    pub fn enableSnapshotBlockPublicAccess(self: *Self, allocator: std.mem.Allocator, input: enable_snapshot_block_public_access.EnableSnapshotBlockPublicAccessInput, options: CallOptions) !enable_snapshot_block_public_access.EnableSnapshotBlockPublicAccessOutput {
        return enable_snapshot_block_public_access.execute(self, allocator, input, options);
    }

    /// Enables the specified attachment to propagate routes to the specified
    /// propagation route table.
    pub fn enableTransitGatewayRouteTablePropagation(self: *Self, allocator: std.mem.Allocator, input: enable_transit_gateway_route_table_propagation.EnableTransitGatewayRouteTablePropagationInput, options: CallOptions) !enable_transit_gateway_route_table_propagation.EnableTransitGatewayRouteTablePropagationOutput {
        return enable_transit_gateway_route_table_propagation.execute(self, allocator, input, options);
    }

    /// Enables a virtual private gateway (VGW) to propagate routes to the specified
    /// route
    /// table of a VPC.
    pub fn enableVgwRoutePropagation(self: *Self, allocator: std.mem.Allocator, input: enable_vgw_route_propagation.EnableVgwRoutePropagationInput, options: CallOptions) !enable_vgw_route_propagation.EnableVgwRoutePropagationOutput {
        return enable_vgw_route_propagation.execute(self, allocator, input, options);
    }

    /// Enables I/O operations for a volume that had I/O operations disabled because
    /// the data on
    /// the volume was potentially inconsistent.
    pub fn enableVolumeIo(self: *Self, allocator: std.mem.Allocator, input: enable_volume_io.EnableVolumeIOInput, options: CallOptions) !enable_volume_io.EnableVolumeIOOutput {
        return enable_volume_io.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Enables a VPC for ClassicLink. You can then link EC2-Classic instances to
    /// your
    /// ClassicLink-enabled VPC to allow communication over private IP addresses.
    /// You cannot
    /// enable your VPC for ClassicLink if any of your VPC route tables have
    /// existing routes for
    /// address ranges within the `10.0.0.0/8` IP address range, excluding local
    /// routes for VPCs in the `10.0.0.0/16` and `10.1.0.0/16` IP address
    /// ranges.
    pub fn enableVpcClassicLink(self: *Self, allocator: std.mem.Allocator, input: enable_vpc_classic_link.EnableVpcClassicLinkInput, options: CallOptions) !enable_vpc_classic_link.EnableVpcClassicLinkOutput {
        return enable_vpc_classic_link.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Enables a VPC to support DNS hostname resolution for ClassicLink. If
    /// enabled, the DNS
    /// hostname of a linked EC2-Classic instance resolves to its private IP address
    /// when
    /// addressed from an instance in the VPC to which it's linked. Similarly, the
    /// DNS hostname
    /// of an instance in a VPC resolves to its private IP address when addressed
    /// from a linked
    /// EC2-Classic instance.
    ///
    /// You must specify a VPC ID in the request.
    pub fn enableVpcClassicLinkDnsSupport(self: *Self, allocator: std.mem.Allocator, input: enable_vpc_classic_link_dns_support.EnableVpcClassicLinkDnsSupportInput, options: CallOptions) !enable_vpc_classic_link_dns_support.EnableVpcClassicLinkDnsSupportOutput {
        return enable_vpc_classic_link_dns_support.execute(self, allocator, input, options);
    }

    /// Downloads the client certificate revocation list for the specified Client
    /// VPN endpoint.
    pub fn exportClientVpnClientCertificateRevocationList(self: *Self, allocator: std.mem.Allocator, input: export_client_vpn_client_certificate_revocation_list.ExportClientVpnClientCertificateRevocationListInput, options: CallOptions) !export_client_vpn_client_certificate_revocation_list.ExportClientVpnClientCertificateRevocationListOutput {
        return export_client_vpn_client_certificate_revocation_list.execute(self, allocator, input, options);
    }

    /// Downloads the contents of the Client VPN endpoint configuration file for the
    /// specified Client VPN endpoint. The Client VPN endpoint configuration
    /// file includes the Client VPN endpoint and certificate information clients
    /// need to establish a connection
    /// with the Client VPN endpoint.
    pub fn exportClientVpnClientConfiguration(self: *Self, allocator: std.mem.Allocator, input: export_client_vpn_client_configuration.ExportClientVpnClientConfigurationInput, options: CallOptions) !export_client_vpn_client_configuration.ExportClientVpnClientConfigurationOutput {
        return export_client_vpn_client_configuration.execute(self, allocator, input, options);
    }

    /// Exports an Amazon Machine Image (AMI) to a VM file. For more information,
    /// see [Exporting a VM
    /// directly from an Amazon Machine Image
    /// (AMI)](https://docs.aws.amazon.com/vm-import/latest/userguide/vmexport_image.html) in the
    /// *VM Import/Export User Guide*.
    pub fn exportImage(self: *Self, allocator: std.mem.Allocator, input: export_image.ExportImageInput, options: CallOptions) !export_image.ExportImageOutput {
        return export_image.execute(self, allocator, input, options);
    }

    /// Exports routes from the specified transit gateway route table to the
    /// specified S3 bucket.
    /// By default, all routes are exported. Alternatively, you can filter by CIDR
    /// range.
    ///
    /// The routes are saved to the specified bucket in a JSON file. For more
    /// information, see
    /// [Export route tables
    /// to Amazon
    /// S3](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-route-tables.html#tgw-export-route-tables) in the *Amazon Web Services Transit Gateways Guide*.
    pub fn exportTransitGatewayRoutes(self: *Self, allocator: std.mem.Allocator, input: export_transit_gateway_routes.ExportTransitGatewayRoutesInput, options: CallOptions) !export_transit_gateway_routes.ExportTransitGatewayRoutesOutput {
        return export_transit_gateway_routes.execute(self, allocator, input, options);
    }

    /// Exports the client configuration for a Verified Access instance.
    pub fn exportVerifiedAccessInstanceClientConfiguration(self: *Self, allocator: std.mem.Allocator, input: export_verified_access_instance_client_configuration.ExportVerifiedAccessInstanceClientConfigurationInput, options: CallOptions) !export_verified_access_instance_client_configuration.ExportVerifiedAccessInstanceClientConfigurationOutput {
        return export_verified_access_instance_client_configuration.execute(self, allocator, input, options);
    }

    /// Returns the currently negotiated security parameters for an active VPN
    /// tunnel, including IKE version, DH groups, encryption algorithms, and
    /// integrity algorithms.
    pub fn getActiveVpnTunnelStatus(self: *Self, allocator: std.mem.Allocator, input: get_active_vpn_tunnel_status.GetActiveVpnTunnelStatusInput, options: CallOptions) !get_active_vpn_tunnel_status.GetActiveVpnTunnelStatusOutput {
        return get_active_vpn_tunnel_status.execute(self, allocator, input, options);
    }

    /// Gets the current state of the Allowed AMIs setting and the list of Allowed
    /// AMIs criteria
    /// at the account level in the specified Region.
    ///
    /// The Allowed AMIs feature does not restrict the AMIs owned by your account.
    /// Regardless of
    /// the criteria you set, the AMIs created by your account will always be
    /// discoverable and
    /// usable by users in your account.
    ///
    /// For more information, see [Control the discovery and use of AMIs in
    /// Amazon EC2 with Allowed
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html) in
    /// *Amazon EC2 User Guide*.
    pub fn getAllowedImagesSettings(self: *Self, allocator: std.mem.Allocator, input: get_allowed_images_settings.GetAllowedImagesSettingsInput, options: CallOptions) !get_allowed_images_settings.GetAllowedImagesSettingsOutput {
        return get_allowed_images_settings.execute(self, allocator, input, options);
    }

    /// Returns the IAM roles that are associated with the specified ACM (ACM)
    /// certificate.
    /// It also returns the name of the Amazon S3 bucket and the Amazon S3 object
    /// key where the certificate,
    /// certificate chain, and encrypted private key bundle are stored, and the ARN
    /// of the KMS key
    /// that's used to encrypt the private key.
    pub fn getAssociatedEnclaveCertificateIamRoles(self: *Self, allocator: std.mem.Allocator, input: get_associated_enclave_certificate_iam_roles.GetAssociatedEnclaveCertificateIamRolesInput, options: CallOptions) !get_associated_enclave_certificate_iam_roles.GetAssociatedEnclaveCertificateIamRolesOutput {
        return get_associated_enclave_certificate_iam_roles.execute(self, allocator, input, options);
    }

    /// Gets information about the IPv6 CIDR block associations for a specified IPv6
    /// address pool.
    pub fn getAssociatedIpv6PoolCidrs(self: *Self, allocator: std.mem.Allocator, input: get_associated_ipv_6_pool_cidrs.GetAssociatedIpv6PoolCidrsInput, options: CallOptions) !get_associated_ipv_6_pool_cidrs.GetAssociatedIpv6PoolCidrsOutput {
        return get_associated_ipv_6_pool_cidrs.execute(self, allocator, input, options);
    }

    /// Gets network performance data.
    pub fn getAwsNetworkPerformanceData(self: *Self, allocator: std.mem.Allocator, input: get_aws_network_performance_data.GetAwsNetworkPerformanceDataInput, options: CallOptions) !get_aws_network_performance_data.GetAwsNetworkPerformanceDataOutput {
        return get_aws_network_performance_data.execute(self, allocator, input, options);
    }

    /// Retrieves the current configuration and status of EC2 Capacity Manager for
    /// your account, including enablement status, Organizations access settings,
    /// and data ingestion status.
    pub fn getCapacityManagerAttributes(self: *Self, allocator: std.mem.Allocator, input: get_capacity_manager_attributes.GetCapacityManagerAttributesInput, options: CallOptions) !get_capacity_manager_attributes.GetCapacityManagerAttributesOutput {
        return get_capacity_manager_attributes.execute(self, allocator, input, options);
    }

    /// Retrieves capacity usage metrics for your EC2 resources. Returns time-series
    /// data for metrics like unused capacity, utilization rates, and costs
    /// across On-Demand, Spot, and Capacity Reservations. Data can be grouped and
    /// filtered by various dimensions such as region, account, and instance family.
    pub fn getCapacityManagerMetricData(self: *Self, allocator: std.mem.Allocator, input: get_capacity_manager_metric_data.GetCapacityManagerMetricDataInput, options: CallOptions) !get_capacity_manager_metric_data.GetCapacityManagerMetricDataOutput {
        return get_capacity_manager_metric_data.execute(self, allocator, input, options);
    }

    /// Retrieves the available dimension values for capacity metrics within a
    /// specified time range. This is useful for discovering what accounts,
    /// regions, instance families, and other dimensions have data available for
    /// filtering and grouping.
    pub fn getCapacityManagerMetricDimensions(self: *Self, allocator: std.mem.Allocator, input: get_capacity_manager_metric_dimensions.GetCapacityManagerMetricDimensionsInput, options: CallOptions) !get_capacity_manager_metric_dimensions.GetCapacityManagerMetricDimensionsOutput {
        return get_capacity_manager_metric_dimensions.execute(self, allocator, input, options);
    }

    /// Gets usage information about a Capacity Reservation. If the Capacity
    /// Reservation is
    /// shared, it shows usage information for the Capacity Reservation owner and
    /// each Amazon Web Services account that is currently using the shared
    /// capacity. If the Capacity
    /// Reservation is not shared, it shows only the Capacity Reservation owner's
    /// usage.
    pub fn getCapacityReservationUsage(self: *Self, allocator: std.mem.Allocator, input: get_capacity_reservation_usage.GetCapacityReservationUsageInput, options: CallOptions) !get_capacity_reservation_usage.GetCapacityReservationUsageOutput {
        return get_capacity_reservation_usage.execute(self, allocator, input, options);
    }

    /// Describes the allocations from the specified customer-owned address pool.
    pub fn getCoipPoolUsage(self: *Self, allocator: std.mem.Allocator, input: get_coip_pool_usage.GetCoipPoolUsageInput, options: CallOptions) !get_coip_pool_usage.GetCoipPoolUsageOutput {
        return get_coip_pool_usage.execute(self, allocator, input, options);
    }

    /// Gets the console output for the specified instance. For Linux instances, the
    /// instance
    /// console output displays the exact console output that would normally be
    /// displayed on a
    /// physical monitor attached to a computer. For Windows instances, the instance
    /// console
    /// output includes the last three system event log errors.
    ///
    /// For more information, see [Instance
    /// console
    /// output](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-console.html#instance-console-console-output) in the *Amazon EC2 User Guide*.
    pub fn getConsoleOutput(self: *Self, allocator: std.mem.Allocator, input: get_console_output.GetConsoleOutputInput, options: CallOptions) !get_console_output.GetConsoleOutputOutput {
        return get_console_output.execute(self, allocator, input, options);
    }

    /// Retrieve a JPG-format screenshot of a running instance to help with
    /// troubleshooting.
    ///
    /// The returned content is Base64-encoded.
    ///
    /// For more information, see [Instance console
    /// output](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/troubleshoot-unreachable-instance.html#instance-console-console-output) in the *Amazon EC2 User Guide*.
    pub fn getConsoleScreenshot(self: *Self, allocator: std.mem.Allocator, input: get_console_screenshot.GetConsoleScreenshotInput, options: CallOptions) !get_console_screenshot.GetConsoleScreenshotOutput {
        return get_console_screenshot.execute(self, allocator, input, options);
    }

    /// Retrieves a summary of the account status report.
    ///
    /// To view the full report, download it from the Amazon S3 bucket where it was
    /// saved.
    /// Reports are accessible only when they have the `complete` status. Reports
    /// with other statuses (`running`, `cancelled`, or
    /// `error`) are not available in the S3 bucket. For more information about
    /// downloading objects from an S3 bucket, see [Downloading
    /// objects](https://docs.aws.amazon.com/AmazonS3/latest/userguide/download-objects.html) in
    /// the *Amazon Simple Storage Service User Guide*.
    ///
    /// For more information, see [Generating the account status report for
    /// declarative
    /// policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_declarative_status-report.html) in the
    /// *Amazon Web Services Organizations User Guide*.
    pub fn getDeclarativePoliciesReportSummary(self: *Self, allocator: std.mem.Allocator, input: get_declarative_policies_report_summary.GetDeclarativePoliciesReportSummaryInput, options: CallOptions) !get_declarative_policies_report_summary.GetDeclarativePoliciesReportSummaryOutput {
        return get_declarative_policies_report_summary.execute(self, allocator, input, options);
    }

    /// Describes the default credit option for CPU usage of a burstable performance
    /// instance
    /// family.
    ///
    /// For more information, see [Burstable
    /// performance
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html) in the *Amazon EC2 User Guide*.
    pub fn getDefaultCreditSpecification(self: *Self, allocator: std.mem.Allocator, input: get_default_credit_specification.GetDefaultCreditSpecificationInput, options: CallOptions) !get_default_credit_specification.GetDefaultCreditSpecificationOutput {
        return get_default_credit_specification.execute(self, allocator, input, options);
    }

    /// Describes the default KMS key for EBS encryption by default for your account
    /// in this Region.
    ///
    /// For more information, see [Amazon EBS
    /// encryption](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption.html)
    /// in the *Amazon EBS User Guide*.
    pub fn getEbsDefaultKmsKeyId(self: *Self, allocator: std.mem.Allocator, input: get_ebs_default_kms_key_id.GetEbsDefaultKmsKeyIdInput, options: CallOptions) !get_ebs_default_kms_key_id.GetEbsDefaultKmsKeyIdOutput {
        return get_ebs_default_kms_key_id.execute(self, allocator, input, options);
    }

    /// Describes whether EBS encryption by default is enabled for your account in
    /// the current
    /// Region.
    ///
    /// For more information, see [Amazon EBS
    /// encryption](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption.html)
    /// in the *Amazon EBS User Guide*.
    pub fn getEbsEncryptionByDefault(self: *Self, allocator: std.mem.Allocator, input: get_ebs_encryption_by_default.GetEbsEncryptionByDefaultInput, options: CallOptions) !get_ebs_encryption_by_default.GetEbsEncryptionByDefaultOutput {
        return get_ebs_encryption_by_default.execute(self, allocator, input, options);
    }

    /// Gets the enabled IPAM policy.
    ///
    /// An IPAM policy is a set of rules that define how public IPv4 addresses from
    /// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
    /// Amazon Web Services service to IPAM pools that the service will use to get
    /// IP addresses. A single policy can have multiple rules and be applied to
    /// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
    /// then the services fallback to Amazon-provided IP addresses. A policy can be
    /// applied to an individual Amazon Web Services account or an entity within
    /// Amazon Web Services Organizations.
    pub fn getEnabledIpamPolicy(self: *Self, allocator: std.mem.Allocator, input: get_enabled_ipam_policy.GetEnabledIpamPolicyInput, options: CallOptions) !get_enabled_ipam_policy.GetEnabledIpamPolicyOutput {
        return get_enabled_ipam_policy.execute(self, allocator, input, options);
    }

    /// Generates a CloudFormation template that streamlines and automates the
    /// integration of VPC flow logs
    /// with Amazon Athena. This make it easier for you to query and gain insights
    /// from VPC flow logs data.
    /// Based on the information that you provide, we configure resources in the
    /// template to do the following:
    ///
    /// * Create a table in Athena that maps fields to a custom log format
    ///
    /// * Create a Lambda function that updates the table with new partitions on a
    ///   daily, weekly, or
    /// monthly basis
    ///
    /// * Create a table partitioned between two timestamps in the past
    ///
    /// * Create a set of named queries in Athena that you can use to get started
    ///   quickly
    ///
    /// `GetFlowLogsIntegrationTemplate` does not support integration between
    /// Amazon Web Services Transit Gateway Flow Logs and Amazon Athena.
    pub fn getFlowLogsIntegrationTemplate(self: *Self, allocator: std.mem.Allocator, input: get_flow_logs_integration_template.GetFlowLogsIntegrationTemplateInput, options: CallOptions) !get_flow_logs_integration_template.GetFlowLogsIntegrationTemplateOutput {
        return get_flow_logs_integration_template.execute(self, allocator, input, options);
    }

    /// Lists the resource groups to which a Capacity Reservation has been added.
    pub fn getGroupsForCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: get_groups_for_capacity_reservation.GetGroupsForCapacityReservationInput, options: CallOptions) !get_groups_for_capacity_reservation.GetGroupsForCapacityReservationOutput {
        return get_groups_for_capacity_reservation.execute(self, allocator, input, options);
    }

    /// Preview a reservation purchase with configurations that match those of your
    /// Dedicated
    /// Host. You must have active Dedicated Hosts in your account before you
    /// purchase a
    /// reservation.
    ///
    /// This is a preview of the PurchaseHostReservation action and does not
    /// result in the offering being purchased.
    pub fn getHostReservationPurchasePreview(self: *Self, allocator: std.mem.Allocator, input: get_host_reservation_purchase_preview.GetHostReservationPurchasePreviewInput, options: CallOptions) !get_host_reservation_purchase_preview.GetHostReservationPurchasePreviewOutput {
        return get_host_reservation_purchase_preview.execute(self, allocator, input, options);
    }

    /// Retrieves the ancestry chain of the specified AMI, tracing its lineage back
    /// to the root
    /// AMI. For more information, see [AMI
    /// ancestry](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-ancestry.html) in
    /// *Amazon EC2 User Guide*.
    pub fn getImageAncestry(self: *Self, allocator: std.mem.Allocator, input: get_image_ancestry.GetImageAncestryInput, options: CallOptions) !get_image_ancestry.GetImageAncestryOutput {
        return get_image_ancestry.execute(self, allocator, input, options);
    }

    /// Gets the current state of *block public access for AMIs* at the account
    /// level in the specified Amazon Web Services Region.
    ///
    /// For more information, see [Block
    /// public access to your
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-public-access-to-amis.html) in the *Amazon EC2 User Guide*.
    pub fn getImageBlockPublicAccessState(self: *Self, allocator: std.mem.Allocator, input: get_image_block_public_access_state.GetImageBlockPublicAccessStateInput, options: CallOptions) !get_image_block_public_access_state.GetImageBlockPublicAccessStateOutput {
        return get_image_block_public_access_state.execute(self, allocator, input, options);
    }

    /// Gets the default instance metadata service (IMDS) settings that are set at
    /// the account
    /// level in the specified Amazon Web Services  Region.
    ///
    /// For more information, see [Order of precedence for instance metadata
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-options.html#instance-metadata-options-order-of-precedence) in the
    /// *Amazon EC2 User Guide*.
    pub fn getInstanceMetadataDefaults(self: *Self, allocator: std.mem.Allocator, input: get_instance_metadata_defaults.GetInstanceMetadataDefaultsInput, options: CallOptions) !get_instance_metadata_defaults.GetInstanceMetadataDefaultsOutput {
        return get_instance_metadata_defaults.execute(self, allocator, input, options);
    }

    /// Gets the public endorsement key associated with the Nitro Trusted
    /// Platform Module (NitroTPM) for the specified instance.
    pub fn getInstanceTpmEkPub(self: *Self, allocator: std.mem.Allocator, input: get_instance_tpm_ek_pub.GetInstanceTpmEkPubInput, options: CallOptions) !get_instance_tpm_ek_pub.GetInstanceTpmEkPubOutput {
        return get_instance_tpm_ek_pub.execute(self, allocator, input, options);
    }

    /// Returns a list of instance types with the specified instance attributes. You
    /// can
    /// use the response to preview the instance types without launching instances.
    /// Note
    /// that the response does not consider capacity.
    ///
    /// When you specify multiple parameters, you get instance types that satisfy
    /// all of the
    /// specified parameters. If you specify multiple values for a parameter, you
    /// get instance
    /// types that satisfy any of the specified values.
    ///
    /// For more information, see [Preview instance types with specified
    /// attributes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-attribute-based-instance-type-selection.html#ec2fleet-get-instance-types-from-instance-requirements), [Specify attributes for instance type selection for EC2 Fleet or Spot Fleet](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-fleet-attribute-based-instance-type-selection.html), and [Spot
    /// placement
    /// score](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-placement-score.html) in the *Amazon EC2 User Guide*, and [Creating
    /// mixed instance groups using attribute-based instance type
    /// selection](https://docs.aws.amazon.com/autoscaling/ec2/userguide/create-asg-instance-type-requirements.html) in the
    /// *Amazon EC2 Auto Scaling User Guide*.
    pub fn getInstanceTypesFromInstanceRequirements(self: *Self, allocator: std.mem.Allocator, input: get_instance_types_from_instance_requirements.GetInstanceTypesFromInstanceRequirementsInput, options: CallOptions) !get_instance_types_from_instance_requirements.GetInstanceTypesFromInstanceRequirementsOutput {
        return get_instance_types_from_instance_requirements.execute(self, allocator, input, options);
    }

    /// A binary representation of the UEFI variable store. Only non-volatile
    /// variables are
    /// stored. This is a base64 encoded and zlib compressed binary value that must
    /// be properly
    /// encoded.
    ///
    /// When you use
    /// [register-image](https://docs.aws.amazon.com/cli/latest/reference/ec2/register-image.html) to create
    /// an AMI, you can create an exact copy of your variable store by passing the
    /// UEFI data in
    /// the `UefiData` parameter. You can modify the UEFI data by using the
    /// [python-uefivars tool](https://github.com/awslabs/python-uefivars) on
    /// GitHub. You can use the tool to convert the UEFI data into a human-readable
    /// format
    /// (JSON), which you can inspect and modify, and then convert back into the
    /// binary format
    /// to use with register-image.
    ///
    /// For more information, see [UEFI Secure
    /// Boot](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/uefi-secure-boot.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn getInstanceUefiData(self: *Self, allocator: std.mem.Allocator, input: get_instance_uefi_data.GetInstanceUefiDataInput, options: CallOptions) !get_instance_uefi_data.GetInstanceUefiDataOutput {
        return get_instance_uefi_data.execute(self, allocator, input, options);
    }

    /// Retrieve historical information about a CIDR within an IPAM scope. For more
    /// information, see [View the history of IP
    /// addresses](https://docs.aws.amazon.com/vpc/latest/ipam/view-history-cidr-ipam.html) in the *Amazon VPC IPAM User Guide*.
    pub fn getIpamAddressHistory(self: *Self, allocator: std.mem.Allocator, input: get_ipam_address_history.GetIpamAddressHistoryInput, options: CallOptions) !get_ipam_address_history.GetIpamAddressHistoryOutput {
        return get_ipam_address_history.execute(self, allocator, input, options);
    }

    /// Gets IPAM discovered accounts. A discovered account is an Amazon Web
    /// Services account that is monitored under a resource discovery. If you have
    /// integrated IPAM with Amazon Web Services Organizations, all accounts in the
    /// organization are discovered accounts. Only the IPAM account can get all
    /// discovered accounts in the organization.
    pub fn getIpamDiscoveredAccounts(self: *Self, allocator: std.mem.Allocator, input: get_ipam_discovered_accounts.GetIpamDiscoveredAccountsInput, options: CallOptions) !get_ipam_discovered_accounts.GetIpamDiscoveredAccountsOutput {
        return get_ipam_discovered_accounts.execute(self, allocator, input, options);
    }

    /// Gets the public IP addresses that have been discovered by IPAM.
    pub fn getIpamDiscoveredPublicAddresses(self: *Self, allocator: std.mem.Allocator, input: get_ipam_discovered_public_addresses.GetIpamDiscoveredPublicAddressesInput, options: CallOptions) !get_ipam_discovered_public_addresses.GetIpamDiscoveredPublicAddressesOutput {
        return get_ipam_discovered_public_addresses.execute(self, allocator, input, options);
    }

    /// Returns the resource CIDRs that are monitored as part of a resource
    /// discovery. A discovered resource is a resource CIDR monitored under a
    /// resource discovery. The following resources can be discovered: VPCs, Public
    /// IPv4 pools, VPC subnets, and Elastic IP addresses.
    pub fn getIpamDiscoveredResourceCidrs(self: *Self, allocator: std.mem.Allocator, input: get_ipam_discovered_resource_cidrs.GetIpamDiscoveredResourceCidrsInput, options: CallOptions) !get_ipam_discovered_resource_cidrs.GetIpamDiscoveredResourceCidrsOutput {
        return get_ipam_discovered_resource_cidrs.execute(self, allocator, input, options);
    }

    /// Gets the allocation rules for an IPAM policy.
    ///
    /// An IPAM policy is a set of rules that define how public IPv4 addresses from
    /// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
    /// Amazon Web Services service to IPAM pools that the service will use to get
    /// IP addresses. A single policy can have multiple rules and be applied to
    /// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
    /// then the services fallback to Amazon-provided IP addresses. A policy can be
    /// applied to an individual Amazon Web Services account or an entity within
    /// Amazon Web Services Organizations.
    ///
    /// Allocation rules are optional configurations within an IPAM policy that map
    /// Amazon Web Services resource types to specific IPAM pools. If no rules are
    /// defined, the resource types default to using Amazon-provided IP addresses.
    pub fn getIpamPolicyAllocationRules(self: *Self, allocator: std.mem.Allocator, input: get_ipam_policy_allocation_rules.GetIpamPolicyAllocationRulesInput, options: CallOptions) !get_ipam_policy_allocation_rules.GetIpamPolicyAllocationRulesOutput {
        return get_ipam_policy_allocation_rules.execute(self, allocator, input, options);
    }

    /// Gets the Amazon Web Services Organizations targets for an IPAM policy.
    ///
    /// An IPAM policy is a set of rules that define how public IPv4 addresses from
    /// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
    /// Amazon Web Services service to IPAM pools that the service will use to get
    /// IP addresses. A single policy can have multiple rules and be applied to
    /// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
    /// then the services fallback to Amazon-provided IP addresses. A policy can be
    /// applied to an individual Amazon Web Services account or an entity within
    /// Amazon Web Services Organizations.
    ///
    /// A target can be an individual Amazon Web Services account or an entity
    /// within an Amazon Web Services Organization to which an IPAM policy can be
    /// applied.
    pub fn getIpamPolicyOrganizationTargets(self: *Self, allocator: std.mem.Allocator, input: get_ipam_policy_organization_targets.GetIpamPolicyOrganizationTargetsInput, options: CallOptions) !get_ipam_policy_organization_targets.GetIpamPolicyOrganizationTargetsOutput {
        return get_ipam_policy_organization_targets.execute(self, allocator, input, options);
    }

    /// Get a list of all the CIDR allocations in an IPAM pool. The Region you use
    /// should be the IPAM pool locale. The locale is the Amazon Web Services Region
    /// where this IPAM pool is available for allocations.
    ///
    /// If you use this action after
    /// [AllocateIpamPoolCidr](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_AllocateIpamPoolCidr.html) or [ReleaseIpamPoolAllocation](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ReleaseIpamPoolAllocation.html), note that all EC2 API actions follow an [eventual consistency](https://docs.aws.amazon.com/ec2/latest/devguide/eventual-consistency.html) model.
    pub fn getIpamPoolAllocations(self: *Self, allocator: std.mem.Allocator, input: get_ipam_pool_allocations.GetIpamPoolAllocationsInput, options: CallOptions) !get_ipam_pool_allocations.GetIpamPoolAllocationsOutput {
        return get_ipam_pool_allocations.execute(self, allocator, input, options);
    }

    /// Get the CIDRs provisioned to an IPAM pool.
    pub fn getIpamPoolCidrs(self: *Self, allocator: std.mem.Allocator, input: get_ipam_pool_cidrs.GetIpamPoolCidrsInput, options: CallOptions) !get_ipam_pool_cidrs.GetIpamPoolCidrsOutput {
        return get_ipam_pool_cidrs.execute(self, allocator, input, options);
    }

    /// Retrieves the CIDR selection rules for an IPAM prefix list resolver. Use
    /// this operation to view the business logic that determines which CIDRs are
    /// selected for synchronization with prefix lists.
    pub fn getIpamPrefixListResolverRules(self: *Self, allocator: std.mem.Allocator, input: get_ipam_prefix_list_resolver_rules.GetIpamPrefixListResolverRulesInput, options: CallOptions) !get_ipam_prefix_list_resolver_rules.GetIpamPrefixListResolverRulesOutput {
        return get_ipam_prefix_list_resolver_rules.execute(self, allocator, input, options);
    }

    /// Retrieves the CIDR entries for a specific version of an IPAM prefix list
    /// resolver. This shows the actual CIDRs that were selected and synchronized at
    /// a particular point in time.
    pub fn getIpamPrefixListResolverVersionEntries(self: *Self, allocator: std.mem.Allocator, input: get_ipam_prefix_list_resolver_version_entries.GetIpamPrefixListResolverVersionEntriesInput, options: CallOptions) !get_ipam_prefix_list_resolver_version_entries.GetIpamPrefixListResolverVersionEntriesOutput {
        return get_ipam_prefix_list_resolver_version_entries.execute(self, allocator, input, options);
    }

    /// Retrieves version information for an IPAM prefix list resolver.
    ///
    /// Each version is a snapshot of what CIDRs matched your rules at that moment
    /// in time. The version number increments every time the CIDR list
    /// changes due to infrastructure changes.
    ///
    /// **Version example:**
    ///
    /// **Initial State (Version 1)**
    ///
    /// Production environment:
    ///
    /// * vpc-prod-web (10.1.0.0/16) - tagged env=prod
    ///
    /// * vpc-prod-db (10.2.0.0/16) - tagged env=prod
    ///
    /// Resolver rule: Include all VPCs tagged env=prod
    ///
    /// **Version 1 CIDRs:** 10.1.0.0/16, 10.2.0.0/16
    ///
    /// **Infrastructure Change (Version 2)**
    ///
    /// New VPC added:
    ///
    /// * vpc-prod-api (10.3.0.0/16) - tagged env=prod
    ///
    /// IPAM automatically detects the change and creates a new version.
    ///
    /// **Version 2 CIDRs:** 10.1.0.0/16, 10.2.0.0/16, 10.3.0.0/16
    pub fn getIpamPrefixListResolverVersions(self: *Self, allocator: std.mem.Allocator, input: get_ipam_prefix_list_resolver_versions.GetIpamPrefixListResolverVersionsInput, options: CallOptions) !get_ipam_prefix_list_resolver_versions.GetIpamPrefixListResolverVersionsOutput {
        return get_ipam_prefix_list_resolver_versions.execute(self, allocator, input, options);
    }

    /// Returns resource CIDRs managed by IPAM in a given scope. If an IPAM is
    /// associated with more than one resource discovery, the resource CIDRs across
    /// all of the resource discoveries is returned. A resource discovery is an IPAM
    /// component that enables IPAM to manage and monitor resources that belong to
    /// the owning account.
    pub fn getIpamResourceCidrs(self: *Self, allocator: std.mem.Allocator, input: get_ipam_resource_cidrs.GetIpamResourceCidrsInput, options: CallOptions) !get_ipam_resource_cidrs.GetIpamResourceCidrsOutput {
        return get_ipam_resource_cidrs.execute(self, allocator, input, options);
    }

    /// Retrieves the configuration data of the specified instance. You can use this
    /// data to
    /// create a launch template.
    ///
    /// This action calls on other describe actions to get instance information.
    /// Depending on
    /// your instance configuration, you may need to allow the following actions in
    /// your IAM
    /// policy: `DescribeSpotInstanceRequests`,
    /// `DescribeInstanceCreditSpecifications`, `DescribeVolumes`, and
    /// `DescribeInstanceAttribute`.
    /// Or, you can allow `describe*` depending on your instance requirements.
    pub fn getLaunchTemplateData(self: *Self, allocator: std.mem.Allocator, input: get_launch_template_data.GetLaunchTemplateDataInput, options: CallOptions) !get_launch_template_data.GetLaunchTemplateDataOutput {
        return get_launch_template_data.execute(self, allocator, input, options);
    }

    /// Gets information about the resources that are associated with the specified
    /// managed prefix list.
    pub fn getManagedPrefixListAssociations(self: *Self, allocator: std.mem.Allocator, input: get_managed_prefix_list_associations.GetManagedPrefixListAssociationsInput, options: CallOptions) !get_managed_prefix_list_associations.GetManagedPrefixListAssociationsOutput {
        return get_managed_prefix_list_associations.execute(self, allocator, input, options);
    }

    /// Gets information about the entries for a specified managed prefix list.
    pub fn getManagedPrefixListEntries(self: *Self, allocator: std.mem.Allocator, input: get_managed_prefix_list_entries.GetManagedPrefixListEntriesInput, options: CallOptions) !get_managed_prefix_list_entries.GetManagedPrefixListEntriesOutput {
        return get_managed_prefix_list_entries.execute(self, allocator, input, options);
    }

    /// Gets the findings for the specified Network Access Scope analysis.
    pub fn getNetworkInsightsAccessScopeAnalysisFindings(self: *Self, allocator: std.mem.Allocator, input: get_network_insights_access_scope_analysis_findings.GetNetworkInsightsAccessScopeAnalysisFindingsInput, options: CallOptions) !get_network_insights_access_scope_analysis_findings.GetNetworkInsightsAccessScopeAnalysisFindingsOutput {
        return get_network_insights_access_scope_analysis_findings.execute(self, allocator, input, options);
    }

    /// Gets the content for the specified Network Access Scope.
    pub fn getNetworkInsightsAccessScopeContent(self: *Self, allocator: std.mem.Allocator, input: get_network_insights_access_scope_content.GetNetworkInsightsAccessScopeContentInput, options: CallOptions) !get_network_insights_access_scope_content.GetNetworkInsightsAccessScopeContentOutput {
        return get_network_insights_access_scope_content.execute(self, allocator, input, options);
    }

    /// Retrieves the encrypted administrator password for a running Windows
    /// instance.
    ///
    /// The Windows password is generated at boot by the `EC2Config` service or
    /// `EC2Launch` scripts (Windows Server 2016 and later). This usually only
    /// happens the first time an instance is launched. For more information, see
    /// [EC2Config](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/UsingConfig_WinAMI.html) and [EC2Launch](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2launch.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// For the `EC2Config` service, the password is not generated for rebundled
    /// AMIs unless `Ec2SetPassword` is enabled before bundling.
    ///
    /// The password is encrypted using the key pair that you specified when you
    /// launched the
    /// instance. You must provide the corresponding key pair file.
    ///
    /// When you launch an instance, password generation and encryption may take a
    /// few
    /// minutes. If you try to retrieve the password before it's available, the
    /// output returns
    /// an empty string. We recommend that you wait up to 15 minutes after launching
    /// an instance
    /// before trying to retrieve the generated password.
    pub fn getPasswordData(self: *Self, allocator: std.mem.Allocator, input: get_password_data.GetPasswordDataInput, options: CallOptions) !get_password_data.GetPasswordDataOutput {
        return get_password_data.execute(self, allocator, input, options);
    }

    /// Returns a quote and exchange information for exchanging one or more
    /// specified Convertible
    /// Reserved Instances for a new Convertible Reserved Instance. If the exchange
    /// cannot be
    /// performed, the reason is returned in the response. Use
    /// AcceptReservedInstancesExchangeQuote to perform the exchange.
    pub fn getReservedInstancesExchangeQuote(self: *Self, allocator: std.mem.Allocator, input: get_reserved_instances_exchange_quote.GetReservedInstancesExchangeQuoteInput, options: CallOptions) !get_reserved_instances_exchange_quote.GetReservedInstancesExchangeQuoteOutput {
        return get_reserved_instances_exchange_quote.execute(self, allocator, input, options);
    }

    /// Gets information about the associations for the specified route server.
    ///
    /// A route server association is the connection established between a route
    /// server and a VPC.
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn getRouteServerAssociations(self: *Self, allocator: std.mem.Allocator, input: get_route_server_associations.GetRouteServerAssociationsInput, options: CallOptions) !get_route_server_associations.GetRouteServerAssociationsOutput {
        return get_route_server_associations.execute(self, allocator, input, options);
    }

    /// Gets information about the route propagations for the specified route
    /// server.
    ///
    /// When enabled, route server propagation installs the routes in the FIB on the
    /// route table you've specified. Route server supports IPv4 and IPv6 route
    /// propagation.
    ///
    /// Amazon VPC Route Server simplifies routing for traffic between workloads
    /// that are deployed within a VPC and its internet gateways. With this feature,
    /// VPC Route Server dynamically updates VPC and internet gateway route tables
    /// with your preferred IPv4 or IPv6 routes to achieve routing fault tolerance
    /// for those workloads. This enables you to automatically reroute traffic
    /// within a VPC, which increases the manageability of VPC routing and
    /// interoperability with third-party workloads.
    ///
    /// Route server supports the follow route table types:
    ///
    /// * VPC route tables not associated with subnets
    ///
    /// * Subnet route tables
    ///
    /// * Internet gateway route tables
    ///
    /// Route server does not support route tables associated with virtual private
    /// gateways. To propagate routes into a transit gateway route table, use
    /// [Transit Gateway
    /// Connect](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html).
    pub fn getRouteServerPropagations(self: *Self, allocator: std.mem.Allocator, input: get_route_server_propagations.GetRouteServerPropagationsInput, options: CallOptions) !get_route_server_propagations.GetRouteServerPropagationsOutput {
        return get_route_server_propagations.execute(self, allocator, input, options);
    }

    /// Gets the routing database for the specified route server. The [Routing
    /// Information Base (RIB)](https://en.wikipedia.org/wiki/Routing_table) serves
    /// as a database that stores all the routing information and network topology
    /// data collected by a router or routing system, such as routes learned from
    /// BGP peers. The RIB is constantly updated as new routing information is
    /// received or existing routes change. This ensures that the route server
    /// always has the most current view of the network topology and can make
    /// optimal routing decisions.
    ///
    /// Amazon VPC Route Server simplifies routing for traffic between workloads
    /// that are deployed within a VPC and its internet gateways. With this feature,
    /// VPC Route Server dynamically updates VPC and internet gateway route tables
    /// with your preferred IPv4 or IPv6 routes to achieve routing fault tolerance
    /// for those workloads. This enables you to automatically reroute traffic
    /// within a VPC, which increases the manageability of VPC routing and
    /// interoperability with third-party workloads.
    ///
    /// Route server supports the follow route table types:
    ///
    /// * VPC route tables not associated with subnets
    ///
    /// * Subnet route tables
    ///
    /// * Internet gateway route tables
    ///
    /// Route server does not support route tables associated with virtual private
    /// gateways. To propagate routes into a transit gateway route table, use
    /// [Transit Gateway
    /// Connect](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html).
    pub fn getRouteServerRoutingDatabase(self: *Self, allocator: std.mem.Allocator, input: get_route_server_routing_database.GetRouteServerRoutingDatabaseInput, options: CallOptions) !get_route_server_routing_database.GetRouteServerRoutingDatabaseOutput {
        return get_route_server_routing_database.execute(self, allocator, input, options);
    }

    /// Gets security groups that can be associated by the Amazon Web Services
    /// account making the request with network interfaces in the specified VPC.
    pub fn getSecurityGroupsForVpc(self: *Self, allocator: std.mem.Allocator, input: get_security_groups_for_vpc.GetSecurityGroupsForVpcInput, options: CallOptions) !get_security_groups_for_vpc.GetSecurityGroupsForVpcOutput {
        return get_security_groups_for_vpc.execute(self, allocator, input, options);
    }

    /// Retrieves the access status of your account to the EC2 serial console of all
    /// instances. By
    /// default, access to the EC2 serial console is disabled for your account. For
    /// more
    /// information, see [Manage account access to the EC2 serial
    /// console](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configure-access-to-serial-console.html#serial-console-account-access) in the *Amazon EC2
    /// User Guide*.
    pub fn getSerialConsoleAccessStatus(self: *Self, allocator: std.mem.Allocator, input: get_serial_console_access_status.GetSerialConsoleAccessStatusInput, options: CallOptions) !get_serial_console_access_status.GetSerialConsoleAccessStatusOutput {
        return get_serial_console_access_status.execute(self, allocator, input, options);
    }

    /// Gets the current state of *block public access for snapshots* setting
    /// for the account and Region.
    ///
    /// For more information, see [
    /// Block public access for
    /// snapshots](https://docs.aws.amazon.com/ebs/latest/userguide/block-public-access-snapshots.html) in the *Amazon EBS User Guide*.
    pub fn getSnapshotBlockPublicAccessState(self: *Self, allocator: std.mem.Allocator, input: get_snapshot_block_public_access_state.GetSnapshotBlockPublicAccessStateInput, options: CallOptions) !get_snapshot_block_public_access_state.GetSnapshotBlockPublicAccessStateOutput {
        return get_snapshot_block_public_access_state.execute(self, allocator, input, options);
    }

    /// Calculates the Spot placement score for a Region or Availability Zone based
    /// on the
    /// specified target capacity and compute requirements.
    ///
    /// You can specify your compute requirements either by using
    /// `InstanceRequirementsWithMetadata` and letting Amazon EC2 choose the optimal
    /// instance types to fulfill your Spot request, or you can specify the instance
    /// types by using
    /// `InstanceTypes`.
    ///
    /// For more information, see [Spot placement
    /// score](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-placement-score.html) in
    /// the *Amazon EC2 User Guide*.
    pub fn getSpotPlacementScores(self: *Self, allocator: std.mem.Allocator, input: get_spot_placement_scores.GetSpotPlacementScoresInput, options: CallOptions) !get_spot_placement_scores.GetSpotPlacementScoresOutput {
        return get_spot_placement_scores.execute(self, allocator, input, options);
    }

    /// Gets information about the subnet CIDR reservations.
    pub fn getSubnetCidrReservations(self: *Self, allocator: std.mem.Allocator, input: get_subnet_cidr_reservations.GetSubnetCidrReservationsInput, options: CallOptions) !get_subnet_cidr_reservations.GetSubnetCidrReservationsOutput {
        return get_subnet_cidr_reservations.execute(self, allocator, input, options);
    }

    /// Lists the route tables to which the specified resource attachment propagates
    /// routes.
    pub fn getTransitGatewayAttachmentPropagations(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_attachment_propagations.GetTransitGatewayAttachmentPropagationsInput, options: CallOptions) !get_transit_gateway_attachment_propagations.GetTransitGatewayAttachmentPropagationsOutput {
        return get_transit_gateway_attachment_propagations.execute(self, allocator, input, options);
    }

    /// Retrieves the entries for a transit gateway metering policy.
    pub fn getTransitGatewayMeteringPolicyEntries(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_metering_policy_entries.GetTransitGatewayMeteringPolicyEntriesInput, options: CallOptions) !get_transit_gateway_metering_policy_entries.GetTransitGatewayMeteringPolicyEntriesOutput {
        return get_transit_gateway_metering_policy_entries.execute(self, allocator, input, options);
    }

    /// Gets information about the associations for the transit gateway multicast
    /// domain.
    pub fn getTransitGatewayMulticastDomainAssociations(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_multicast_domain_associations.GetTransitGatewayMulticastDomainAssociationsInput, options: CallOptions) !get_transit_gateway_multicast_domain_associations.GetTransitGatewayMulticastDomainAssociationsOutput {
        return get_transit_gateway_multicast_domain_associations.execute(self, allocator, input, options);
    }

    /// Gets a list of the transit gateway policy table associations.
    pub fn getTransitGatewayPolicyTableAssociations(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_policy_table_associations.GetTransitGatewayPolicyTableAssociationsInput, options: CallOptions) !get_transit_gateway_policy_table_associations.GetTransitGatewayPolicyTableAssociationsOutput {
        return get_transit_gateway_policy_table_associations.execute(self, allocator, input, options);
    }

    /// Returns a list of transit gateway policy table entries.
    pub fn getTransitGatewayPolicyTableEntries(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_policy_table_entries.GetTransitGatewayPolicyTableEntriesInput, options: CallOptions) !get_transit_gateway_policy_table_entries.GetTransitGatewayPolicyTableEntriesOutput {
        return get_transit_gateway_policy_table_entries.execute(self, allocator, input, options);
    }

    /// Gets information about the prefix list references in a specified transit
    /// gateway route table.
    pub fn getTransitGatewayPrefixListReferences(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_prefix_list_references.GetTransitGatewayPrefixListReferencesInput, options: CallOptions) !get_transit_gateway_prefix_list_references.GetTransitGatewayPrefixListReferencesOutput {
        return get_transit_gateway_prefix_list_references.execute(self, allocator, input, options);
    }

    /// Gets information about the associations for the specified transit gateway
    /// route table.
    pub fn getTransitGatewayRouteTableAssociations(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_route_table_associations.GetTransitGatewayRouteTableAssociationsInput, options: CallOptions) !get_transit_gateway_route_table_associations.GetTransitGatewayRouteTableAssociationsOutput {
        return get_transit_gateway_route_table_associations.execute(self, allocator, input, options);
    }

    /// Gets information about the route table propagations for the specified
    /// transit gateway route table.
    pub fn getTransitGatewayRouteTablePropagations(self: *Self, allocator: std.mem.Allocator, input: get_transit_gateway_route_table_propagations.GetTransitGatewayRouteTablePropagationsInput, options: CallOptions) !get_transit_gateway_route_table_propagations.GetTransitGatewayRouteTablePropagationsOutput {
        return get_transit_gateway_route_table_propagations.execute(self, allocator, input, options);
    }

    /// Get the Verified Access policy associated with the endpoint.
    pub fn getVerifiedAccessEndpointPolicy(self: *Self, allocator: std.mem.Allocator, input: get_verified_access_endpoint_policy.GetVerifiedAccessEndpointPolicyInput, options: CallOptions) !get_verified_access_endpoint_policy.GetVerifiedAccessEndpointPolicyOutput {
        return get_verified_access_endpoint_policy.execute(self, allocator, input, options);
    }

    /// Gets the targets for the specified network CIDR endpoint for Verified
    /// Access.
    pub fn getVerifiedAccessEndpointTargets(self: *Self, allocator: std.mem.Allocator, input: get_verified_access_endpoint_targets.GetVerifiedAccessEndpointTargetsInput, options: CallOptions) !get_verified_access_endpoint_targets.GetVerifiedAccessEndpointTargetsOutput {
        return get_verified_access_endpoint_targets.execute(self, allocator, input, options);
    }

    /// Shows the contents of the Verified Access policy associated with the group.
    pub fn getVerifiedAccessGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: get_verified_access_group_policy.GetVerifiedAccessGroupPolicyInput, options: CallOptions) !get_verified_access_group_policy.GetVerifiedAccessGroupPolicyOutput {
        return get_verified_access_group_policy.execute(self, allocator, input, options);
    }

    /// Gets information about resources in a VPC that are blocking encryption
    /// enforcement.
    ///
    /// For more information, see [Enforce VPC encryption in
    /// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
    pub fn getVpcResourcesBlockingEncryptionEnforcement(self: *Self, allocator: std.mem.Allocator, input: get_vpc_resources_blocking_encryption_enforcement.GetVpcResourcesBlockingEncryptionEnforcementInput, options: CallOptions) !get_vpc_resources_blocking_encryption_enforcement.GetVpcResourcesBlockingEncryptionEnforcementOutput {
        return get_vpc_resources_blocking_encryption_enforcement.execute(self, allocator, input, options);
    }

    /// Download an Amazon Web Services-provided sample configuration file to be
    /// used with the customer
    /// gateway device specified for your Site-to-Site VPN connection.
    pub fn getVpnConnectionDeviceSampleConfiguration(self: *Self, allocator: std.mem.Allocator, input: get_vpn_connection_device_sample_configuration.GetVpnConnectionDeviceSampleConfigurationInput, options: CallOptions) !get_vpn_connection_device_sample_configuration.GetVpnConnectionDeviceSampleConfigurationOutput {
        return get_vpn_connection_device_sample_configuration.execute(self, allocator, input, options);
    }

    /// Obtain a list of customer gateway devices for which sample configuration
    /// files can be provided. The request has no additional parameters. You can
    /// also see the
    /// list of device types with sample configuration files available under [Your
    /// customer gateway
    /// device](https://docs.aws.amazon.com/vpn/latest/s2svpn/your-cgw.html) in the
    /// *Amazon Web Services Site-to-Site VPN User Guide*.
    pub fn getVpnConnectionDeviceTypes(self: *Self, allocator: std.mem.Allocator, input: get_vpn_connection_device_types.GetVpnConnectionDeviceTypesInput, options: CallOptions) !get_vpn_connection_device_types.GetVpnConnectionDeviceTypesOutput {
        return get_vpn_connection_device_types.execute(self, allocator, input, options);
    }

    /// Get details of available tunnel endpoint maintenance.
    pub fn getVpnTunnelReplacementStatus(self: *Self, allocator: std.mem.Allocator, input: get_vpn_tunnel_replacement_status.GetVpnTunnelReplacementStatusInput, options: CallOptions) !get_vpn_tunnel_replacement_status.GetVpnTunnelReplacementStatusOutput {
        return get_vpn_tunnel_replacement_status.execute(self, allocator, input, options);
    }

    /// Uploads a client certificate revocation list to the specified Client VPN
    /// endpoint. Uploading a client certificate revocation list overwrites the
    /// existing client certificate revocation list.
    ///
    /// Uploading a client certificate revocation list resets existing client
    /// connections.
    pub fn importClientVpnClientCertificateRevocationList(self: *Self, allocator: std.mem.Allocator, input: import_client_vpn_client_certificate_revocation_list.ImportClientVpnClientCertificateRevocationListInput, options: CallOptions) !import_client_vpn_client_certificate_revocation_list.ImportClientVpnClientCertificateRevocationListOutput {
        return import_client_vpn_client_certificate_revocation_list.execute(self, allocator, input, options);
    }

    /// To import your virtual machines (VMs) with a console-based experience, you
    /// can use the
    /// *Import virtual machine images to Amazon Web Services* template in the
    /// [Migration Hub Orchestrator
    /// console](https://console.aws.amazon.com/migrationhub/orchestrator). For more
    /// information, see the [
    /// *Migration Hub Orchestrator User Guide*
    /// ](https://docs.aws.amazon.com/migrationhub-orchestrator/latest/userguide/import-vm-images.html).
    ///
    /// Import single or multi-volume disk images or EBS snapshots into an Amazon
    /// Machine Image (AMI).
    ///
    /// Amazon Web Services VM Import/Export strongly recommends specifying a value
    /// for either the
    /// `--license-type` or `--usage-operation` parameter when you create a new
    /// VM Import task. This ensures your operating system is licensed appropriately
    /// and your billing is
    /// optimized.
    ///
    /// For more information, see [Importing a
    /// VM as an image using VM
    /// Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html) in the *VM Import/Export User Guide*.
    pub fn importImage(self: *Self, allocator: std.mem.Allocator, input: import_image.ImportImageInput, options: CallOptions) !import_image.ImportImageOutput {
        return import_image.execute(self, allocator, input, options);
    }

    /// We recommend that you use the [
    /// `ImportImage`
    /// ](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ImportImage.html)
    /// API instead. For more information, see [Importing a VM as an image using VM
    /// Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-image-import.html) in the *VM Import/Export User Guide*.
    ///
    /// Creates an import instance task using metadata from the specified disk
    /// image.
    ///
    /// This API action supports only single-volume VMs. To import multi-volume VMs,
    /// use ImportImage
    /// instead.
    ///
    /// For information about the import manifest referenced by this API action, see
    /// [VM Import
    /// Manifest](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/manifest.html).
    ///
    /// This API action is not supported by the Command Line Interface (CLI).
    pub fn importInstance(self: *Self, allocator: std.mem.Allocator, input: import_instance.ImportInstanceInput, options: CallOptions) !import_instance.ImportInstanceOutput {
        return import_instance.execute(self, allocator, input, options);
    }

    /// Imports the public key from an RSA or ED25519 key pair that you created
    /// using a third-party tool.
    /// You give Amazon Web Services only the public key. The private key is never
    /// transferred between you and Amazon Web Services.
    ///
    /// For more information about the requirements for importing a key pair, see
    /// [Create a key pair and import the public key to Amazon
    /// EC2](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/create-key-pairs.html#how-to-generate-your-own-key-and-import-it-to-aws) in the *Amazon EC2 User Guide*.
    pub fn importKeyPair(self: *Self, allocator: std.mem.Allocator, input: import_key_pair.ImportKeyPairInput, options: CallOptions) !import_key_pair.ImportKeyPairOutput {
        return import_key_pair.execute(self, allocator, input, options);
    }

    /// Imports a disk into an EBS snapshot.
    ///
    /// For more information, see [Importing a disk as a snapshot using VM
    /// Import/Export](https://docs.aws.amazon.com/vm-import/latest/userguide/vmimport-import-snapshot.html) in the
    /// *VM Import/Export User Guide*.
    pub fn importSnapshot(self: *Self, allocator: std.mem.Allocator, input: import_snapshot.ImportSnapshotInput, options: CallOptions) !import_snapshot.ImportSnapshotOutput {
        return import_snapshot.execute(self, allocator, input, options);
    }

    /// This API action supports only single-volume VMs. To import multi-volume VMs,
    /// use
    /// ImportImage instead. To import a disk to a snapshot, use
    /// ImportSnapshot instead.
    ///
    /// Creates an import volume task using metadata from the specified disk image.
    ///
    /// For information about the import manifest referenced by this API action, see
    /// [VM Import
    /// Manifest](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/manifest.html).
    ///
    /// This API action is not supported by the Command Line Interface (CLI).
    pub fn importVolume(self: *Self, allocator: std.mem.Allocator, input: import_volume.ImportVolumeInput, options: CallOptions) !import_volume.ImportVolumeOutput {
        return import_volume.execute(self, allocator, input, options);
    }

    /// Lists one or more AMIs that are currently in the Recycle Bin. For more
    /// information, see
    /// [Recycle
    /// Bin](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recycle-bin.html)
    /// in the *Amazon EC2 User Guide*.
    pub fn listImagesInRecycleBin(self: *Self, allocator: std.mem.Allocator, input: list_images_in_recycle_bin.ListImagesInRecycleBinInput, options: CallOptions) !list_images_in_recycle_bin.ListImagesInRecycleBinOutput {
        return list_images_in_recycle_bin.execute(self, allocator, input, options);
    }

    /// Lists one or more snapshots that are currently in the Recycle Bin.
    pub fn listSnapshotsInRecycleBin(self: *Self, allocator: std.mem.Allocator, input: list_snapshots_in_recycle_bin.ListSnapshotsInRecycleBinInput, options: CallOptions) !list_snapshots_in_recycle_bin.ListSnapshotsInRecycleBinOutput {
        return list_snapshots_in_recycle_bin.execute(self, allocator, input, options);
    }

    /// Lists one or more volumes that are currently in the Recycle Bin.
    pub fn listVolumesInRecycleBin(self: *Self, allocator: std.mem.Allocator, input: list_volumes_in_recycle_bin.ListVolumesInRecycleBinInput, options: CallOptions) !list_volumes_in_recycle_bin.ListVolumesInRecycleBinOutput {
        return list_volumes_in_recycle_bin.execute(self, allocator, input, options);
    }

    /// Locks an Amazon EBS snapshot in either *governance* or *compliance*
    /// mode to protect it against accidental or malicious deletions for a specific
    /// duration. A locked snapshot
    /// can't be deleted.
    ///
    /// You can also use this action to modify the lock settings for a snapshot that
    /// is already locked. The
    /// allowed modifications depend on the lock mode and lock state:
    ///
    /// * If the snapshot is locked in governance mode, you can modify the lock mode
    ///   and the lock duration
    /// or lock expiration date.
    ///
    /// * If the snapshot is locked in compliance mode and it is in the cooling-off
    ///   period, you can modify
    /// the lock mode and the lock duration or lock expiration date.
    ///
    /// * If the snapshot is locked in compliance mode and the cooling-off period
    ///   has lapsed, you can
    /// only increase the lock duration or extend the lock expiration date.
    pub fn lockSnapshot(self: *Self, allocator: std.mem.Allocator, input: lock_snapshot.LockSnapshotInput, options: CallOptions) !lock_snapshot.LockSnapshotOutput {
        return lock_snapshot.execute(self, allocator, input, options);
    }

    /// Modifies an attribute of the specified Elastic IP address. For requirements,
    /// see [Using reverse DNS for email
    /// applications](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#Using_Elastic_Addressing_Reverse_DNS).
    pub fn modifyAddressAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_address_attribute.ModifyAddressAttributeInput, options: CallOptions) !modify_address_attribute.ModifyAddressAttributeOutput {
        return modify_address_attribute.execute(self, allocator, input, options);
    }

    /// Changes the opt-in status of the specified zone group for your account.
    pub fn modifyAvailabilityZoneGroup(self: *Self, allocator: std.mem.Allocator, input: modify_availability_zone_group.ModifyAvailabilityZoneGroupInput, options: CallOptions) !modify_availability_zone_group.ModifyAvailabilityZoneGroupOutput {
        return modify_availability_zone_group.execute(self, allocator, input, options);
    }

    /// Modifies a Capacity Reservation's capacity, instance eligibility, and the
    /// conditions
    /// under which it is to be released. You can't modify a Capacity Reservation's
    /// instance
    /// type, EBS optimization, platform, instance store settings, Availability
    /// Zone, or
    /// tenancy. If you need to modify any of these attributes, we recommend that
    /// you cancel the
    /// Capacity Reservation, and then create a new one with the required
    /// attributes. For more
    /// information, see [ Modify an active
    /// Capacity
    /// Reservation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/capacity-reservations-modify.html).
    ///
    /// The allowed modifications depend on the state of the Capacity Reservation:
    ///
    /// * `assessing` or `scheduled` state - You can modify the
    /// tags only.
    ///
    /// * `pending` state - You can't modify the Capacity Reservation in any
    /// way.
    ///
    /// * `active` state but still within the commitment duration - You can't
    /// decrease the instance count or set an end date that is within the commitment
    /// duration. All other modifications are allowed.
    ///
    /// * `active` state with no commitment duration or elapsed commitment
    /// duration - All modifications are allowed.
    ///
    /// * `expired`, `cancelled`, `unsupported`, or
    /// `failed` state - You can't modify the Capacity Reservation in any
    /// way.
    pub fn modifyCapacityReservation(self: *Self, allocator: std.mem.Allocator, input: modify_capacity_reservation.ModifyCapacityReservationInput, options: CallOptions) !modify_capacity_reservation.ModifyCapacityReservationOutput {
        return modify_capacity_reservation.execute(self, allocator, input, options);
    }

    /// Modifies a Capacity Reservation Fleet.
    ///
    /// When you modify the total target capacity of a Capacity Reservation Fleet,
    /// the Fleet
    /// automatically creates new Capacity Reservations, or modifies or cancels
    /// existing
    /// Capacity Reservations in the Fleet to meet the new total target capacity.
    /// When you
    /// modify the end date for the Fleet, the end dates for all of the individual
    /// Capacity
    /// Reservations in the Fleet are updated accordingly.
    pub fn modifyCapacityReservationFleet(self: *Self, allocator: std.mem.Allocator, input: modify_capacity_reservation_fleet.ModifyCapacityReservationFleetInput, options: CallOptions) !modify_capacity_reservation_fleet.ModifyCapacityReservationFleetOutput {
        return modify_capacity_reservation_fleet.execute(self, allocator, input, options);
    }

    /// Modifies the specified Client VPN endpoint. Modifying the DNS server resets
    /// existing client connections.
    pub fn modifyClientVpnEndpoint(self: *Self, allocator: std.mem.Allocator, input: modify_client_vpn_endpoint.ModifyClientVpnEndpointInput, options: CallOptions) !modify_client_vpn_endpoint.ModifyClientVpnEndpointOutput {
        return modify_client_vpn_endpoint.execute(self, allocator, input, options);
    }

    /// Modifies the default credit option for CPU usage of burstable performance
    /// instances.
    /// The default credit option is set at the account level per Amazon Web
    /// Services Region, and
    /// is specified per instance family. All new burstable performance instances in
    /// the account
    /// launch using the default credit option.
    ///
    /// `ModifyDefaultCreditSpecification` is an asynchronous operation, which
    /// works at an Amazon Web Services Region level and modifies the credit option
    /// for each
    /// Availability Zone. All zones in a Region are updated within five minutes.
    /// But if
    /// instances are launched during this operation, they might not get the new
    /// credit option
    /// until the zone is updated. To verify whether the update has occurred, you
    /// can call
    /// `GetDefaultCreditSpecification` and check
    /// `DefaultCreditSpecification` for updates.
    ///
    /// For more information, see [Burstable
    /// performance
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html) in the *Amazon EC2 User Guide*.
    pub fn modifyDefaultCreditSpecification(self: *Self, allocator: std.mem.Allocator, input: modify_default_credit_specification.ModifyDefaultCreditSpecificationInput, options: CallOptions) !modify_default_credit_specification.ModifyDefaultCreditSpecificationOutput {
        return modify_default_credit_specification.execute(self, allocator, input, options);
    }

    /// Changes the default KMS key for EBS encryption by default for your account
    /// in this Region.
    ///
    /// Amazon Web Services creates a unique Amazon Web Services managed KMS key in
    /// each Region for use with encryption by default. If
    /// you change the default KMS key to a symmetric customer managed KMS key, it
    /// is used instead of the Amazon Web Services
    /// managed KMS key. Amazon EBS does not support asymmetric KMS keys.
    ///
    /// If you delete or disable the customer managed KMS key that you specified for
    /// use with
    /// encryption by default, your instances will fail to launch.
    ///
    /// For more information, see [Amazon EBS
    /// encryption](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption.html)
    /// in the *Amazon EBS User Guide*.
    pub fn modifyEbsDefaultKmsKeyId(self: *Self, allocator: std.mem.Allocator, input: modify_ebs_default_kms_key_id.ModifyEbsDefaultKmsKeyIdInput, options: CallOptions) !modify_ebs_default_kms_key_id.ModifyEbsDefaultKmsKeyIdOutput {
        return modify_ebs_default_kms_key_id.execute(self, allocator, input, options);
    }

    /// Modifies the specified EC2 Fleet.
    ///
    /// You can only modify an EC2 Fleet request of type `maintain`.
    ///
    /// While the EC2 Fleet is being modified, it is in the `modifying` state.
    ///
    /// To scale up your EC2 Fleet, increase its target capacity. The EC2 Fleet
    /// launches the additional
    /// Spot Instances according to the allocation strategy for the EC2 Fleet
    /// request. If the allocation
    /// strategy is `lowest-price`, the EC2 Fleet launches instances using the Spot
    /// Instance
    /// pool with the lowest price. If the allocation strategy is `diversified`, the
    /// EC2 Fleet distributes the instances across the Spot Instance pools. If the
    /// allocation strategy
    /// is `capacity-optimized`, EC2 Fleet launches instances from Spot Instance
    /// pools with optimal
    /// capacity for the number of instances that are launching.
    ///
    /// To scale down your EC2 Fleet, decrease its target capacity. First, the EC2
    /// Fleet cancels any open
    /// requests that exceed the new target capacity. You can request that the EC2
    /// Fleet terminate Spot
    /// Instances until the size of the fleet no longer exceeds the new target
    /// capacity. If the
    /// allocation strategy is `lowest-price`, the EC2 Fleet terminates the
    /// instances with
    /// the highest price per unit. If the allocation strategy is
    /// `capacity-optimized`,
    /// the EC2 Fleet terminates the instances in the Spot Instance pools that have
    /// the least available
    /// Spot Instance capacity. If the allocation strategy is `diversified`, the EC2
    /// Fleet terminates
    /// instances across the Spot Instance pools. Alternatively, you can request
    /// that the EC2 Fleet keep
    /// the fleet at its current size, but not replace any Spot Instances that are
    /// interrupted or
    /// that you terminate manually.
    ///
    /// If you are finished with your EC2 Fleet for now, but will use it again
    /// later, you can set the
    /// target capacity to 0.
    pub fn modifyFleet(self: *Self, allocator: std.mem.Allocator, input: modify_fleet.ModifyFleetInput, options: CallOptions) !modify_fleet.ModifyFleetOutput {
        return modify_fleet.execute(self, allocator, input, options);
    }

    /// Modifies the specified attribute of the specified Amazon FPGA Image (AFI).
    pub fn modifyFpgaImageAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_fpga_image_attribute.ModifyFpgaImageAttributeInput, options: CallOptions) !modify_fpga_image_attribute.ModifyFpgaImageAttributeOutput {
        return modify_fpga_image_attribute.execute(self, allocator, input, options);
    }

    /// Modify the auto-placement setting of a Dedicated Host. When auto-placement
    /// is enabled,
    /// any instances that you launch with a tenancy of `host` but without a
    /// specific
    /// host ID are placed onto any available Dedicated Host in your account that
    /// has
    /// auto-placement enabled. When auto-placement is disabled, you need to provide
    /// a host ID
    /// to have the instance launch onto a specific host. If no host ID is provided,
    /// the
    /// instance is launched onto a suitable host with auto-placement enabled.
    ///
    /// You can also use this API action to modify a Dedicated Host to support
    /// either multiple
    /// instance types in an instance family, or to support a specific instance type
    /// only.
    pub fn modifyHosts(self: *Self, allocator: std.mem.Allocator, input: modify_hosts.ModifyHostsInput, options: CallOptions) !modify_hosts.ModifyHostsOutput {
        return modify_hosts.execute(self, allocator, input, options);
    }

    /// Modifies the ID format for the specified resource on a per-Region basis. You
    /// can
    /// specify that resources should receive longer IDs (17-character IDs) when
    /// they are
    /// created.
    ///
    /// This request can only be used to modify longer ID settings for resource
    /// types that
    /// are within the opt-in period. Resources currently in their opt-in period
    /// include:
    /// `bundle` | `conversion-task` | `customer-gateway` | `dhcp-options` |
    /// `elastic-ip-allocation` | `elastic-ip-association` |
    /// `export-task` | `flow-log` | `image` |
    /// `import-task` | `internet-gateway` | `network-acl`
    /// | `network-acl-association` | `network-interface` |
    /// `network-interface-attachment` | `prefix-list` |
    /// `route-table` | `route-table-association` |
    /// `security-group` | `subnet` |
    /// `subnet-cidr-block-association` | `vpc` |
    /// `vpc-cidr-block-association` | `vpc-endpoint` | `vpc-peering-connection` |
    /// `vpn-connection` | `vpn-gateway`.
    ///
    /// This setting applies to the IAM user who makes the request; it does not
    /// apply to the
    /// entire Amazon Web Services account. By default, an IAM user defaults to the
    /// same settings as the root user. If
    /// you're using this action as the root user, then these settings apply to the
    /// entire account,
    /// unless an IAM user explicitly overrides these settings for themselves. For
    /// more information,
    /// see [Resource
    /// IDs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/resource-ids.html)
    /// in the *Amazon Elastic Compute Cloud User Guide*.
    ///
    /// Resources created with longer IDs are visible to all IAM roles and users,
    /// regardless
    /// of these settings and provided that they have permission to use the relevant
    /// `Describe` command for the resource type.
    pub fn modifyIdFormat(self: *Self, allocator: std.mem.Allocator, input: modify_id_format.ModifyIdFormatInput, options: CallOptions) !modify_id_format.ModifyIdFormatOutput {
        return modify_id_format.execute(self, allocator, input, options);
    }

    /// Modifies the ID format of a resource for a specified IAM user, IAM role, or
    /// the root
    /// user for an account; or all IAM users, IAM roles, and the root user for an
    /// account. You can
    /// specify that resources should receive longer IDs (17-character IDs) when
    /// they are created.
    ///
    /// This request can only be used to modify longer ID settings for resource
    /// types that are
    /// within the opt-in period. Resources currently in their opt-in period
    /// include:
    /// `bundle` | `conversion-task` | `customer-gateway` | `dhcp-options` |
    /// `elastic-ip-allocation` | `elastic-ip-association` |
    /// `export-task` | `flow-log` | `image` |
    /// `import-task` | `internet-gateway` | `network-acl`
    /// | `network-acl-association` | `network-interface` |
    /// `network-interface-attachment` | `prefix-list` |
    /// `route-table` | `route-table-association` |
    /// `security-group` | `subnet` |
    /// `subnet-cidr-block-association` | `vpc` |
    /// `vpc-cidr-block-association` | `vpc-endpoint` | `vpc-peering-connection` |
    /// `vpn-connection` | `vpn-gateway`.
    ///
    /// For more information, see [Resource
    /// IDs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/resource-ids.html)
    /// in the
    /// *Amazon Elastic Compute Cloud User Guide*.
    ///
    /// This setting applies to the principal specified in the request; it does not
    /// apply to the
    /// principal that makes the request.
    ///
    /// Resources created with longer IDs are visible to all IAM roles and users,
    /// regardless of these
    /// settings and provided that they have permission to use the relevant
    /// `Describe`
    /// command for the resource type.
    pub fn modifyIdentityIdFormat(self: *Self, allocator: std.mem.Allocator, input: modify_identity_id_format.ModifyIdentityIdFormatInput, options: CallOptions) !modify_identity_id_format.ModifyIdentityIdFormatOutput {
        return modify_identity_id_format.execute(self, allocator, input, options);
    }

    /// Modifies the specified attribute of the specified AMI. You can specify only
    /// one attribute
    /// at a time.
    ///
    /// To specify the attribute, you can use the `Attribute` parameter, or one of
    /// the
    /// following parameters: `Description`, `ImdsSupport`, or
    /// `LaunchPermission`.
    ///
    /// Images with an Amazon Web Services Marketplace product code cannot be made
    /// public.
    ///
    /// To enable the SriovNetSupport enhanced networking attribute of an image,
    /// enable
    /// SriovNetSupport on an instance and create an AMI from the instance.
    pub fn modifyImageAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_image_attribute.ModifyImageAttributeInput, options: CallOptions) !modify_image_attribute.ModifyImageAttributeOutput {
        return modify_image_attribute.execute(self, allocator, input, options);
    }

    /// Modifies the specified attribute of the specified instance. You can specify
    /// only one
    /// attribute at a time.
    ///
    /// **Note: **Using this action to change the security groups
    /// associated with an elastic network interface (ENI) attached to an instance
    /// can
    /// result in an error if the instance has more than one ENI. To change the
    /// security groups
    /// associated with an ENI attached to an instance that has multiple ENIs, we
    /// recommend that
    /// you use the ModifyNetworkInterfaceAttribute action.
    ///
    /// To modify some attributes, the instance must be stopped. For more
    /// information, see
    /// [Modify a stopped
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_ChangingAttributesWhileInstanceStopped.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn modifyInstanceAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_instance_attribute.ModifyInstanceAttributeInput, options: CallOptions) !modify_instance_attribute.ModifyInstanceAttributeOutput {
        return modify_instance_attribute.execute(self, allocator, input, options);
    }

    /// Modifies the Capacity Reservation settings for a stopped instance. Use this
    /// action to
    /// configure an instance to target a specific Capacity Reservation, run in any
    /// `open` Capacity Reservation with matching attributes, run in On-Demand
    /// Instance capacity, or only run in a Capacity Reservation.
    pub fn modifyInstanceCapacityReservationAttributes(self: *Self, allocator: std.mem.Allocator, input: modify_instance_capacity_reservation_attributes.ModifyInstanceCapacityReservationAttributesInput, options: CallOptions) !modify_instance_capacity_reservation_attributes.ModifyInstanceCapacityReservationAttributesOutput {
        return modify_instance_capacity_reservation_attributes.execute(self, allocator, input, options);
    }

    /// Modifies the specified EC2 Instance Connect Endpoint.
    ///
    /// For more information, see [Modify an
    /// EC2 Instance Connect
    /// Endpoint](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/modify-ec2-instance-connect-endpoint.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn modifyInstanceConnectEndpoint(self: *Self, allocator: std.mem.Allocator, input: modify_instance_connect_endpoint.ModifyInstanceConnectEndpointInput, options: CallOptions) !modify_instance_connect_endpoint.ModifyInstanceConnectEndpointOutput {
        return modify_instance_connect_endpoint.execute(self, allocator, input, options);
    }

    /// By default, all vCPUs for the instance type are active when you launch an
    /// instance. When you
    /// configure the number of active vCPUs for the instance, it can help you save
    /// on licensing costs and
    /// optimize performance. The base cost of the instance remains unchanged.
    ///
    /// The number of active vCPUs equals the number of threads per CPU core
    /// multiplied by the number
    /// of cores. The instance must be in a `Stopped` state before you make changes.
    ///
    /// Some instance type options do not support this capability. For more
    /// information, see
    /// [Supported CPU
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/cpu-options-supported-instances-values.html) in the *Amazon EC2 User Guide*.
    pub fn modifyInstanceCpuOptions(self: *Self, allocator: std.mem.Allocator, input: modify_instance_cpu_options.ModifyInstanceCpuOptionsInput, options: CallOptions) !modify_instance_cpu_options.ModifyInstanceCpuOptionsOutput {
        return modify_instance_cpu_options.execute(self, allocator, input, options);
    }

    /// Modifies the credit option for CPU usage on a running or stopped burstable
    /// performance
    /// instance. The credit options are `standard` and
    /// `unlimited`.
    ///
    /// For more information, see [Burstable
    /// performance
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/burstable-performance-instances.html) in the *Amazon EC2 User Guide*.
    pub fn modifyInstanceCreditSpecification(self: *Self, allocator: std.mem.Allocator, input: modify_instance_credit_specification.ModifyInstanceCreditSpecificationInput, options: CallOptions) !modify_instance_credit_specification.ModifyInstanceCreditSpecificationOutput {
        return modify_instance_credit_specification.execute(self, allocator, input, options);
    }

    /// Modifies the start time for a scheduled Amazon EC2 instance event.
    pub fn modifyInstanceEventStartTime(self: *Self, allocator: std.mem.Allocator, input: modify_instance_event_start_time.ModifyInstanceEventStartTimeInput, options: CallOptions) !modify_instance_event_start_time.ModifyInstanceEventStartTimeOutput {
        return modify_instance_event_start_time.execute(self, allocator, input, options);
    }

    /// Modifies the specified event window.
    ///
    /// You can define either a set of time ranges or a cron expression when
    /// modifying the event
    /// window, but not both.
    ///
    /// To modify the targets associated with the event window, use the
    /// AssociateInstanceEventWindow and DisassociateInstanceEventWindow API.
    ///
    /// If Amazon Web Services has already scheduled an event, modifying an event
    /// window won't change the time
    /// of the scheduled event.
    ///
    /// For more information, see [Define event windows for scheduled
    /// events](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/event-windows.html) in the *Amazon EC2 User Guide*.
    pub fn modifyInstanceEventWindow(self: *Self, allocator: std.mem.Allocator, input: modify_instance_event_window.ModifyInstanceEventWindowInput, options: CallOptions) !modify_instance_event_window.ModifyInstanceEventWindowOutput {
        return modify_instance_event_window.execute(self, allocator, input, options);
    }

    /// Modifies the recovery behavior of your instance to disable simplified
    /// automatic
    /// recovery or set the recovery behavior to default. The default configuration
    /// will not
    /// enable simplified automatic recovery for an unsupported instance type. For
    /// more
    /// information, see [Simplified automatic
    /// recovery](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-recover.html#instance-configuration-recovery).
    ///
    /// Modifies the reboot migration behavior during a user-initiated reboot of an
    /// instance
    /// that has a pending `system-reboot` event. For more information, see [Enable
    /// or disable reboot
    /// migration](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/schedevents_actions_reboot.html#reboot-migration).
    pub fn modifyInstanceMaintenanceOptions(self: *Self, allocator: std.mem.Allocator, input: modify_instance_maintenance_options.ModifyInstanceMaintenanceOptionsInput, options: CallOptions) !modify_instance_maintenance_options.ModifyInstanceMaintenanceOptionsOutput {
        return modify_instance_maintenance_options.execute(self, allocator, input, options);
    }

    /// Modifies the default instance metadata service (IMDS) settings at the
    /// account level in
    /// the specified Amazon Web Services  Region.
    ///
    /// To remove a parameter's account-level default setting, specify
    /// `no-preference`. If an account-level setting is cleared with
    /// `no-preference`, then the instance launch considers the other
    /// instance metadata settings. For more information, see [Order of precedence
    /// for instance metadata
    /// options](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-options.html#instance-metadata-options-order-of-precedence) in the
    /// *Amazon EC2 User Guide*.
    pub fn modifyInstanceMetadataDefaults(self: *Self, allocator: std.mem.Allocator, input: modify_instance_metadata_defaults.ModifyInstanceMetadataDefaultsInput, options: CallOptions) !modify_instance_metadata_defaults.ModifyInstanceMetadataDefaultsOutput {
        return modify_instance_metadata_defaults.execute(self, allocator, input, options);
    }

    /// Modify the instance metadata parameters on a running or stopped instance.
    /// When you
    /// modify the parameters on a stopped instance, they are applied when the
    /// instance is
    /// started. When you modify the parameters on a running instance, the API
    /// responds with a
    /// state of “pending”. After the parameter modifications are successfully
    /// applied to the
    /// instance, the state of the modifications changes from “pending” to “applied”
    /// in
    /// subsequent describe-instances API calls. For more information, see [Instance
    /// metadata and user
    /// data](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-metadata.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn modifyInstanceMetadataOptions(self: *Self, allocator: std.mem.Allocator, input: modify_instance_metadata_options.ModifyInstanceMetadataOptionsInput, options: CallOptions) !modify_instance_metadata_options.ModifyInstanceMetadataOptionsOutput {
        return modify_instance_metadata_options.execute(self, allocator, input, options);
    }

    /// Change the configuration of the network performance options for an existing
    /// instance.
    pub fn modifyInstanceNetworkPerformanceOptions(self: *Self, allocator: std.mem.Allocator, input: modify_instance_network_performance_options.ModifyInstanceNetworkPerformanceOptionsInput, options: CallOptions) !modify_instance_network_performance_options.ModifyInstanceNetworkPerformanceOptionsOutput {
        return modify_instance_network_performance_options.execute(self, allocator, input, options);
    }

    /// Modifies the placement attributes for a specified instance. You can do the
    /// following:
    ///
    /// * Modify the affinity between an instance and a [Dedicated
    /// Host](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-hosts-overview.html). When affinity is set to `host` and the instance is
    /// not associated with a specific Dedicated Host, the next time the instance is
    /// started, it is automatically associated with the host on which it lands. If
    /// the
    /// instance is restarted or rebooted, this relationship persists.
    ///
    /// * Change the Dedicated Host with which an instance is associated.
    ///
    /// * Change the instance tenancy of an instance.
    ///
    /// * Move an instance to or from a [placement
    /// group](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/placement-groups.html).
    ///
    /// At least one attribute for affinity, host ID, tenancy, or placement group
    /// name must be
    /// specified in the request. Affinity and tenancy can be modified in the same
    /// request.
    ///
    /// To modify the host ID, tenancy, placement group, or partition for an
    /// instance, the
    /// instance must be in the `stopped` state.
    pub fn modifyInstancePlacement(self: *Self, allocator: std.mem.Allocator, input: modify_instance_placement.ModifyInstancePlacementInput, options: CallOptions) !modify_instance_placement.ModifyInstancePlacementOutput {
        return modify_instance_placement.execute(self, allocator, input, options);
    }

    /// Modify the configurations of an IPAM.
    pub fn modifyIpam(self: *Self, allocator: std.mem.Allocator, input: modify_ipam.ModifyIpamInput, options: CallOptions) !modify_ipam.ModifyIpamOutput {
        return modify_ipam.execute(self, allocator, input, options);
    }

    /// Modifies the allocation rules in an IPAM policy.
    ///
    /// An IPAM policy is a set of rules that define how public IPv4 addresses from
    /// IPAM pools are allocated to Amazon Web Services resources. Each rule maps an
    /// Amazon Web Services service to IPAM pools that the service will use to get
    /// IP addresses. A single policy can have multiple rules and be applied to
    /// multiple Amazon Web Services Regions. If the IPAM pool run out of addresses
    /// then the services fallback to Amazon-provided IP addresses. A policy can be
    /// applied to an individual Amazon Web Services account or an entity within
    /// Amazon Web Services Organizations.
    ///
    /// Allocation rules are optional configurations within an IPAM policy that map
    /// Amazon Web Services resource types to specific IPAM pools. If no rules are
    /// defined, the resource types default to using Amazon-provided IP addresses.
    pub fn modifyIpamPolicyAllocationRules(self: *Self, allocator: std.mem.Allocator, input: modify_ipam_policy_allocation_rules.ModifyIpamPolicyAllocationRulesInput, options: CallOptions) !modify_ipam_policy_allocation_rules.ModifyIpamPolicyAllocationRulesOutput {
        return modify_ipam_policy_allocation_rules.execute(self, allocator, input, options);
    }

    /// Modify the configurations of an IPAM pool.
    ///
    /// For more information, see [Modify a
    /// pool](https://docs.aws.amazon.com/vpc/latest/ipam/mod-pool-ipam.html) in the
    /// *Amazon VPC IPAM User Guide*.
    pub fn modifyIpamPool(self: *Self, allocator: std.mem.Allocator, input: modify_ipam_pool.ModifyIpamPoolInput, options: CallOptions) !modify_ipam_pool.ModifyIpamPoolOutput {
        return modify_ipam_pool.execute(self, allocator, input, options);
    }

    /// Modifies an IPAM prefix list resolver. You can update the description and
    /// CIDR selection rules. Changes to rules will trigger re-evaluation and
    /// potential updates to associated prefix lists.
    pub fn modifyIpamPrefixListResolver(self: *Self, allocator: std.mem.Allocator, input: modify_ipam_prefix_list_resolver.ModifyIpamPrefixListResolverInput, options: CallOptions) !modify_ipam_prefix_list_resolver.ModifyIpamPrefixListResolverOutput {
        return modify_ipam_prefix_list_resolver.execute(self, allocator, input, options);
    }

    /// Modifies an IPAM prefix list resolver target. You can update version
    /// tracking settings and the desired version of the target prefix list.
    pub fn modifyIpamPrefixListResolverTarget(self: *Self, allocator: std.mem.Allocator, input: modify_ipam_prefix_list_resolver_target.ModifyIpamPrefixListResolverTargetInput, options: CallOptions) !modify_ipam_prefix_list_resolver_target.ModifyIpamPrefixListResolverTargetOutput {
        return modify_ipam_prefix_list_resolver_target.execute(self, allocator, input, options);
    }

    /// Modify a resource CIDR. You can use this action to transfer resource CIDRs
    /// between scopes and ignore resource CIDRs that you do not want to manage. If
    /// set to false, the resource will not be tracked for overlap, it cannot be
    /// auto-imported into a pool, and it will be removed from any pool it has an
    /// allocation in.
    ///
    /// For more information, see [Move resource CIDRs between
    /// scopes](https://docs.aws.amazon.com/vpc/latest/ipam/move-resource-ipam.html)
    /// and [Change the monitoring state of resource
    /// CIDRs](https://docs.aws.amazon.com/vpc/latest/ipam/change-monitoring-state-ipam.html) in the *Amazon VPC IPAM User Guide*.
    pub fn modifyIpamResourceCidr(self: *Self, allocator: std.mem.Allocator, input: modify_ipam_resource_cidr.ModifyIpamResourceCidrInput, options: CallOptions) !modify_ipam_resource_cidr.ModifyIpamResourceCidrOutput {
        return modify_ipam_resource_cidr.execute(self, allocator, input, options);
    }

    /// Modifies a resource discovery. A resource discovery is an IPAM component
    /// that enables IPAM to manage and monitor resources that belong to the owning
    /// account.
    pub fn modifyIpamResourceDiscovery(self: *Self, allocator: std.mem.Allocator, input: modify_ipam_resource_discovery.ModifyIpamResourceDiscoveryInput, options: CallOptions) !modify_ipam_resource_discovery.ModifyIpamResourceDiscoveryOutput {
        return modify_ipam_resource_discovery.execute(self, allocator, input, options);
    }

    /// Modify an IPAM scope.
    pub fn modifyIpamScope(self: *Self, allocator: std.mem.Allocator, input: modify_ipam_scope.ModifyIpamScopeInput, options: CallOptions) !modify_ipam_scope.ModifyIpamScopeOutput {
        return modify_ipam_scope.execute(self, allocator, input, options);
    }

    /// Modifies a launch template. You can specify which version of the launch
    /// template to
    /// set as the default version. When launching an instance, the default version
    /// applies when
    /// a launch template version is not specified.
    pub fn modifyLaunchTemplate(self: *Self, allocator: std.mem.Allocator, input: modify_launch_template.ModifyLaunchTemplateInput, options: CallOptions) !modify_launch_template.ModifyLaunchTemplateOutput {
        return modify_launch_template.execute(self, allocator, input, options);
    }

    /// Modifies the specified local gateway route.
    pub fn modifyLocalGatewayRoute(self: *Self, allocator: std.mem.Allocator, input: modify_local_gateway_route.ModifyLocalGatewayRouteInput, options: CallOptions) !modify_local_gateway_route.ModifyLocalGatewayRouteOutput {
        return modify_local_gateway_route.execute(self, allocator, input, options);
    }

    /// Modifies the specified managed prefix list.
    ///
    /// Adding or removing entries in a prefix list creates a new version of the
    /// prefix list.
    /// Changing the name of the prefix list does not affect the version.
    ///
    /// If you specify a current version number that does not match the true current
    /// version
    /// number, the request fails.
    pub fn modifyManagedPrefixList(self: *Self, allocator: std.mem.Allocator, input: modify_managed_prefix_list.ModifyManagedPrefixListInput, options: CallOptions) !modify_managed_prefix_list.ModifyManagedPrefixListOutput {
        return modify_managed_prefix_list.execute(self, allocator, input, options);
    }

    /// Modifies the specified network interface attribute. You can specify only one
    /// attribute
    /// at a time. You can use this action to attach and detach security groups from
    /// an existing
    /// EC2 instance.
    pub fn modifyNetworkInterfaceAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_network_interface_attribute.ModifyNetworkInterfaceAttributeInput, options: CallOptions) !modify_network_interface_attribute.ModifyNetworkInterfaceAttributeOutput {
        return modify_network_interface_attribute.execute(self, allocator, input, options);
    }

    /// Modifies the options for instance hostnames for the specified instance.
    pub fn modifyPrivateDnsNameOptions(self: *Self, allocator: std.mem.Allocator, input: modify_private_dns_name_options.ModifyPrivateDnsNameOptionsInput, options: CallOptions) !modify_private_dns_name_options.ModifyPrivateDnsNameOptionsOutput {
        return modify_private_dns_name_options.execute(self, allocator, input, options);
    }

    /// Modify public hostname options for a network interface. For more
    /// information, see [EC2 instance hostnames, DNS names, and
    /// domains](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-naming.html) in the *Amazon EC2 User Guide*.
    pub fn modifyPublicIpDnsNameOptions(self: *Self, allocator: std.mem.Allocator, input: modify_public_ip_dns_name_options.ModifyPublicIpDnsNameOptionsInput, options: CallOptions) !modify_public_ip_dns_name_options.ModifyPublicIpDnsNameOptionsOutput {
        return modify_public_ip_dns_name_options.execute(self, allocator, input, options);
    }

    /// Modifies the configuration of your Reserved Instances, such as the
    /// Availability Zone,
    /// instance count, or instance type. The Reserved Instances to be modified must
    /// be identical,
    /// except for Availability Zone, network platform, and instance type.
    ///
    /// For more information, see [Modify Reserved
    /// Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-modifying.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn modifyReservedInstances(self: *Self, allocator: std.mem.Allocator, input: modify_reserved_instances.ModifyReservedInstancesInput, options: CallOptions) !modify_reserved_instances.ModifyReservedInstancesOutput {
        return modify_reserved_instances.execute(self, allocator, input, options);
    }

    /// Modifies the configuration of an existing route server.
    ///
    /// Amazon VPC Route Server simplifies routing for traffic between workloads
    /// that are deployed within a VPC and its internet gateways. With this feature,
    /// VPC Route Server dynamically updates VPC and internet gateway route tables
    /// with your preferred IPv4 or IPv6 routes to achieve routing fault tolerance
    /// for those workloads. This enables you to automatically reroute traffic
    /// within a VPC, which increases the manageability of VPC routing and
    /// interoperability with third-party workloads.
    ///
    /// Route server supports the follow route table types:
    ///
    /// * VPC route tables not associated with subnets
    ///
    /// * Subnet route tables
    ///
    /// * Internet gateway route tables
    ///
    /// Route server does not support route tables associated with virtual private
    /// gateways. To propagate routes into a transit gateway route table, use
    /// [Transit Gateway
    /// Connect](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-connect.html).
    ///
    /// For more information see [Dynamic routing in your VPC with VPC Route
    /// Server](https://docs.aws.amazon.com/vpc/latest/userguide/dynamic-routing-route-server.html) in the *Amazon VPC User Guide*.
    pub fn modifyRouteServer(self: *Self, allocator: std.mem.Allocator, input: modify_route_server.ModifyRouteServerInput, options: CallOptions) !modify_route_server.ModifyRouteServerOutput {
        return modify_route_server.execute(self, allocator, input, options);
    }

    /// Modifies the rules of a security group.
    pub fn modifySecurityGroupRules(self: *Self, allocator: std.mem.Allocator, input: modify_security_group_rules.ModifySecurityGroupRulesInput, options: CallOptions) !modify_security_group_rules.ModifySecurityGroupRulesOutput {
        return modify_security_group_rules.execute(self, allocator, input, options);
    }

    /// Adds or removes permission settings for the specified snapshot. You may add
    /// or remove
    /// specified Amazon Web Services account IDs from a snapshot's list of create
    /// volume permissions, but you cannot
    /// do both in a single operation. If you need to both add and remove account
    /// IDs for a snapshot,
    /// you must use multiple operations. You can make up to 500 modifications to a
    /// snapshot in a single operation.
    ///
    /// Encrypted snapshots and snapshots with Amazon Web Services Marketplace
    /// product codes cannot be made
    /// public. Snapshots encrypted with your default KMS key cannot be shared with
    /// other accounts.
    ///
    /// For more information about modifying snapshot permissions, see [Share a
    /// snapshot](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-modifying-snapshot-permissions.html) in the
    /// *Amazon EBS User Guide*.
    pub fn modifySnapshotAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_snapshot_attribute.ModifySnapshotAttributeInput, options: CallOptions) !modify_snapshot_attribute.ModifySnapshotAttributeOutput {
        return modify_snapshot_attribute.execute(self, allocator, input, options);
    }

    /// Archives an Amazon EBS snapshot. When you archive a snapshot, it is
    /// converted to a full
    /// snapshot that includes all of the blocks of data that were written to the
    /// volume at the
    /// time the snapshot was created, and moved from the standard tier to the
    /// archive
    /// tier. For more information, see [Archive Amazon EBS
    /// snapshots](https://docs.aws.amazon.com/ebs/latest/userguide/snapshot-archive.html)
    /// in the *Amazon EBS User Guide*.
    pub fn modifySnapshotTier(self: *Self, allocator: std.mem.Allocator, input: modify_snapshot_tier.ModifySnapshotTierInput, options: CallOptions) !modify_snapshot_tier.ModifySnapshotTierOutput {
        return modify_snapshot_tier.execute(self, allocator, input, options);
    }

    /// Modifies the specified Spot Fleet request.
    ///
    /// You can only modify a Spot Fleet request of type `maintain`.
    ///
    /// While the Spot Fleet request is being modified, it is in the `modifying`
    /// state.
    ///
    /// To scale up your Spot Fleet, increase its target capacity. The Spot Fleet
    /// launches the
    /// additional Spot Instances according to the allocation strategy for the Spot
    /// Fleet
    /// request. If the allocation strategy is `lowestPrice`, the Spot Fleet
    /// launches
    /// instances using the Spot Instance pool with the lowest price. If the
    /// allocation strategy
    /// is `diversified`, the Spot Fleet distributes the instances across the Spot
    /// Instance pools. If the allocation strategy is `capacityOptimized`, Spot
    /// Fleet
    /// launches instances from Spot Instance pools with optimal capacity for the
    /// number of instances
    /// that are launching.
    ///
    /// To scale down your Spot Fleet, decrease its target capacity. First, the Spot
    /// Fleet
    /// cancels any open requests that exceed the new target capacity. You can
    /// request that the
    /// Spot Fleet terminate Spot Instances until the size of the fleet no longer
    /// exceeds the
    /// new target capacity. If the allocation strategy is `lowestPrice`, the Spot
    /// Fleet terminates the instances with the highest price per unit. If the
    /// allocation
    /// strategy is `capacityOptimized`, the Spot Fleet terminates the instances in
    /// the Spot Instance pools that have the least available Spot Instance
    /// capacity. If the allocation
    /// strategy is `diversified`, the Spot Fleet terminates instances across the
    /// Spot Instance pools. Alternatively, you can request that the Spot Fleet keep
    /// the fleet
    /// at its current size, but not replace any Spot Instances that are interrupted
    /// or that you
    /// terminate manually.
    ///
    /// If you are finished with your Spot Fleet for now, but will use it again
    /// later, you can
    /// set the target capacity to 0.
    pub fn modifySpotFleetRequest(self: *Self, allocator: std.mem.Allocator, input: modify_spot_fleet_request.ModifySpotFleetRequestInput, options: CallOptions) !modify_spot_fleet_request.ModifySpotFleetRequestOutput {
        return modify_spot_fleet_request.execute(self, allocator, input, options);
    }

    /// Modifies a subnet attribute. You can only modify one attribute at a time.
    ///
    /// Use this action to modify subnets on Amazon Web Services Outposts.
    ///
    /// * To modify a subnet on an Outpost rack, set both
    /// `MapCustomerOwnedIpOnLaunch` and
    /// `CustomerOwnedIpv4Pool`. These two parameters act as a single
    /// attribute.
    ///
    /// * To modify a subnet on an Outpost server, set either
    /// `EnableLniAtDeviceIndex` or
    /// `DisableLniAtDeviceIndex`.
    ///
    /// For more information about Amazon Web Services Outposts, see the following:
    ///
    /// * [Outpost
    ///   servers](https://docs.aws.amazon.com/outposts/latest/userguide/how-servers-work.html)
    ///
    /// * [Outpost
    ///   racks](https://docs.aws.amazon.com/outposts/latest/userguide/how-racks-work.html)
    pub fn modifySubnetAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_subnet_attribute.ModifySubnetAttributeInput, options: CallOptions) !modify_subnet_attribute.ModifySubnetAttributeOutput {
        return modify_subnet_attribute.execute(self, allocator, input, options);
    }

    /// Allows or restricts mirroring network services.
    ///
    /// By default, Amazon DNS network services are not eligible for Traffic Mirror.
    /// Use `AddNetworkServices` to add network services to a Traffic Mirror filter.
    /// When a network service is added to the Traffic Mirror filter, all traffic
    /// related to that network service will be mirrored.
    /// When you no longer want to mirror network services, use
    /// `RemoveNetworkServices` to remove the network services from the Traffic
    /// Mirror filter.
    pub fn modifyTrafficMirrorFilterNetworkServices(self: *Self, allocator: std.mem.Allocator, input: modify_traffic_mirror_filter_network_services.ModifyTrafficMirrorFilterNetworkServicesInput, options: CallOptions) !modify_traffic_mirror_filter_network_services.ModifyTrafficMirrorFilterNetworkServicesOutput {
        return modify_traffic_mirror_filter_network_services.execute(self, allocator, input, options);
    }

    /// Modifies the specified Traffic Mirror rule.
    ///
    /// `DestinationCidrBlock` and `SourceCidrBlock` must both be an IPv4
    /// range or an IPv6 range.
    pub fn modifyTrafficMirrorFilterRule(self: *Self, allocator: std.mem.Allocator, input: modify_traffic_mirror_filter_rule.ModifyTrafficMirrorFilterRuleInput, options: CallOptions) !modify_traffic_mirror_filter_rule.ModifyTrafficMirrorFilterRuleOutput {
        return modify_traffic_mirror_filter_rule.execute(self, allocator, input, options);
    }

    /// Modifies a Traffic Mirror session.
    pub fn modifyTrafficMirrorSession(self: *Self, allocator: std.mem.Allocator, input: modify_traffic_mirror_session.ModifyTrafficMirrorSessionInput, options: CallOptions) !modify_traffic_mirror_session.ModifyTrafficMirrorSessionOutput {
        return modify_traffic_mirror_session.execute(self, allocator, input, options);
    }

    /// Modifies the specified transit gateway. When you modify a transit gateway,
    /// the modified options are applied to new transit gateway attachments only.
    /// Your existing transit gateway attachments are not modified.
    pub fn modifyTransitGateway(self: *Self, allocator: std.mem.Allocator, input: modify_transit_gateway.ModifyTransitGatewayInput, options: CallOptions) !modify_transit_gateway.ModifyTransitGatewayOutput {
        return modify_transit_gateway.execute(self, allocator, input, options);
    }

    /// Modifies a transit gateway metering policy.
    pub fn modifyTransitGatewayMeteringPolicy(self: *Self, allocator: std.mem.Allocator, input: modify_transit_gateway_metering_policy.ModifyTransitGatewayMeteringPolicyInput, options: CallOptions) !modify_transit_gateway_metering_policy.ModifyTransitGatewayMeteringPolicyOutput {
        return modify_transit_gateway_metering_policy.execute(self, allocator, input, options);
    }

    /// Modifies a reference (route) to a prefix list in a specified transit gateway
    /// route table.
    pub fn modifyTransitGatewayPrefixListReference(self: *Self, allocator: std.mem.Allocator, input: modify_transit_gateway_prefix_list_reference.ModifyTransitGatewayPrefixListReferenceInput, options: CallOptions) !modify_transit_gateway_prefix_list_reference.ModifyTransitGatewayPrefixListReferenceOutput {
        return modify_transit_gateway_prefix_list_reference.execute(self, allocator, input, options);
    }

    /// Modifies the specified VPC attachment.
    pub fn modifyTransitGatewayVpcAttachment(self: *Self, allocator: std.mem.Allocator, input: modify_transit_gateway_vpc_attachment.ModifyTransitGatewayVpcAttachmentInput, options: CallOptions) !modify_transit_gateway_vpc_attachment.ModifyTransitGatewayVpcAttachmentOutput {
        return modify_transit_gateway_vpc_attachment.execute(self, allocator, input, options);
    }

    /// Modifies the configuration of the specified Amazon Web Services Verified
    /// Access endpoint.
    pub fn modifyVerifiedAccessEndpoint(self: *Self, allocator: std.mem.Allocator, input: modify_verified_access_endpoint.ModifyVerifiedAccessEndpointInput, options: CallOptions) !modify_verified_access_endpoint.ModifyVerifiedAccessEndpointOutput {
        return modify_verified_access_endpoint.execute(self, allocator, input, options);
    }

    /// Modifies the specified Amazon Web Services Verified Access endpoint policy.
    pub fn modifyVerifiedAccessEndpointPolicy(self: *Self, allocator: std.mem.Allocator, input: modify_verified_access_endpoint_policy.ModifyVerifiedAccessEndpointPolicyInput, options: CallOptions) !modify_verified_access_endpoint_policy.ModifyVerifiedAccessEndpointPolicyOutput {
        return modify_verified_access_endpoint_policy.execute(self, allocator, input, options);
    }

    /// Modifies the specified Amazon Web Services Verified Access group
    /// configuration.
    pub fn modifyVerifiedAccessGroup(self: *Self, allocator: std.mem.Allocator, input: modify_verified_access_group.ModifyVerifiedAccessGroupInput, options: CallOptions) !modify_verified_access_group.ModifyVerifiedAccessGroupOutput {
        return modify_verified_access_group.execute(self, allocator, input, options);
    }

    /// Modifies the specified Amazon Web Services Verified Access group policy.
    pub fn modifyVerifiedAccessGroupPolicy(self: *Self, allocator: std.mem.Allocator, input: modify_verified_access_group_policy.ModifyVerifiedAccessGroupPolicyInput, options: CallOptions) !modify_verified_access_group_policy.ModifyVerifiedAccessGroupPolicyOutput {
        return modify_verified_access_group_policy.execute(self, allocator, input, options);
    }

    /// Modifies the configuration of the specified Amazon Web Services Verified
    /// Access instance.
    pub fn modifyVerifiedAccessInstance(self: *Self, allocator: std.mem.Allocator, input: modify_verified_access_instance.ModifyVerifiedAccessInstanceInput, options: CallOptions) !modify_verified_access_instance.ModifyVerifiedAccessInstanceOutput {
        return modify_verified_access_instance.execute(self, allocator, input, options);
    }

    /// Modifies the logging configuration for the specified Amazon Web Services
    /// Verified Access instance.
    pub fn modifyVerifiedAccessInstanceLoggingConfiguration(self: *Self, allocator: std.mem.Allocator, input: modify_verified_access_instance_logging_configuration.ModifyVerifiedAccessInstanceLoggingConfigurationInput, options: CallOptions) !modify_verified_access_instance_logging_configuration.ModifyVerifiedAccessInstanceLoggingConfigurationOutput {
        return modify_verified_access_instance_logging_configuration.execute(self, allocator, input, options);
    }

    /// Modifies the configuration of the specified Amazon Web Services Verified
    /// Access trust provider.
    pub fn modifyVerifiedAccessTrustProvider(self: *Self, allocator: std.mem.Allocator, input: modify_verified_access_trust_provider.ModifyVerifiedAccessTrustProviderInput, options: CallOptions) !modify_verified_access_trust_provider.ModifyVerifiedAccessTrustProviderOutput {
        return modify_verified_access_trust_provider.execute(self, allocator, input, options);
    }

    /// You can modify several parameters of an existing EBS volume, including
    /// volume size, volume
    /// type, and IOPS capacity. If your EBS volume is attached to a
    /// current-generation EC2 instance
    /// type, you might be able to apply these changes without stopping the instance
    /// or detaching the
    /// volume from it. For more information about modifying EBS volumes, see
    /// [Amazon EBS Elastic
    /// Volumes](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-modify-volume.html)
    /// in the *Amazon EBS User Guide*.
    ///
    /// When you complete a resize operation on your volume, you need to extend the
    /// volume's
    /// file-system size to take advantage of the new storage capacity. For more
    /// information, see [Extend the file
    /// system](https://docs.aws.amazon.com/ebs/latest/userguide/recognize-expanded-volume-linux.html).
    ///
    /// For more information, see [Monitor the progress of volume
    /// modifications](https://docs.aws.amazon.com/ebs/latest/userguide/monitoring-volume-modifications.html) in the *Amazon EBS User Guide*.
    ///
    /// With previous-generation instance types, resizing an EBS volume might
    /// require detaching and
    /// reattaching the volume or stopping and restarting the instance.
    ///
    /// After you initiate a volume modification, you must wait for that
    /// modification to reach the
    /// `completed` state before you can initiate another modification for the same
    /// volume.
    /// You can modify a volume up to four times within a rolling 24-hour period, as
    /// long as the volume
    /// is in the `in-use` or `available` state, and all previous modifications
    /// for that volume are `completed`. If you exceed this limit, you get an error
    /// message
    /// that indicates when you can perform your next modification.
    pub fn modifyVolume(self: *Self, allocator: std.mem.Allocator, input: modify_volume.ModifyVolumeInput, options: CallOptions) !modify_volume.ModifyVolumeOutput {
        return modify_volume.execute(self, allocator, input, options);
    }

    /// Modifies a volume attribute.
    ///
    /// By default, all I/O operations for the volume are suspended when the data on
    /// the volume is
    /// determined to be potentially inconsistent, to prevent undetectable, latent
    /// data corruption.
    /// The I/O access to the volume can be resumed by first enabling I/O access and
    /// then checking the
    /// data consistency on your volume.
    ///
    /// You can change the default behavior to resume I/O operations. We recommend
    /// that you change
    /// this only for boot volumes or for volumes that are stateless or disposable.
    pub fn modifyVolumeAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_volume_attribute.ModifyVolumeAttributeInput, options: CallOptions) !modify_volume_attribute.ModifyVolumeAttributeOutput {
        return modify_volume_attribute.execute(self, allocator, input, options);
    }

    /// Modifies the specified attribute of the specified VPC.
    pub fn modifyVpcAttribute(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_attribute.ModifyVpcAttributeInput, options: CallOptions) !modify_vpc_attribute.ModifyVpcAttributeOutput {
        return modify_vpc_attribute.execute(self, allocator, input, options);
    }

    /// Modify VPC Block Public Access (BPA) exclusions. A VPC BPA exclusion is a
    /// mode that can be applied to a single VPC or subnet that exempts it from the
    /// account’s BPA mode and will allow bidirectional or egress-only access. You
    /// can create BPA exclusions for VPCs and subnets even when BPA is not enabled
    /// on the account to ensure that there is no traffic disruption to the
    /// exclusions when VPC BPA is turned on.
    pub fn modifyVpcBlockPublicAccessExclusion(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_block_public_access_exclusion.ModifyVpcBlockPublicAccessExclusionInput, options: CallOptions) !modify_vpc_block_public_access_exclusion.ModifyVpcBlockPublicAccessExclusionOutput {
        return modify_vpc_block_public_access_exclusion.execute(self, allocator, input, options);
    }

    /// Modify VPC Block Public Access (BPA) options. VPC Block Public Access (BPA)
    /// enables you to block resources in VPCs and subnets that you own in a Region
    /// from reaching or being reached from the internet through internet gateways
    /// and egress-only internet gateways. To learn more about VPC BPA, see [Block
    /// public access to VPCs and
    /// subnets](https://docs.aws.amazon.com/vpc/latest/userguide/security-vpc-bpa.html) in the *Amazon VPC User Guide*.
    pub fn modifyVpcBlockPublicAccessOptions(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_block_public_access_options.ModifyVpcBlockPublicAccessOptionsInput, options: CallOptions) !modify_vpc_block_public_access_options.ModifyVpcBlockPublicAccessOptionsOutput {
        return modify_vpc_block_public_access_options.execute(self, allocator, input, options);
    }

    /// Modifies the encryption control configuration for a VPC. You can update the
    /// encryption mode and exclusion settings for various gateway types and peering
    /// connections.
    ///
    /// For more information, see [Enforce VPC encryption in
    /// transit](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-encryption-controls.html) in the *Amazon VPC User Guide*.
    pub fn modifyVpcEncryptionControl(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_encryption_control.ModifyVpcEncryptionControlInput, options: CallOptions) !modify_vpc_encryption_control.ModifyVpcEncryptionControlOutput {
        return modify_vpc_encryption_control.execute(self, allocator, input, options);
    }

    /// Modifies attributes of a specified VPC endpoint. The attributes that you can
    /// modify
    /// depend on the type of VPC endpoint (interface, gateway, or Gateway Load
    /// Balancer). For more information,
    /// see the [Amazon Web Services PrivateLink
    /// Guide](https://docs.aws.amazon.com/vpc/latest/privatelink/).
    pub fn modifyVpcEndpoint(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_endpoint.ModifyVpcEndpointInput, options: CallOptions) !modify_vpc_endpoint.ModifyVpcEndpointOutput {
        return modify_vpc_endpoint.execute(self, allocator, input, options);
    }

    /// Modifies a connection notification for VPC endpoint or VPC endpoint service.
    /// You
    /// can change the SNS topic for the notification, or the events for which to be
    /// notified.
    pub fn modifyVpcEndpointConnectionNotification(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_endpoint_connection_notification.ModifyVpcEndpointConnectionNotificationInput, options: CallOptions) !modify_vpc_endpoint_connection_notification.ModifyVpcEndpointConnectionNotificationOutput {
        return modify_vpc_endpoint_connection_notification.execute(self, allocator, input, options);
    }

    /// Modifies the attributes of the specified VPC endpoint service configuration.
    ///
    /// If you set or modify the private DNS name, you must prove that you own the
    /// private DNS
    /// domain name.
    pub fn modifyVpcEndpointServiceConfiguration(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_endpoint_service_configuration.ModifyVpcEndpointServiceConfigurationInput, options: CallOptions) !modify_vpc_endpoint_service_configuration.ModifyVpcEndpointServiceConfigurationOutput {
        return modify_vpc_endpoint_service_configuration.execute(self, allocator, input, options);
    }

    /// Modifies the payer responsibility for your VPC endpoint service.
    pub fn modifyVpcEndpointServicePayerResponsibility(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_endpoint_service_payer_responsibility.ModifyVpcEndpointServicePayerResponsibilityInput, options: CallOptions) !modify_vpc_endpoint_service_payer_responsibility.ModifyVpcEndpointServicePayerResponsibilityOutput {
        return modify_vpc_endpoint_service_payer_responsibility.execute(self, allocator, input, options);
    }

    /// Modifies the permissions for your VPC endpoint service. You can add or
    /// remove permissions
    /// for service consumers (Amazon Web Services accounts, users, and IAM roles)
    /// to connect to
    /// your endpoint service. Principal ARNs with path components aren't supported.
    ///
    /// If you grant permissions to all principals, the service is public. Any users
    /// who know the name of a
    /// public service can send a request to attach an endpoint. If the service does
    /// not require manual approval,
    /// attachments are automatically approved.
    pub fn modifyVpcEndpointServicePermissions(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_endpoint_service_permissions.ModifyVpcEndpointServicePermissionsInput, options: CallOptions) !modify_vpc_endpoint_service_permissions.ModifyVpcEndpointServicePermissionsOutput {
        return modify_vpc_endpoint_service_permissions.execute(self, allocator, input, options);
    }

    /// Modifies the VPC peering connection options on one side of a VPC peering
    /// connection.
    ///
    /// If the peered VPCs are in the same Amazon Web Services account, you can
    /// enable DNS
    /// resolution for queries from the local VPC. This ensures that queries from
    /// the local VPC
    /// resolve to private IP addresses in the peer VPC. This option is not
    /// available if the
    /// peered VPCs are in different Amazon Web Services accounts or different
    /// Regions. For
    /// peered VPCs in different Amazon Web Services accounts, each Amazon Web
    /// Services account
    /// owner must initiate a separate request to modify the peering connection
    /// options. For
    /// inter-region peering connections, you must use the Region for the requester
    /// VPC to
    /// modify the requester VPC peering options and the Region for the accepter VPC
    /// to modify
    /// the accepter VPC peering options. To verify which VPCs are the accepter and
    /// the
    /// requester for a VPC peering connection, use the
    /// DescribeVpcPeeringConnections command.
    pub fn modifyVpcPeeringConnectionOptions(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_peering_connection_options.ModifyVpcPeeringConnectionOptionsInput, options: CallOptions) !modify_vpc_peering_connection_options.ModifyVpcPeeringConnectionOptionsOutput {
        return modify_vpc_peering_connection_options.execute(self, allocator, input, options);
    }

    /// Modifies the instance tenancy attribute of the specified VPC. You can change
    /// the
    /// instance tenancy attribute of a VPC to `default` only. You cannot change the
    /// instance tenancy attribute to `dedicated`.
    ///
    /// After you modify the tenancy of the VPC, any new instances that you launch
    /// into the
    /// VPC have a tenancy of `default`, unless you specify otherwise during launch.
    /// The tenancy of any existing instances in the VPC is not affected.
    ///
    /// For more information, see [Dedicated
    /// Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/dedicated-instance.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn modifyVpcTenancy(self: *Self, allocator: std.mem.Allocator, input: modify_vpc_tenancy.ModifyVpcTenancyInput, options: CallOptions) !modify_vpc_tenancy.ModifyVpcTenancyOutput {
        return modify_vpc_tenancy.execute(self, allocator, input, options);
    }

    /// Modifies the customer gateway or the target gateway of an Amazon Web
    /// Services Site-to-Site VPN connection. To
    /// modify the target gateway, the following migration options are available:
    ///
    /// * An existing virtual private gateway to a new virtual private gateway
    ///
    /// * An existing virtual private gateway to a transit gateway
    ///
    /// * An existing transit gateway to a new transit gateway
    ///
    /// * An existing transit gateway to a virtual private gateway
    ///
    /// Before you perform the migration to the new gateway, you must configure the
    /// new
    /// gateway. Use CreateVpnGateway to create a virtual private gateway, or
    /// CreateTransitGateway to create a transit gateway.
    ///
    /// This step is required when you migrate from a virtual private gateway with
    /// static
    /// routes to a transit gateway.
    ///
    /// You must delete the static routes before you migrate to the new gateway.
    ///
    /// Keep a copy of the static route before you delete it. You will need to add
    /// back these
    /// routes to the transit gateway after the VPN connection migration is
    /// complete.
    ///
    /// After you migrate to the new gateway, you might need to modify your VPC
    /// route table.
    /// Use CreateRoute and DeleteRoute to make the changes
    /// described in [Update VPC route
    /// tables](https://docs.aws.amazon.com/vpn/latest/s2svpn/modify-vpn-target.html#step-update-routing) in the *Amazon Web Services Site-to-Site VPN User Guide*.
    ///
    /// When the new gateway is a transit gateway, modify the transit gateway route
    /// table to
    /// allow traffic between the VPC and the Amazon Web Services Site-to-Site VPN
    /// connection.
    /// Use CreateTransitGatewayRoute to add the routes.
    ///
    /// If you deleted VPN static routes, you must add the static routes to the
    /// transit
    /// gateway route table.
    ///
    /// After you perform this operation, the VPN endpoint's IP addresses on the
    /// Amazon Web Services side and the tunnel options remain intact. Your Amazon
    /// Web Services Site-to-Site VPN connection will
    /// be temporarily unavailable for a brief period while we provision the new
    /// endpoints.
    pub fn modifyVpnConnection(self: *Self, allocator: std.mem.Allocator, input: modify_vpn_connection.ModifyVpnConnectionInput, options: CallOptions) !modify_vpn_connection.ModifyVpnConnectionOutput {
        return modify_vpn_connection.execute(self, allocator, input, options);
    }

    /// Modifies the connection options for your Site-to-Site VPN connection.
    ///
    /// When you modify the VPN connection options, the VPN endpoint IP addresses on
    /// the
    /// Amazon Web Services side do not change, and the tunnel options do not
    /// change. Your
    /// VPN connection will be temporarily unavailable for a brief period while the
    /// VPN
    /// connection is updated.
    pub fn modifyVpnConnectionOptions(self: *Self, allocator: std.mem.Allocator, input: modify_vpn_connection_options.ModifyVpnConnectionOptionsInput, options: CallOptions) !modify_vpn_connection_options.ModifyVpnConnectionOptionsOutput {
        return modify_vpn_connection_options.execute(self, allocator, input, options);
    }

    /// Modifies the VPN tunnel endpoint certificate.
    pub fn modifyVpnTunnelCertificate(self: *Self, allocator: std.mem.Allocator, input: modify_vpn_tunnel_certificate.ModifyVpnTunnelCertificateInput, options: CallOptions) !modify_vpn_tunnel_certificate.ModifyVpnTunnelCertificateOutput {
        return modify_vpn_tunnel_certificate.execute(self, allocator, input, options);
    }

    /// Modifies the options for a VPN tunnel in an Amazon Web Services Site-to-Site
    /// VPN connection. You can modify
    /// multiple options for a tunnel in a single request, but you can only modify
    /// one tunnel at
    /// a time. For more information, see [Site-to-Site VPN tunnel options for your
    /// Site-to-Site VPN
    /// connection](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPNTunnels.html)
    /// in the *Amazon Web Services Site-to-Site VPN User Guide*.
    pub fn modifyVpnTunnelOptions(self: *Self, allocator: std.mem.Allocator, input: modify_vpn_tunnel_options.ModifyVpnTunnelOptionsInput, options: CallOptions) !modify_vpn_tunnel_options.ModifyVpnTunnelOptionsOutput {
        return modify_vpn_tunnel_options.execute(self, allocator, input, options);
    }

    /// Enables detailed monitoring for a running instance. Otherwise, basic
    /// monitoring is
    /// enabled. For more information, see [Monitor your instances using
    /// CloudWatch](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-cloudwatch.html) in the *Amazon EC2 User Guide*.
    ///
    /// To disable detailed monitoring, see
    /// [UnmonitorInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_UnmonitorInstances.html).
    pub fn monitorInstances(self: *Self, allocator: std.mem.Allocator, input: monitor_instances.MonitorInstancesInput, options: CallOptions) !monitor_instances.MonitorInstancesOutput {
        return monitor_instances.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Moves an Elastic IP address from the EC2-Classic platform to the EC2-VPC
    /// platform. The
    /// Elastic IP address must be allocated to your account for more than 24 hours,
    /// and it must not
    /// be associated with an instance. After the Elastic IP address is moved, it is
    /// no longer
    /// available for use in the EC2-Classic platform. You cannot move an Elastic IP
    /// address that was
    /// originally allocated for use in the EC2-VPC platform to the EC2-Classic
    /// platform.
    pub fn moveAddressToVpc(self: *Self, allocator: std.mem.Allocator, input: move_address_to_vpc.MoveAddressToVpcInput, options: CallOptions) !move_address_to_vpc.MoveAddressToVpcOutput {
        return move_address_to_vpc.execute(self, allocator, input, options);
    }

    /// Move a BYOIPv4 CIDR to IPAM from a public IPv4 pool.
    ///
    /// If you already have a BYOIPv4 CIDR with Amazon Web Services, you can move
    /// the CIDR to IPAM from a public IPv4 pool. You cannot move an IPv6 CIDR to
    /// IPAM. If you are bringing a new IP address to Amazon Web Services for the
    /// first time, complete the steps in [Tutorial: BYOIP address CIDRs to
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoip-ipam.html).
    pub fn moveByoipCidrToIpam(self: *Self, allocator: std.mem.Allocator, input: move_byoip_cidr_to_ipam.MoveByoipCidrToIpamInput, options: CallOptions) !move_byoip_cidr_to_ipam.MoveByoipCidrToIpamOutput {
        return move_byoip_cidr_to_ipam.execute(self, allocator, input, options);
    }

    /// Move available capacity from a source Capacity Reservation to a destination
    /// Capacity
    /// Reservation. The source Capacity Reservation and the destination Capacity
    /// Reservation
    /// must be `active`, owned by your Amazon Web Services account, and share the
    /// following:
    ///
    /// * Instance type
    ///
    /// * Platform
    ///
    /// * Availability Zone
    ///
    /// * Tenancy
    ///
    /// * Placement group
    ///
    /// * Capacity Reservation end time - `At specific time` or
    /// `Manually`.
    pub fn moveCapacityReservationInstances(self: *Self, allocator: std.mem.Allocator, input: move_capacity_reservation_instances.MoveCapacityReservationInstancesInput, options: CallOptions) !move_capacity_reservation_instances.MoveCapacityReservationInstancesOutput {
        return move_capacity_reservation_instances.execute(self, allocator, input, options);
    }

    /// Provisions an IPv4 or IPv6 address range for use with your Amazon Web
    /// Services resources through bring your own IP
    /// addresses (BYOIP) and creates a corresponding address pool. After the
    /// address range is
    /// provisioned, it is ready to be advertised.
    ///
    /// Amazon Web Services verifies that you own the address range and are
    /// authorized to advertise it.
    /// You must ensure that the address range is registered to you and that you
    /// created an
    /// RPKI ROA to authorize Amazon ASNs 16509 and 14618 to advertise the address
    /// range.
    /// For more information, see [Bring your own IP addresses
    /// (BYOIP)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-byoip.html)
    /// in the *Amazon EC2 User Guide*.
    ///
    /// Provisioning an address range is an asynchronous operation, so the call
    /// returns immediately,
    /// but the address range is not ready to use until its status changes from
    /// `pending-provision`
    /// to `provisioned`. For more information, see [Onboard your address
    /// range](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/byoip-onboard.html).
    pub fn provisionByoipCidr(self: *Self, allocator: std.mem.Allocator, input: provision_byoip_cidr.ProvisionByoipCidrInput, options: CallOptions) !provision_byoip_cidr.ProvisionByoipCidrOutput {
        return provision_byoip_cidr.execute(self, allocator, input, options);
    }

    /// Provisions your Autonomous System Number (ASN) for use in your Amazon Web
    /// Services account. This action requires authorization context for Amazon to
    /// bring the ASN to an Amazon Web Services account. For more information, see
    /// [Tutorial: Bring your ASN to
    /// IPAM](https://docs.aws.amazon.com/vpc/latest/ipam/tutorials-byoasn.html) in
    /// the *Amazon VPC IPAM guide*.
    pub fn provisionIpamByoasn(self: *Self, allocator: std.mem.Allocator, input: provision_ipam_byoasn.ProvisionIpamByoasnInput, options: CallOptions) !provision_ipam_byoasn.ProvisionIpamByoasnOutput {
        return provision_ipam_byoasn.execute(self, allocator, input, options);
    }

    /// Provision a CIDR to an IPAM pool. You can use this action to provision new
    /// CIDRs to a top-level pool or to transfer a CIDR from a top-level pool to a
    /// pool within it.
    ///
    /// For more information, see [Provision CIDRs to
    /// pools](https://docs.aws.amazon.com/vpc/latest/ipam/prov-cidr-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    pub fn provisionIpamPoolCidr(self: *Self, allocator: std.mem.Allocator, input: provision_ipam_pool_cidr.ProvisionIpamPoolCidrInput, options: CallOptions) !provision_ipam_pool_cidr.ProvisionIpamPoolCidrOutput {
        return provision_ipam_pool_cidr.execute(self, allocator, input, options);
    }

    /// Provision a CIDR to a public IPv4 pool.
    ///
    /// For more information about IPAM, see [What is
    /// IPAM?](https://docs.aws.amazon.com/vpc/latest/ipam/what-is-it-ipam.html) in
    /// the *Amazon VPC IPAM User Guide*.
    pub fn provisionPublicIpv4PoolCidr(self: *Self, allocator: std.mem.Allocator, input: provision_public_ipv_4_pool_cidr.ProvisionPublicIpv4PoolCidrInput, options: CallOptions) !provision_public_ipv_4_pool_cidr.ProvisionPublicIpv4PoolCidrOutput {
        return provision_public_ipv_4_pool_cidr.execute(self, allocator, input, options);
    }

    /// Purchase the Capacity Block for use with your account. With Capacity Blocks
    /// you ensure
    /// GPU capacity is available for machine learning (ML) workloads. You must
    /// specify the ID
    /// of the Capacity Block offering you are purchasing.
    pub fn purchaseCapacityBlock(self: *Self, allocator: std.mem.Allocator, input: purchase_capacity_block.PurchaseCapacityBlockInput, options: CallOptions) !purchase_capacity_block.PurchaseCapacityBlockOutput {
        return purchase_capacity_block.execute(self, allocator, input, options);
    }

    /// Purchase the Capacity Block extension for use with your account. You must
    /// specify the
    /// ID of the Capacity Block extension offering you are purchasing.
    pub fn purchaseCapacityBlockExtension(self: *Self, allocator: std.mem.Allocator, input: purchase_capacity_block_extension.PurchaseCapacityBlockExtensionInput, options: CallOptions) !purchase_capacity_block_extension.PurchaseCapacityBlockExtensionOutput {
        return purchase_capacity_block_extension.execute(self, allocator, input, options);
    }

    /// Purchase a reservation with configurations that match those of your
    /// Dedicated Host.
    /// You must have active Dedicated Hosts in your account before you purchase a
    /// reservation.
    /// This action results in the specified reservation being purchased and charged
    /// to your
    /// account.
    pub fn purchaseHostReservation(self: *Self, allocator: std.mem.Allocator, input: purchase_host_reservation.PurchaseHostReservationInput, options: CallOptions) !purchase_host_reservation.PurchaseHostReservationOutput {
        return purchase_host_reservation.execute(self, allocator, input, options);
    }

    /// Purchases a Reserved Instance for use with your account. With Reserved
    /// Instances, you pay
    /// a lower hourly rate compared to On-Demand instance pricing.
    ///
    /// Use DescribeReservedInstancesOfferings to get a list of Reserved
    /// Instance offerings that match your specifications. After you've purchased a
    /// Reserved Instance,
    /// you can check for your new Reserved Instance with DescribeReservedInstances.
    ///
    /// To queue a purchase for a future date and time, specify a purchase time. If
    /// you do not
    /// specify a purchase time, the default is the current time.
    ///
    /// For more information, see [Reserved
    /// Instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/concepts-on-demand-reserved-instances.html) and [Sell in the Reserved Instance
    /// Marketplace](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ri-market-general.html) in the *Amazon EC2 User Guide*.
    pub fn purchaseReservedInstancesOffering(self: *Self, allocator: std.mem.Allocator, input: purchase_reserved_instances_offering.PurchaseReservedInstancesOfferingInput, options: CallOptions) !purchase_reserved_instances_offering.PurchaseReservedInstancesOfferingOutput {
        return purchase_reserved_instances_offering.execute(self, allocator, input, options);
    }

    /// You can no longer purchase Scheduled Instances.
    ///
    /// Purchases the Scheduled Instances with the specified schedule.
    ///
    /// Scheduled Instances enable you to purchase Amazon EC2 compute capacity by
    /// the hour for a one-year term.
    /// Before you can purchase a Scheduled Instance, you must call
    /// DescribeScheduledInstanceAvailability
    /// to check for available schedules and obtain a purchase token. After you
    /// purchase a Scheduled Instance,
    /// you must call RunScheduledInstances during each scheduled time period.
    ///
    /// After you purchase a Scheduled Instance, you can't cancel, modify, or resell
    /// your purchase.
    pub fn purchaseScheduledInstances(self: *Self, allocator: std.mem.Allocator, input: purchase_scheduled_instances.PurchaseScheduledInstancesInput, options: CallOptions) !purchase_scheduled_instances.PurchaseScheduledInstancesOutput {
        return purchase_scheduled_instances.execute(self, allocator, input, options);
    }

    /// Requests a reboot of the specified instances. This operation is
    /// asynchronous; it only
    /// queues a request to reboot the specified instances. The operation succeeds
    /// if the
    /// instances are valid and belong to you. Requests to reboot terminated
    /// instances are
    /// ignored.
    ///
    /// If an instance does not cleanly shut down within a few minutes, Amazon EC2
    /// performs a
    /// hard reboot.
    ///
    /// For more information about troubleshooting, see [Troubleshoot an unreachable
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-console.html) in the *Amazon EC2 User Guide*.
    pub fn rebootInstances(self: *Self, allocator: std.mem.Allocator, input: reboot_instances.RebootInstancesInput, options: CallOptions) !reboot_instances.RebootInstancesOutput {
        return reboot_instances.execute(self, allocator, input, options);
    }

    /// Registers an AMI. When you're creating an instance-store backed AMI,
    /// registering the AMI
    /// is the final step in the creation process. For more information about
    /// creating AMIs, see
    /// [Create an AMI from a
    /// snapshot](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating-an-ami-ebs.html#creating-launching-ami-from-snapshot) and [Create an instance-store
    /// backed
    /// AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating-an-ami-instance-store.html) in the *Amazon EC2 User Guide*.
    ///
    /// If needed, you can deregister an AMI at any time. Any modifications you make
    /// to an AMI
    /// backed by an instance store volume invalidates its registration. If you make
    /// changes to an
    /// image, deregister the previous image and register the new image.
    ///
    /// **Register a snapshot of a root device volume**
    ///
    /// You can use `RegisterImage` to create an Amazon EBS-backed Linux AMI from a
    /// snapshot
    /// of a root device volume. You specify the snapshot using a block device
    /// mapping. You can't set
    /// the encryption state of the volume using the block device mapping. If the
    /// snapshot is
    /// encrypted, or encryption by default is enabled, the root volume of an
    /// instance launched from
    /// the AMI is encrypted.
    ///
    /// For more information, see [Create an AMI from a
    /// snapshot](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating-an-ami-ebs.html#creating-launching-ami-from-snapshot) and [Use encryption with EBS-backed AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIEncryption.html)
    /// in the *Amazon EC2 User Guide*.
    ///
    /// **Amazon Web Services Marketplace product codes**
    ///
    /// If any snapshots have Amazon Web Services Marketplace product codes, they
    /// are copied to the new AMI.
    ///
    /// In most cases, AMIs for Windows, RedHat, SUSE, and SQL Server require
    /// correct licensing
    /// information to be present on the AMI. For more information, see [Understand
    /// AMI billing
    /// information](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-billing-info.html) in the *Amazon EC2 User Guide*. When creating an AMI from
    /// a snapshot, the `RegisterImage` operation derives the correct billing
    /// information
    /// from the snapshot's metadata, but this requires the appropriate metadata to
    /// be present. To
    /// verify if the correct billing information was applied, check the
    /// `PlatformDetails`
    /// field on the new AMI. If the field is empty or doesn't match the expected
    /// operating system
    /// code (for example, Windows, RedHat, SUSE, or SQL), the AMI creation was
    /// unsuccessful, and you
    /// should discard the AMI and instead create the AMI from an instance.
    /// For more information, see [Create an AMI
    /// from an instance
    /// ](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/creating-an-ami-ebs.html#how-to-create-ebs-ami) in the *Amazon EC2 User Guide*.
    ///
    /// If you purchase a Reserved Instance to apply to an On-Demand Instance that
    /// was launched
    /// from an AMI with a billing product code, make sure that the Reserved
    /// Instance has the matching
    /// billing product code. If you purchase a Reserved Instance without the
    /// matching billing product
    /// code, the Reserved Instance is not applied to the On-Demand Instance. For
    /// information
    /// about how to obtain the platform details and billing information of an AMI,
    /// see [Understand AMI
    /// billing
    /// information](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ami-billing-info.html) in the *Amazon EC2 User Guide*.
    pub fn registerImage(self: *Self, allocator: std.mem.Allocator, input: register_image.RegisterImageInput, options: CallOptions) !register_image.RegisterImageOutput {
        return register_image.execute(self, allocator, input, options);
    }

    /// Registers a set of tag keys to include in scheduled event notifications for
    /// your
    /// resources.
    ///
    /// To remove tags, use
    /// [DeregisterInstanceEventNotificationAttributes](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_DeregisterInstanceEventNotificationAttributes.html).
    pub fn registerInstanceEventNotificationAttributes(self: *Self, allocator: std.mem.Allocator, input: register_instance_event_notification_attributes.RegisterInstanceEventNotificationAttributesInput, options: CallOptions) !register_instance_event_notification_attributes.RegisterInstanceEventNotificationAttributesOutput {
        return register_instance_event_notification_attributes.execute(self, allocator, input, options);
    }

    /// Registers members (network interfaces) with the transit gateway multicast
    /// group. A member is a network interface associated
    /// with a supported EC2 instance that receives multicast traffic. For more
    /// information, see
    /// [Multicast
    /// on transit
    /// gateways](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-multicast-overview.html) in the *Amazon Web Services Transit Gateways Guide*.
    ///
    /// After you add the members, use
    /// [SearchTransitGatewayMulticastGroups](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SearchTransitGatewayMulticastGroups.html) to verify that the members were added
    /// to the transit gateway multicast group.
    pub fn registerTransitGatewayMulticastGroupMembers(self: *Self, allocator: std.mem.Allocator, input: register_transit_gateway_multicast_group_members.RegisterTransitGatewayMulticastGroupMembersInput, options: CallOptions) !register_transit_gateway_multicast_group_members.RegisterTransitGatewayMulticastGroupMembersOutput {
        return register_transit_gateway_multicast_group_members.execute(self, allocator, input, options);
    }

    /// Registers sources (network interfaces) with the specified transit gateway
    /// multicast group.
    ///
    /// A multicast source is a network interface attached to a supported instance
    /// that sends
    /// multicast traffic. For more information about supported instances, see
    /// [Multicast
    /// on transit
    /// gateways](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-multicast-overview.html) in the *Amazon Web Services Transit Gateways Guide*.
    ///
    /// After you add the source, use
    /// [SearchTransitGatewayMulticastGroups](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_SearchTransitGatewayMulticastGroups.html) to verify that the source was added to the multicast
    /// group.
    pub fn registerTransitGatewayMulticastGroupSources(self: *Self, allocator: std.mem.Allocator, input: register_transit_gateway_multicast_group_sources.RegisterTransitGatewayMulticastGroupSourcesInput, options: CallOptions) !register_transit_gateway_multicast_group_sources.RegisterTransitGatewayMulticastGroupSourcesOutput {
        return register_transit_gateway_multicast_group_sources.execute(self, allocator, input, options);
    }

    /// Rejects a request to assign billing of the available capacity of a shared
    /// Capacity
    /// Reservation to your account. For more information, see [ Billing assignment
    /// for shared
    /// Amazon EC2 Capacity
    /// Reservations](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/assign-billing.html).
    pub fn rejectCapacityReservationBillingOwnership(self: *Self, allocator: std.mem.Allocator, input: reject_capacity_reservation_billing_ownership.RejectCapacityReservationBillingOwnershipInput, options: CallOptions) !reject_capacity_reservation_billing_ownership.RejectCapacityReservationBillingOwnershipOutput {
        return reject_capacity_reservation_billing_ownership.execute(self, allocator, input, options);
    }

    /// Rejects a request to associate cross-account subnets with a transit gateway
    /// multicast domain.
    pub fn rejectTransitGatewayMulticastDomainAssociations(self: *Self, allocator: std.mem.Allocator, input: reject_transit_gateway_multicast_domain_associations.RejectTransitGatewayMulticastDomainAssociationsInput, options: CallOptions) !reject_transit_gateway_multicast_domain_associations.RejectTransitGatewayMulticastDomainAssociationsOutput {
        return reject_transit_gateway_multicast_domain_associations.execute(self, allocator, input, options);
    }

    /// Rejects a transit gateway peering attachment request.
    pub fn rejectTransitGatewayPeeringAttachment(self: *Self, allocator: std.mem.Allocator, input: reject_transit_gateway_peering_attachment.RejectTransitGatewayPeeringAttachmentInput, options: CallOptions) !reject_transit_gateway_peering_attachment.RejectTransitGatewayPeeringAttachmentOutput {
        return reject_transit_gateway_peering_attachment.execute(self, allocator, input, options);
    }

    /// Rejects a request to attach a VPC to a transit gateway.
    ///
    /// The VPC attachment must be in the `pendingAcceptance` state.
    /// Use DescribeTransitGatewayVpcAttachments to view your pending VPC attachment
    /// requests.
    /// Use AcceptTransitGatewayVpcAttachment to accept a VPC attachment request.
    pub fn rejectTransitGatewayVpcAttachment(self: *Self, allocator: std.mem.Allocator, input: reject_transit_gateway_vpc_attachment.RejectTransitGatewayVpcAttachmentInput, options: CallOptions) !reject_transit_gateway_vpc_attachment.RejectTransitGatewayVpcAttachmentOutput {
        return reject_transit_gateway_vpc_attachment.execute(self, allocator, input, options);
    }

    /// Rejects VPC endpoint connection requests to your VPC endpoint service.
    pub fn rejectVpcEndpointConnections(self: *Self, allocator: std.mem.Allocator, input: reject_vpc_endpoint_connections.RejectVpcEndpointConnectionsInput, options: CallOptions) !reject_vpc_endpoint_connections.RejectVpcEndpointConnectionsOutput {
        return reject_vpc_endpoint_connections.execute(self, allocator, input, options);
    }

    /// Rejects a VPC peering connection request. The VPC peering connection must be
    /// in the
    /// `pending-acceptance` state. Use the DescribeVpcPeeringConnections request
    /// to view your outstanding VPC peering connection requests. To delete an
    /// active VPC peering
    /// connection, or to delete a VPC peering connection request that you
    /// initiated, use DeleteVpcPeeringConnection.
    pub fn rejectVpcPeeringConnection(self: *Self, allocator: std.mem.Allocator, input: reject_vpc_peering_connection.RejectVpcPeeringConnectionInput, options: CallOptions) !reject_vpc_peering_connection.RejectVpcPeeringConnectionOutput {
        return reject_vpc_peering_connection.execute(self, allocator, input, options);
    }

    /// Releases the specified Elastic IP address.
    ///
    /// [Default VPC] Releasing an Elastic IP address automatically disassociates it
    /// from any instance that it's associated with. Alternatively, you can
    /// disassociate an Elastic IP address without
    /// releasing it.
    ///
    /// [Nondefault VPC] You must disassociate the Elastic IP address
    /// before you can release it. Otherwise, Amazon EC2 returns an error
    /// (`InvalidIPAddress.InUse`).
    ///
    /// After releasing an Elastic IP address, it is released to the IP address
    /// pool.
    /// Be sure to update your DNS records and any servers or devices that
    /// communicate with the address.
    /// If you attempt to release an Elastic IP address that you already released,
    /// you'll get an
    /// `AuthFailure` error if the address is already allocated to another Amazon
    /// Web Services account.
    ///
    /// After you release an Elastic IP address, you might be able to recover it.
    /// For more information, see [Release an Elastic IP
    /// address](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-instance-addressing-eips-releasing.html).
    pub fn releaseAddress(self: *Self, allocator: std.mem.Allocator, input: release_address.ReleaseAddressInput, options: CallOptions) !release_address.ReleaseAddressOutput {
        return release_address.execute(self, allocator, input, options);
    }

    /// When you no longer want to use an On-Demand Dedicated Host it can be
    /// released.
    /// On-Demand billing is stopped and the host goes into `released` state. The
    /// host ID of Dedicated Hosts that have been released can no longer be
    /// specified in another
    /// request, for example, to modify the host. You must stop or terminate all
    /// instances on a
    /// host before it can be released.
    ///
    /// When Dedicated Hosts are released, it may take some time for them to stop
    /// counting
    /// toward your limit and you may receive capacity errors when trying to
    /// allocate new
    /// Dedicated Hosts. Wait a few minutes and then try again.
    ///
    /// Released hosts still appear in a DescribeHosts response.
    pub fn releaseHosts(self: *Self, allocator: std.mem.Allocator, input: release_hosts.ReleaseHostsInput, options: CallOptions) !release_hosts.ReleaseHostsOutput {
        return release_hosts.execute(self, allocator, input, options);
    }

    /// Release an allocation within an IPAM pool. The Region you use should be the
    /// IPAM pool locale. The locale is the Amazon Web Services Region where this
    /// IPAM pool is available for allocations. You can only use this action to
    /// release manual allocations. To remove an allocation for a resource without
    /// deleting the resource, set its monitored state to false using
    /// [ModifyIpamResourceCidr](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_ModifyIpamResourceCidr.html). For more information, see [Release an allocation](https://docs.aws.amazon.com/vpc/latest/ipam/release-alloc-ipam.html) in the *Amazon VPC IPAM User Guide*.
    ///
    /// All EC2 API actions follow an [eventual
    /// consistency](https://docs.aws.amazon.com/ec2/latest/devguide/eventual-consistency.html) model.
    pub fn releaseIpamPoolAllocation(self: *Self, allocator: std.mem.Allocator, input: release_ipam_pool_allocation.ReleaseIpamPoolAllocationInput, options: CallOptions) !release_ipam_pool_allocation.ReleaseIpamPoolAllocationOutput {
        return release_ipam_pool_allocation.execute(self, allocator, input, options);
    }

    /// Replaces an IAM instance profile for the specified running instance. You can
    /// use
    /// this action to change the IAM instance profile that's associated with an
    /// instance
    /// without having to disassociate the existing IAM instance profile first.
    ///
    /// Use DescribeIamInstanceProfileAssociations to get the association
    /// ID.
    pub fn replaceIamInstanceProfileAssociation(self: *Self, allocator: std.mem.Allocator, input: replace_iam_instance_profile_association.ReplaceIamInstanceProfileAssociationInput, options: CallOptions) !replace_iam_instance_profile_association.ReplaceIamInstanceProfileAssociationOutput {
        return replace_iam_instance_profile_association.execute(self, allocator, input, options);
    }

    /// Sets or replaces the criteria for Allowed AMIs.
    ///
    /// The Allowed AMIs feature does not restrict the AMIs owned by your account.
    /// Regardless of
    /// the criteria you set, the AMIs created by your account will always be
    /// discoverable and
    /// usable by users in your account.
    ///
    /// For more information, see [Control the discovery and use of AMIs in
    /// Amazon EC2 with Allowed
    /// AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-allowed-amis.html) in
    /// *Amazon EC2 User Guide*.
    pub fn replaceImageCriteriaInAllowedImagesSettings(self: *Self, allocator: std.mem.Allocator, input: replace_image_criteria_in_allowed_images_settings.ReplaceImageCriteriaInAllowedImagesSettingsInput, options: CallOptions) !replace_image_criteria_in_allowed_images_settings.ReplaceImageCriteriaInAllowedImagesSettingsOutput {
        return replace_image_criteria_in_allowed_images_settings.execute(self, allocator, input, options);
    }

    /// Changes which network ACL a subnet is associated with. By default when you
    /// create a
    /// subnet, it's automatically associated with the default network ACL. For more
    /// information, see [Network
    /// ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) in the *Amazon VPC User Guide*.
    ///
    /// This is an idempotent operation.
    pub fn replaceNetworkAclAssociation(self: *Self, allocator: std.mem.Allocator, input: replace_network_acl_association.ReplaceNetworkAclAssociationInput, options: CallOptions) !replace_network_acl_association.ReplaceNetworkAclAssociationOutput {
        return replace_network_acl_association.execute(self, allocator, input, options);
    }

    /// Replaces an entry (rule) in a network ACL. For more information, see
    /// [Network
    /// ACLs](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-network-acls.html) in the
    /// *Amazon VPC User Guide*.
    pub fn replaceNetworkAclEntry(self: *Self, allocator: std.mem.Allocator, input: replace_network_acl_entry.ReplaceNetworkAclEntryInput, options: CallOptions) !replace_network_acl_entry.ReplaceNetworkAclEntryOutput {
        return replace_network_acl_entry.execute(self, allocator, input, options);
    }

    /// Replaces an existing route within a route table in a VPC.
    ///
    /// You must specify either a destination CIDR block or a prefix list ID. You
    /// must also specify
    /// exactly one of the resources from the parameter list, or reset the local
    /// route to its default
    /// target.
    ///
    /// For more information, see [Route
    /// tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html) in the
    /// *Amazon VPC User Guide*.
    pub fn replaceRoute(self: *Self, allocator: std.mem.Allocator, input: replace_route.ReplaceRouteInput, options: CallOptions) !replace_route.ReplaceRouteOutput {
        return replace_route.execute(self, allocator, input, options);
    }

    /// Changes the route table associated with a given subnet, internet gateway, or
    /// virtual private gateway in a VPC. After the operation
    /// completes, the subnet or gateway uses the routes in the new route table. For
    /// more
    /// information about route tables, see [Route
    /// tables](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Route_Tables.html) in the *Amazon VPC User Guide*.
    ///
    /// You can also use this operation to change which table is the main route
    /// table in the VPC. Specify the main route table's association ID and the
    /// route table ID of the new main route table.
    pub fn replaceRouteTableAssociation(self: *Self, allocator: std.mem.Allocator, input: replace_route_table_association.ReplaceRouteTableAssociationInput, options: CallOptions) !replace_route_table_association.ReplaceRouteTableAssociationOutput {
        return replace_route_table_association.execute(self, allocator, input, options);
    }

    /// Replaces the specified route in the specified transit gateway route table.
    pub fn replaceTransitGatewayRoute(self: *Self, allocator: std.mem.Allocator, input: replace_transit_gateway_route.ReplaceTransitGatewayRouteInput, options: CallOptions) !replace_transit_gateway_route.ReplaceTransitGatewayRouteOutput {
        return replace_transit_gateway_route.execute(self, allocator, input, options);
    }

    /// Trigger replacement of specified VPN tunnel.
    pub fn replaceVpnTunnel(self: *Self, allocator: std.mem.Allocator, input: replace_vpn_tunnel.ReplaceVpnTunnelInput, options: CallOptions) !replace_vpn_tunnel.ReplaceVpnTunnelOutput {
        return replace_vpn_tunnel.execute(self, allocator, input, options);
    }

    /// Submits feedback about the status of an instance. The instance must be in
    /// the
    /// `running` state. If your experience with the instance differs from the
    /// instance status returned by DescribeInstanceStatus, use ReportInstanceStatus
    /// to report your experience with the instance. Amazon
    /// EC2 collects this information to improve the accuracy of status checks.
    ///
    /// Use of this action does not change the value returned by
    /// DescribeInstanceStatus.
    pub fn reportInstanceStatus(self: *Self, allocator: std.mem.Allocator, input: report_instance_status.ReportInstanceStatusInput, options: CallOptions) !report_instance_status.ReportInstanceStatusOutput {
        return report_instance_status.execute(self, allocator, input, options);
    }

    /// Creates a Spot Fleet request.
    ///
    /// The Spot Fleet request specifies the total target capacity and the On-Demand
    /// target
    /// capacity. Amazon EC2 calculates the difference between the total capacity
    /// and On-Demand
    /// capacity, and launches the difference as Spot capacity.
    ///
    /// You can submit a single request that includes multiple launch specifications
    /// that vary
    /// by instance type, AMI, Availability Zone, or subnet.
    ///
    /// By default, the Spot Fleet requests Spot Instances in the Spot Instance pool
    /// where the
    /// price per unit is the lowest. Each launch specification can include its own
    /// instance
    /// weighting that reflects the value of the instance type to your application
    /// workload.
    ///
    /// Alternatively, you can specify that the Spot Fleet distribute the target
    /// capacity
    /// across the Spot pools included in its launch specifications. By ensuring
    /// that the Spot
    /// Instances in your Spot Fleet are in different Spot pools, you can improve
    /// the
    /// availability of your fleet.
    ///
    /// You can specify tags for the Spot Fleet request and instances launched by
    /// the fleet.
    /// You cannot tag other resource types in a Spot Fleet request because only the
    /// `spot-fleet-request` and `instance` resource types are
    /// supported.
    ///
    /// For more information, see [Spot Fleet
    /// requests](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-fleet-requests.html)
    /// in the *Amazon EC2 User Guide*.
    ///
    /// We strongly discourage using the RequestSpotFleet API because it is a legacy
    /// API with no planned investment. For options for requesting Spot Instances,
    /// see
    /// [Which
    /// is the best Spot request method to
    /// use?](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-best-practices.html#which-spot-request-method-to-use) in the
    /// *Amazon EC2 User Guide*.
    pub fn requestSpotFleet(self: *Self, allocator: std.mem.Allocator, input: request_spot_fleet.RequestSpotFleetInput, options: CallOptions) !request_spot_fleet.RequestSpotFleetOutput {
        return request_spot_fleet.execute(self, allocator, input, options);
    }

    /// Creates a Spot Instance request.
    ///
    /// For more information, see [Work with Spot
    /// Instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-requests.html) in
    /// the *Amazon EC2 User Guide*.
    ///
    /// We strongly discourage using the RequestSpotInstances API because it is a
    /// legacy
    /// API with no planned investment. For options for requesting Spot Instances,
    /// see
    /// [Which
    /// is the best Spot request method to
    /// use?](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-best-practices.html#which-spot-request-method-to-use) in the
    /// *Amazon EC2 User Guide*.
    pub fn requestSpotInstances(self: *Self, allocator: std.mem.Allocator, input: request_spot_instances.RequestSpotInstancesInput, options: CallOptions) !request_spot_instances.RequestSpotInstancesOutput {
        return request_spot_instances.execute(self, allocator, input, options);
    }

    /// Resets the attribute of the specified IP address. For requirements, see
    /// [Using reverse DNS for email
    /// applications](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/elastic-ip-addresses-eip.html#Using_Elastic_Addressing_Reverse_DNS).
    pub fn resetAddressAttribute(self: *Self, allocator: std.mem.Allocator, input: reset_address_attribute.ResetAddressAttributeInput, options: CallOptions) !reset_address_attribute.ResetAddressAttributeOutput {
        return reset_address_attribute.execute(self, allocator, input, options);
    }

    /// Resets the default KMS key for EBS encryption for your account in this
    /// Region
    /// to the Amazon Web Services managed KMS key for EBS.
    ///
    /// After resetting the default KMS key to the Amazon Web Services managed KMS
    /// key, you can continue to encrypt by a
    /// customer managed KMS key by specifying it when you create the volume. For
    /// more information, see
    /// [Amazon EBS
    /// encryption](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-encryption.html)
    /// in the *Amazon EBS User Guide*.
    pub fn resetEbsDefaultKmsKeyId(self: *Self, allocator: std.mem.Allocator, input: reset_ebs_default_kms_key_id.ResetEbsDefaultKmsKeyIdInput, options: CallOptions) !reset_ebs_default_kms_key_id.ResetEbsDefaultKmsKeyIdOutput {
        return reset_ebs_default_kms_key_id.execute(self, allocator, input, options);
    }

    /// Resets the specified attribute of the specified Amazon FPGA Image (AFI) to
    /// its default value.
    /// You can only reset the load permission attribute.
    pub fn resetFpgaImageAttribute(self: *Self, allocator: std.mem.Allocator, input: reset_fpga_image_attribute.ResetFpgaImageAttributeInput, options: CallOptions) !reset_fpga_image_attribute.ResetFpgaImageAttributeOutput {
        return reset_fpga_image_attribute.execute(self, allocator, input, options);
    }

    /// Resets an attribute of an AMI to its default value.
    pub fn resetImageAttribute(self: *Self, allocator: std.mem.Allocator, input: reset_image_attribute.ResetImageAttributeInput, options: CallOptions) !reset_image_attribute.ResetImageAttributeOutput {
        return reset_image_attribute.execute(self, allocator, input, options);
    }

    /// Resets an attribute of an instance to its default value. To reset the
    /// `kernel` or `ramdisk`, the instance must be in a stopped
    /// state. To reset the `sourceDestCheck`, the instance can be either running or
    /// stopped.
    ///
    /// The `sourceDestCheck` attribute controls whether source/destination
    /// checking is enabled. The default value is `true`, which means checking is
    /// enabled. This value must be `false` for a NAT instance to perform NAT. For
    /// more information, see [NAT
    /// instances](https://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_NAT_Instance.html) in the
    /// *Amazon VPC User Guide*.
    pub fn resetInstanceAttribute(self: *Self, allocator: std.mem.Allocator, input: reset_instance_attribute.ResetInstanceAttributeInput, options: CallOptions) !reset_instance_attribute.ResetInstanceAttributeOutput {
        return reset_instance_attribute.execute(self, allocator, input, options);
    }

    /// Resets a network interface attribute. You can specify only one attribute at
    /// a
    /// time.
    pub fn resetNetworkInterfaceAttribute(self: *Self, allocator: std.mem.Allocator, input: reset_network_interface_attribute.ResetNetworkInterfaceAttributeInput, options: CallOptions) !reset_network_interface_attribute.ResetNetworkInterfaceAttributeOutput {
        return reset_network_interface_attribute.execute(self, allocator, input, options);
    }

    /// Resets permission settings for the specified snapshot.
    ///
    /// For more information about modifying snapshot permissions, see [Share a
    /// snapshot](https://docs.aws.amazon.com/ebs/latest/userguide/ebs-modifying-snapshot-permissions.html) in the
    /// *Amazon EBS User Guide*.
    pub fn resetSnapshotAttribute(self: *Self, allocator: std.mem.Allocator, input: reset_snapshot_attribute.ResetSnapshotAttributeInput, options: CallOptions) !reset_snapshot_attribute.ResetSnapshotAttributeOutput {
        return reset_snapshot_attribute.execute(self, allocator, input, options);
    }

    /// This action is deprecated.
    ///
    /// Restores an Elastic IP address that was previously moved to the EC2-VPC
    /// platform back to the EC2-Classic platform. You cannot move an Elastic IP
    /// address that was originally allocated for use in EC2-VPC. The Elastic IP
    /// address must not be associated with an instance or network interface.
    pub fn restoreAddressToClassic(self: *Self, allocator: std.mem.Allocator, input: restore_address_to_classic.RestoreAddressToClassicInput, options: CallOptions) !restore_address_to_classic.RestoreAddressToClassicOutput {
        return restore_address_to_classic.execute(self, allocator, input, options);
    }

    /// Restores an AMI from the Recycle Bin. For more information, see [Recover
    /// deleted Amazon EBS
    /// snapshots and EBS-back AMIs with Recycle
    /// Bin](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/recycle-bin.html)
    /// in the
    /// *Amazon EC2 User Guide*.
    pub fn restoreImageFromRecycleBin(self: *Self, allocator: std.mem.Allocator, input: restore_image_from_recycle_bin.RestoreImageFromRecycleBinInput, options: CallOptions) !restore_image_from_recycle_bin.RestoreImageFromRecycleBinOutput {
        return restore_image_from_recycle_bin.execute(self, allocator, input, options);
    }

    /// Restores the entries from a previous version of a managed prefix list to a
    /// new version of the prefix list.
    pub fn restoreManagedPrefixListVersion(self: *Self, allocator: std.mem.Allocator, input: restore_managed_prefix_list_version.RestoreManagedPrefixListVersionInput, options: CallOptions) !restore_managed_prefix_list_version.RestoreManagedPrefixListVersionOutput {
        return restore_managed_prefix_list_version.execute(self, allocator, input, options);
    }

    /// Restores a snapshot from the Recycle Bin. For more information, see [Restore
    /// snapshots from the Recycle
    /// Bin](https://docs.aws.amazon.com/ebs/latest/userguide/recycle-bin-working-with-snaps.html#recycle-bin-restore-snaps) in the *Amazon EBS User Guide*.
    pub fn restoreSnapshotFromRecycleBin(self: *Self, allocator: std.mem.Allocator, input: restore_snapshot_from_recycle_bin.RestoreSnapshotFromRecycleBinInput, options: CallOptions) !restore_snapshot_from_recycle_bin.RestoreSnapshotFromRecycleBinOutput {
        return restore_snapshot_from_recycle_bin.execute(self, allocator, input, options);
    }

    /// Restores an archived Amazon EBS snapshot for use temporarily or permanently,
    /// or modifies the restore
    /// period or restore type for a snapshot that was previously temporarily
    /// restored.
    ///
    /// For more information see [
    /// Restore an archived
    /// snapshot](https://docs.aws.amazon.com/ebs/latest/userguide/working-with-snapshot-archiving.html#restore-archived-snapshot) and [
    /// modify the restore period or restore type for a temporarily restored
    /// snapshot](https://docs.aws.amazon.com/ebs/latest/userguide/working-with-snapshot-archiving.html#modify-temp-restore-period) in the *Amazon EBS User Guide*.
    pub fn restoreSnapshotTier(self: *Self, allocator: std.mem.Allocator, input: restore_snapshot_tier.RestoreSnapshotTierInput, options: CallOptions) !restore_snapshot_tier.RestoreSnapshotTierOutput {
        return restore_snapshot_tier.execute(self, allocator, input, options);
    }

    /// Restores a volume from the Recycle Bin. For more information, see [Restore
    /// volumes from the Recycle
    /// Bin](https://docs.aws.amazon.com/ebs/latest/userguide/recycle-bin-working-with-volumes.html#recycle-bin-restore-volumes) in the *Amazon EBS User Guide*.
    pub fn restoreVolumeFromRecycleBin(self: *Self, allocator: std.mem.Allocator, input: restore_volume_from_recycle_bin.RestoreVolumeFromRecycleBinInput, options: CallOptions) !restore_volume_from_recycle_bin.RestoreVolumeFromRecycleBinOutput {
        return restore_volume_from_recycle_bin.execute(self, allocator, input, options);
    }

    /// Removes an ingress authorization rule from a Client VPN endpoint.
    pub fn revokeClientVpnIngress(self: *Self, allocator: std.mem.Allocator, input: revoke_client_vpn_ingress.RevokeClientVpnIngressInput, options: CallOptions) !revoke_client_vpn_ingress.RevokeClientVpnIngressOutput {
        return revoke_client_vpn_ingress.execute(self, allocator, input, options);
    }

    /// Removes the specified outbound (egress) rules from the specified security
    /// group.
    ///
    /// You can specify rules using either rule IDs or security group rule
    /// properties. If you use
    /// rule properties, the values that you specify (for example, ports) must match
    /// the existing rule's
    /// values exactly. Each rule has a protocol, from and to ports, and destination
    /// (CIDR range,
    /// security group, or prefix list). For the TCP and UDP protocols, you must
    /// also specify the
    /// destination port or range of ports. For the ICMP protocol, you must also
    /// specify the ICMP type
    /// and code. If the security group rule has a description, you do not need to
    /// specify the description
    /// to revoke the rule.
    ///
    /// For a default VPC, if the values you specify do not match the existing
    /// rule's values, no error is
    /// returned, and the output describes the security group rules that were not
    /// revoked.
    ///
    /// Amazon Web Services recommends that you describe the security group to
    /// verify that the rules were removed.
    ///
    /// Rule changes are propagated to instances within the security group as
    /// quickly as possible. However,
    /// a small delay might occur.
    pub fn revokeSecurityGroupEgress(self: *Self, allocator: std.mem.Allocator, input: revoke_security_group_egress.RevokeSecurityGroupEgressInput, options: CallOptions) !revoke_security_group_egress.RevokeSecurityGroupEgressOutput {
        return revoke_security_group_egress.execute(self, allocator, input, options);
    }

    /// Removes the specified inbound (ingress) rules from a security group.
    ///
    /// You can specify rules using either rule IDs or security group rule
    /// properties. If you use
    /// rule properties, the values that you specify (for example, ports) must match
    /// the existing rule's
    /// values exactly. Each rule has a protocol, from and to ports, and source
    /// (CIDR range,
    /// security group, or prefix list). For the TCP and UDP protocols, you must
    /// also specify the
    /// destination port or range of ports. For the ICMP protocol, you must also
    /// specify the ICMP type
    /// and code. If the security group rule has a description, you do not need to
    /// specify the description
    /// to revoke the rule.
    ///
    /// For a default VPC, if the values you specify do not match the existing
    /// rule's values,
    /// no error is returned, and the output describes the security group rules that
    /// were not
    /// revoked.
    ///
    /// For a non-default VPC, if the values you specify do not match the existing
    /// rule's
    /// values, an `InvalidPermission.NotFound` client error is returned, and no
    /// rules are revoked.
    ///
    /// Amazon Web Services recommends that you describe the security group to
    /// verify that the rules were removed.
    ///
    /// Rule changes are propagated to instances within the security group as
    /// quickly as possible.
    /// However, a small delay might occur.
    pub fn revokeSecurityGroupIngress(self: *Self, allocator: std.mem.Allocator, input: revoke_security_group_ingress.RevokeSecurityGroupIngressInput, options: CallOptions) !revoke_security_group_ingress.RevokeSecurityGroupIngressOutput {
        return revoke_security_group_ingress.execute(self, allocator, input, options);
    }

    /// Launches the specified number of instances using an AMI for which you have
    /// permissions.
    ///
    /// You can specify a number of options, or leave the default options. The
    /// following rules
    /// apply:
    ///
    /// * If you don't specify a subnet ID, we choose a default subnet from
    /// your default VPC for you. If you don't have a default VPC, you must specify
    /// a
    /// subnet ID in the request.
    ///
    /// * All instances have a network interface with a primary private IPv4
    /// address. If you don't specify this address, we choose one from the IPv4
    /// range of
    /// your subnet.
    ///
    /// * Not all instance types support IPv6 addresses. For more information, see
    /// [Instance
    /// types](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-types.html).
    ///
    /// * If you don't specify a security group ID, we use the default security
    ///   group
    /// for the VPC. For more information, see [Security
    /// groups](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html).
    ///
    /// * If any of the AMIs have a product code attached for which the user has not
    /// subscribed, the request fails.
    ///
    /// You can create a [launch
    /// template](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-launch-templates.html),
    /// which is a resource that contains the parameters to launch an instance. When
    /// you launch
    /// an instance using RunInstances, you can specify the launch template
    /// instead of specifying the launch parameters.
    ///
    /// To ensure faster instance launches, break up large requests into smaller
    /// batches. For
    /// example, create five separate launch requests for 100 instances each instead
    /// of one
    /// launch request for 500 instances.
    ///
    /// `RunInstances` is subject to both request rate limiting and resource rate
    /// limiting. For more information, see [Request
    /// throttling](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-throttling.html).
    ///
    /// An instance is ready for you to use when it's in the `running` state. You
    /// can check the state of your instance using DescribeInstances. You can
    /// tag instances and EBS volumes during launch, after launch, or both. For more
    /// information, see CreateTags and [Tagging your Amazon EC2
    /// resources](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html).
    ///
    /// Linux instances have access to the public key of the key pair at boot. You
    /// can use
    /// this key to provide secure access to the instance. Amazon EC2 public images
    /// use this
    /// feature to provide secure access without passwords. For more information,
    /// see [Key
    /// pairs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-key-pairs.html).
    ///
    /// For troubleshooting, see [What to do if
    /// an instance immediately
    /// terminates](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_InstanceStraightToTerminated.html), and [Troubleshooting connecting to your instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html).
    pub fn runInstances(self: *Self, allocator: std.mem.Allocator, input: run_instances.RunInstancesInput, options: CallOptions) !run_instances.RunInstancesOutput {
        return run_instances.execute(self, allocator, input, options);
    }

    /// Launches the specified Scheduled Instances.
    ///
    /// Before you can launch a Scheduled Instance, you must purchase it and obtain
    /// an identifier using PurchaseScheduledInstances.
    ///
    /// You must launch a Scheduled Instance during its scheduled time period. You
    /// can't stop or
    /// reboot a Scheduled Instance, but you can terminate it as needed. If you
    /// terminate a
    /// Scheduled Instance before the current scheduled time period ends, you can
    /// launch it again
    /// after a few minutes.
    pub fn runScheduledInstances(self: *Self, allocator: std.mem.Allocator, input: run_scheduled_instances.RunScheduledInstancesInput, options: CallOptions) !run_scheduled_instances.RunScheduledInstancesOutput {
        return run_scheduled_instances.execute(self, allocator, input, options);
    }

    /// Searches for routes in the specified local gateway route table.
    pub fn searchLocalGatewayRoutes(self: *Self, allocator: std.mem.Allocator, input: search_local_gateway_routes.SearchLocalGatewayRoutesInput, options: CallOptions) !search_local_gateway_routes.SearchLocalGatewayRoutesOutput {
        return search_local_gateway_routes.execute(self, allocator, input, options);
    }

    /// Searches one or more transit gateway multicast groups and returns the group
    /// membership information.
    pub fn searchTransitGatewayMulticastGroups(self: *Self, allocator: std.mem.Allocator, input: search_transit_gateway_multicast_groups.SearchTransitGatewayMulticastGroupsInput, options: CallOptions) !search_transit_gateway_multicast_groups.SearchTransitGatewayMulticastGroupsOutput {
        return search_transit_gateway_multicast_groups.execute(self, allocator, input, options);
    }

    /// Searches for routes in the specified transit gateway route table.
    pub fn searchTransitGatewayRoutes(self: *Self, allocator: std.mem.Allocator, input: search_transit_gateway_routes.SearchTransitGatewayRoutesInput, options: CallOptions) !search_transit_gateway_routes.SearchTransitGatewayRoutesOutput {
        return search_transit_gateway_routes.execute(self, allocator, input, options);
    }

    /// Sends a diagnostic interrupt to the specified Amazon EC2 instance to trigger
    /// a
    /// *kernel panic* (on Linux instances), or a *blue
    /// screen*/*stop error* (on Windows instances). For
    /// instances based on Intel and AMD processors, the interrupt is received as a
    /// *non-maskable interrupt* (NMI).
    ///
    /// In general, the operating system crashes and reboots when a kernel panic or
    /// stop error
    /// is triggered. The operating system can also be configured to perform
    /// diagnostic tasks,
    /// such as generating a memory dump file, loading a secondary kernel, or
    /// obtaining a call
    /// trace.
    ///
    /// Before sending a diagnostic interrupt to your instance, ensure that its
    /// operating
    /// system is configured to perform the required diagnostic tasks.
    ///
    /// For more information about configuring your operating system to generate a
    /// crash dump
    /// when a kernel panic or stop error occurs, see [Send a diagnostic interrupt
    /// (for advanced
    /// users)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/diagnostic-interrupt.html) in the *Amazon EC2 User Guide*.
    pub fn sendDiagnosticInterrupt(self: *Self, allocator: std.mem.Allocator, input: send_diagnostic_interrupt.SendDiagnosticInterruptInput, options: CallOptions) !send_diagnostic_interrupt.SendDiagnosticInterruptOutput {
        return send_diagnostic_interrupt.execute(self, allocator, input, options);
    }

    /// Generates an account status report. The report is generated asynchronously,
    /// and can
    /// take several hours to complete.
    ///
    /// The report provides the current status of all attributes supported by
    /// declarative
    /// policies for the accounts within the specified scope. The scope is
    /// determined by the
    /// specified `TargetId`, which can represent an individual account, or all the
    /// accounts that fall under the specified organizational unit (OU) or root (the
    /// entire
    /// Amazon Web Services Organization).
    ///
    /// The report is saved to your specified S3 bucket, using the following path
    /// structure
    /// (with the capitalized placeholders representing your specific values):
    ///
    /// `s3://AMZN-S3-DEMO-BUCKET/YOUR-OPTIONAL-S3-PREFIX/ec2_TARGETID_REPORTID_YYYYMMDDTHHMMZ.csv`
    ///
    /// **Prerequisites for generating a report**
    ///
    /// * The `StartDeclarativePoliciesReport` API can only be called by the
    /// management account or delegated administrators for the organization.
    ///
    /// * An S3 bucket must be available before generating the report (you can
    ///   create a
    /// new one or use an existing one), it must be in the same Region where the
    /// report
    /// generation request is made, and it must have an appropriate bucket policy.
    /// For a
    /// sample S3 policy, see *Sample Amazon S3 policy* under
    /// [Examples](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_StartDeclarativePoliciesReport.html#API_StartDeclarativePoliciesReport_Examples).
    ///
    /// * Trusted access must be enabled for the service for which the declarative
    /// policy will enforce a baseline configuration. If you use the Amazon Web
    /// Services Organizations
    /// console, this is done automatically when you enable declarative policies.
    /// The
    /// API uses the following service principal to identify the EC2 service:
    /// `ec2.amazonaws.com`. For more information on how to enable
    /// trusted access with the Amazon Web Services CLI and Amazon Web Services
    /// SDKs, see [Using
    /// Organizations with other Amazon Web Services
    /// services](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_integrate_services.html) in the
    /// *Amazon Web Services Organizations User Guide*.
    ///
    /// * Only one report per organization can be generated at a time. Attempting to
    /// generate a report while another is in progress will result in an error.
    ///
    /// For more information, including the required IAM permissions to run this
    /// API, see
    /// [Generating the account status report for declarative
    /// policies](https://docs.aws.amazon.com/organizations/latest/userguide/orgs_manage_policies_declarative_status-report.html) in the
    /// *Amazon Web Services Organizations User Guide*.
    pub fn startDeclarativePoliciesReport(self: *Self, allocator: std.mem.Allocator, input: start_declarative_policies_report.StartDeclarativePoliciesReportInput, options: CallOptions) !start_declarative_policies_report.StartDeclarativePoliciesReportOutput {
        return start_declarative_policies_report.execute(self, allocator, input, options);
    }

    /// Starts an Amazon EBS-backed instance that you've previously stopped.
    ///
    /// Instances that use Amazon EBS volumes as their root devices can be quickly
    /// stopped and
    /// started. When an instance is stopped, the compute resources are released and
    /// you are not
    /// billed for instance usage. However, your root partition Amazon EBS volume
    /// remains and
    /// continues to persist your data, and you are charged for Amazon EBS volume
    /// usage. You can
    /// restart your instance at any time. Every time you start your instance,
    /// Amazon EC2
    /// charges a one-minute minimum for instance usage, and thereafter charges per
    /// second for
    /// instance usage.
    ///
    /// Before stopping an instance, make sure it is in a state from which it can be
    /// restarted. Stopping an instance does not preserve data stored in RAM.
    ///
    /// Performing this operation on an instance that uses an instance store as its
    /// root
    /// device returns an error.
    ///
    /// If you attempt to start a T3 instance with `host` tenancy and the
    /// `unlimited` CPU credit option, the request fails. The
    /// `unlimited` CPU credit option is not supported on Dedicated Hosts. Before
    /// you start the instance, either change its CPU credit option to `standard`,
    /// or
    /// change its tenancy to `default` or `dedicated`.
    ///
    /// For more information, see [Stop and start Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Stop_Start.html) in the *Amazon EC2 User Guide*.
    pub fn startInstances(self: *Self, allocator: std.mem.Allocator, input: start_instances.StartInstancesInput, options: CallOptions) !start_instances.StartInstancesOutput {
        return start_instances.execute(self, allocator, input, options);
    }

    /// Starts analyzing the specified Network Access Scope.
    pub fn startNetworkInsightsAccessScopeAnalysis(self: *Self, allocator: std.mem.Allocator, input: start_network_insights_access_scope_analysis.StartNetworkInsightsAccessScopeAnalysisInput, options: CallOptions) !start_network_insights_access_scope_analysis.StartNetworkInsightsAccessScopeAnalysisOutput {
        return start_network_insights_access_scope_analysis.execute(self, allocator, input, options);
    }

    /// Starts analyzing the specified path. If the path is reachable, the
    /// operation returns the shortest feasible path.
    pub fn startNetworkInsightsAnalysis(self: *Self, allocator: std.mem.Allocator, input: start_network_insights_analysis.StartNetworkInsightsAnalysisInput, options: CallOptions) !start_network_insights_analysis.StartNetworkInsightsAnalysisOutput {
        return start_network_insights_analysis.execute(self, allocator, input, options);
    }

    /// Initiates the verification process to prove that the service provider owns
    /// the private
    /// DNS name domain for the endpoint service.
    ///
    /// The service provider must successfully perform the verification before the
    /// consumer can use the name to access the service.
    ///
    /// Before the service provider runs this command, they must add a record to the
    /// DNS server.
    pub fn startVpcEndpointServicePrivateDnsVerification(self: *Self, allocator: std.mem.Allocator, input: start_vpc_endpoint_service_private_dns_verification.StartVpcEndpointServicePrivateDnsVerificationInput, options: CallOptions) !start_vpc_endpoint_service_private_dns_verification.StartVpcEndpointServicePrivateDnsVerificationOutput {
        return start_vpc_endpoint_service_private_dns_verification.execute(self, allocator, input, options);
    }

    /// Stops an Amazon EBS-backed instance. You can restart your instance at any
    /// time using
    /// the
    /// [StartInstances](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/API_StartInstances.html) API. For more information, see [Stop and start Amazon EC2
    /// instances](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Stop_Start.html) in the *Amazon EC2 User Guide*.
    ///
    /// When you stop or hibernate an instance, we shut it down. By default, this
    /// includes a
    /// graceful operating system (OS) shutdown. To bypass the graceful shutdown,
    /// use the
    /// `skipOsShutdown` parameter; however, this might risk data
    /// integrity.
    ///
    /// You can use the StopInstances operation together with the `Hibernate`
    /// parameter to hibernate an instance if the instance is [enabled for
    /// hibernation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/enabling-hibernation.html) and meets the [hibernation
    /// prerequisites](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hibernating-prerequisites.html). Stopping an instance doesn't preserve data stored in RAM,
    /// while hibernation does. If hibernation fails, a normal shutdown occurs. For
    /// more
    /// information, see [Hibernate your Amazon EC2
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Hibernate.html) in the *Amazon EC2 User Guide*.
    ///
    /// If your instance appears stuck in the `stopping` state, there might be an
    /// issue with the underlying host computer. You can use the StopInstances
    /// operation
    /// together with the Force parameter to force stop your instance. For more
    /// information, see
    /// [Troubleshoot
    /// Amazon EC2 instance stop
    /// issues](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesStopping.html) in the
    /// *Amazon EC2 User Guide*.
    ///
    /// Stopping and hibernating an instance differs from rebooting or terminating
    /// it. For
    /// example, a stopped or hibernated instance retains its root volume and any
    /// data volumes,
    /// unlike terminated instances where these volumes are automatically deleted.
    /// For more
    /// information about the differences between stopping, hibernating, rebooting,
    /// and
    /// terminating instances, see [Amazon EC2
    /// instance state
    /// changes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-lifecycle.html) in the *Amazon EC2 User Guide*.
    ///
    /// We don't charge for instance usage or data transfer fees when an instance is
    /// stopped.
    /// However, the root volume and any data volumes remain and continue to persist
    /// your data,
    /// and you're charged for volume usage. Every time you start your instance,
    /// Amazon EC2 charges a one-minute minimum for instance usage, followed by
    /// per-second
    /// billing.
    ///
    /// You can't stop or hibernate instance store-backed instances.
    pub fn stopInstances(self: *Self, allocator: std.mem.Allocator, input: stop_instances.StopInstancesInput, options: CallOptions) !stop_instances.StopInstancesOutput {
        return stop_instances.execute(self, allocator, input, options);
    }

    /// Terminates active Client VPN endpoint connections. This action can be used
    /// to terminate a specific client connection, or up to five connections
    /// established by a specific user.
    pub fn terminateClientVpnConnections(self: *Self, allocator: std.mem.Allocator, input: terminate_client_vpn_connections.TerminateClientVpnConnectionsInput, options: CallOptions) !terminate_client_vpn_connections.TerminateClientVpnConnectionsOutput {
        return terminate_client_vpn_connections.execute(self, allocator, input, options);
    }

    /// Terminates (deletes) the specified instances. This operation is
    /// [idempotent](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html); if you
    /// terminate an instance more than once, each call succeeds.
    ///
    /// **Terminating an instance is permanent and irreversible.**
    ///
    /// After you terminate an instance, you can no longer connect to it, and it
    /// can't be recovered.
    /// All attached Amazon EBS volumes that are configured to be deleted on
    /// termination are also permanently
    /// deleted and can't be recovered. All data stored on instance store volumes is
    /// permanently lost.
    /// For more information, see [
    /// How instance termination
    /// works](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/how-ec2-instance-termination-works.html).
    ///
    /// Before you terminate an instance, ensure that you have backed up all data
    /// that you need to
    /// retain after the termination to persistent storage.
    ///
    /// If you specify multiple instances and the request fails (for example,
    /// because of a
    /// single incorrect instance ID), none of the instances are terminated.
    ///
    /// If you terminate multiple instances across multiple Availability Zones, and
    /// one or
    /// more of the specified instances are enabled for termination protection, the
    /// request
    /// fails with the following results:
    ///
    /// * The specified instances that are in the same Availability Zone as the
    /// protected instance are not terminated.
    ///
    /// * The specified instances that are in different Availability Zones, where no
    /// other specified instances are protected, are successfully terminated.
    ///
    /// For example, say you have the following instances:
    ///
    /// * Instance A: `us-east-1a`; Not protected
    ///
    /// * Instance B: `us-east-1a`; Not protected
    ///
    /// * Instance C: `us-east-1b`; Protected
    ///
    /// * Instance D: `us-east-1b`; not protected
    ///
    /// If you attempt to terminate all of these instances in the same request, the
    /// request
    /// reports failure with the following results:
    ///
    /// * Instance A and Instance B are successfully terminated because none of the
    /// specified instances in `us-east-1a` are enabled for termination
    /// protection.
    ///
    /// * Instance C and Instance D fail to terminate because at least one of the
    /// specified instances in `us-east-1b` (Instance C) is enabled for
    /// termination protection.
    ///
    /// Terminated instances remain visible after termination (for approximately one
    /// hour).
    ///
    /// By default, Amazon EC2 deletes all EBS volumes that were attached when the
    /// instance
    /// launched. Volumes attached after instance launch continue running.
    ///
    /// By default, the TerminateInstances operation includes a graceful operating
    /// system (OS)
    /// shutdown. To bypass the graceful shutdown, use the `skipOsShutdown`
    /// parameter; however, this might risk data integrity.
    ///
    /// You can stop, start, and terminate EBS-backed instances. You can only
    /// terminate
    /// instance store-backed instances. What happens to an instance differs if you
    /// stop or
    /// terminate it. For example, when you stop an instance, the root device and
    /// any other
    /// devices attached to the instance persist. When you terminate an instance,
    /// any attached
    /// EBS volumes with the `DeleteOnTermination` block device mapping parameter
    /// set
    /// to `true` are automatically deleted. For more information about the
    /// differences between stopping and terminating instances, see [Amazon EC2
    /// instance state
    /// changes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ec2-instance-lifecycle.html) in the *Amazon EC2 User Guide*.
    ///
    /// When you terminate an instance, we attempt to terminate it forcibly after a
    /// short
    /// while. If your instance appears stuck in the shutting-down state after a
    /// period of time,
    /// there might be an issue with the underlying host computer. For more
    /// information about
    /// terminating and troubleshooting terminating your instances, see [Terminate
    /// Amazon EC2 instances](https://docs.aws.amazon.com/) and
    /// [Troubleshooting terminating your
    /// instance](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesShuttingDown.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn terminateInstances(self: *Self, allocator: std.mem.Allocator, input: terminate_instances.TerminateInstancesInput, options: CallOptions) !terminate_instances.TerminateInstancesOutput {
        return terminate_instances.execute(self, allocator, input, options);
    }

    /// Unassigns the specified IPv6 addresses or Prefix Delegation prefixes from a
    /// network
    /// interface.
    pub fn unassignIpv6Addresses(self: *Self, allocator: std.mem.Allocator, input: unassign_ipv_6_addresses.UnassignIpv6AddressesInput, options: CallOptions) !unassign_ipv_6_addresses.UnassignIpv6AddressesOutput {
        return unassign_ipv_6_addresses.execute(self, allocator, input, options);
    }

    /// Unassigns the specified secondary private IP addresses or IPv4 Prefix
    /// Delegation
    /// prefixes from a network interface.
    pub fn unassignPrivateIpAddresses(self: *Self, allocator: std.mem.Allocator, input: unassign_private_ip_addresses.UnassignPrivateIpAddressesInput, options: CallOptions) !unassign_private_ip_addresses.UnassignPrivateIpAddressesOutput {
        return unassign_private_ip_addresses.execute(self, allocator, input, options);
    }

    /// Unassigns secondary private IPv4 addresses from a private NAT gateway. You
    /// cannot unassign your primary private IP. For more information,
    /// see [Edit secondary IP address
    /// associations](https://docs.aws.amazon.com/vpc/latest/userguide/nat-gateway-working-with.html#nat-gateway-edit-secondary)
    /// in the *Amazon VPC User Guide*.
    ///
    /// While unassigning is in progress, you cannot assign/unassign additional IP
    /// addresses while the connections are being drained. You are, however, allowed
    /// to delete the NAT gateway.
    ///
    /// A private IP address will only be released at the end of
    /// MaxDrainDurationSeconds. The
    /// private IP addresses stay associated and support the existing connections,
    /// but do not
    /// support any new connections (new connections are distributed across the
    /// remaining
    /// assigned private IP address). After the existing connections drain out, the
    /// private IP
    /// addresses are released.
    pub fn unassignPrivateNatGatewayAddress(self: *Self, allocator: std.mem.Allocator, input: unassign_private_nat_gateway_address.UnassignPrivateNatGatewayAddressInput, options: CallOptions) !unassign_private_nat_gateway_address.UnassignPrivateNatGatewayAddressOutput {
        return unassign_private_nat_gateway_address.execute(self, allocator, input, options);
    }

    /// Unlocks a snapshot that is locked in governance mode or that is locked in
    /// compliance mode
    /// but still in the cooling-off period. You can't unlock a snapshot that is
    /// locked in compliance
    /// mode after the cooling-off period has expired.
    pub fn unlockSnapshot(self: *Self, allocator: std.mem.Allocator, input: unlock_snapshot.UnlockSnapshotInput, options: CallOptions) !unlock_snapshot.UnlockSnapshotOutput {
        return unlock_snapshot.execute(self, allocator, input, options);
    }

    /// Disables detailed monitoring for a running instance. For more information,
    /// see [Monitoring
    /// your instances and
    /// volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-cloudwatch.html) in the
    /// *Amazon EC2 User Guide*.
    pub fn unmonitorInstances(self: *Self, allocator: std.mem.Allocator, input: unmonitor_instances.UnmonitorInstancesInput, options: CallOptions) !unmonitor_instances.UnmonitorInstancesOutput {
        return unmonitor_instances.execute(self, allocator, input, options);
    }

    /// Updates the Organizations access setting for EC2 Capacity Manager. This
    /// controls whether Capacity Manager can aggregate
    /// data from all accounts in your Amazon Web Services Organization or only from
    /// the current account.
    pub fn updateCapacityManagerOrganizationsAccess(self: *Self, allocator: std.mem.Allocator, input: update_capacity_manager_organizations_access.UpdateCapacityManagerOrganizationsAccessInput, options: CallOptions) !update_capacity_manager_organizations_access.UpdateCapacityManagerOrganizationsAccessOutput {
        return update_capacity_manager_organizations_access.execute(self, allocator, input, options);
    }

    /// Modifies the number of instances allocated to an interruptible reservation,
    /// allowing you to add more capacity or reclaim capacity to your source
    /// Capacity Reservation.
    pub fn updateInterruptibleCapacityReservationAllocation(self: *Self, allocator: std.mem.Allocator, input: update_interruptible_capacity_reservation_allocation.UpdateInterruptibleCapacityReservationAllocationInput, options: CallOptions) !update_interruptible_capacity_reservation_allocation.UpdateInterruptibleCapacityReservationAllocationOutput {
        return update_interruptible_capacity_reservation_allocation.execute(self, allocator, input, options);
    }

    /// Updates the description of an egress (outbound) security group rule. You
    /// can replace an existing description, or add a description to a rule that did
    /// not have one
    /// previously. You can remove a description for a security group rule by
    /// omitting the
    /// description parameter in the request.
    pub fn updateSecurityGroupRuleDescriptionsEgress(self: *Self, allocator: std.mem.Allocator, input: update_security_group_rule_descriptions_egress.UpdateSecurityGroupRuleDescriptionsEgressInput, options: CallOptions) !update_security_group_rule_descriptions_egress.UpdateSecurityGroupRuleDescriptionsEgressOutput {
        return update_security_group_rule_descriptions_egress.execute(self, allocator, input, options);
    }

    /// Updates the description of an ingress (inbound) security group rule. You can
    /// replace an
    /// existing description, or add a description to a rule that did not have one
    /// previously.
    /// You can remove a description for a security group rule by omitting the
    /// description
    /// parameter in the request.
    pub fn updateSecurityGroupRuleDescriptionsIngress(self: *Self, allocator: std.mem.Allocator, input: update_security_group_rule_descriptions_ingress.UpdateSecurityGroupRuleDescriptionsIngressInput, options: CallOptions) !update_security_group_rule_descriptions_ingress.UpdateSecurityGroupRuleDescriptionsIngressOutput {
        return update_security_group_rule_descriptions_ingress.execute(self, allocator, input, options);
    }

    /// Stops advertising an address range that is provisioned as an address pool.
    ///
    /// You can perform this operation at most once every 10 seconds, even if you
    /// specify different
    /// address ranges each time.
    ///
    /// It can take a few minutes before traffic to the specified addresses stops
    /// routing to Amazon Web Services
    /// because of BGP propagation delays.
    pub fn withdrawByoipCidr(self: *Self, allocator: std.mem.Allocator, input: withdraw_byoip_cidr.WithdrawByoipCidrInput, options: CallOptions) !withdraw_byoip_cidr.WithdrawByoipCidrOutput {
        return withdraw_byoip_cidr.execute(self, allocator, input, options);
    }

    pub fn describeAddressTransfersPaginator(self: *Self, params: describe_address_transfers.DescribeAddressTransfersInput) paginator.DescribeAddressTransfersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAddressesAttributePaginator(self: *Self, params: describe_addresses_attribute.DescribeAddressesAttributeInput) paginator.DescribeAddressesAttributePaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeAwsNetworkPerformanceMetricSubscriptionsPaginator(self: *Self, params: describe_aws_network_performance_metric_subscriptions.DescribeAwsNetworkPerformanceMetricSubscriptionsInput) paginator.DescribeAwsNetworkPerformanceMetricSubscriptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeByoipCidrsPaginator(self: *Self, params: describe_byoip_cidrs.DescribeByoipCidrsInput) paginator.DescribeByoipCidrsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCapacityBlockExtensionHistoryPaginator(self: *Self, params: describe_capacity_block_extension_history.DescribeCapacityBlockExtensionHistoryInput) paginator.DescribeCapacityBlockExtensionHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCapacityBlockExtensionOfferingsPaginator(self: *Self, params: describe_capacity_block_extension_offerings.DescribeCapacityBlockExtensionOfferingsInput) paginator.DescribeCapacityBlockExtensionOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCapacityBlockOfferingsPaginator(self: *Self, params: describe_capacity_block_offerings.DescribeCapacityBlockOfferingsInput) paginator.DescribeCapacityBlockOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCapacityBlockStatusPaginator(self: *Self, params: describe_capacity_block_status.DescribeCapacityBlockStatusInput) paginator.DescribeCapacityBlockStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCapacityBlocksPaginator(self: *Self, params: describe_capacity_blocks.DescribeCapacityBlocksInput) paginator.DescribeCapacityBlocksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCapacityManagerDataExportsPaginator(self: *Self, params: describe_capacity_manager_data_exports.DescribeCapacityManagerDataExportsInput) paginator.DescribeCapacityManagerDataExportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCapacityReservationBillingRequestsPaginator(self: *Self, params: describe_capacity_reservation_billing_requests.DescribeCapacityReservationBillingRequestsInput) paginator.DescribeCapacityReservationBillingRequestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCapacityReservationFleetsPaginator(self: *Self, params: describe_capacity_reservation_fleets.DescribeCapacityReservationFleetsInput) paginator.DescribeCapacityReservationFleetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCapacityReservationsPaginator(self: *Self, params: describe_capacity_reservations.DescribeCapacityReservationsInput) paginator.DescribeCapacityReservationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCarrierGatewaysPaginator(self: *Self, params: describe_carrier_gateways.DescribeCarrierGatewaysInput) paginator.DescribeCarrierGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClassicLinkInstancesPaginator(self: *Self, params: describe_classic_link_instances.DescribeClassicLinkInstancesInput) paginator.DescribeClassicLinkInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClientVpnAuthorizationRulesPaginator(self: *Self, params: describe_client_vpn_authorization_rules.DescribeClientVpnAuthorizationRulesInput) paginator.DescribeClientVpnAuthorizationRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClientVpnConnectionsPaginator(self: *Self, params: describe_client_vpn_connections.DescribeClientVpnConnectionsInput) paginator.DescribeClientVpnConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClientVpnEndpointsPaginator(self: *Self, params: describe_client_vpn_endpoints.DescribeClientVpnEndpointsInput) paginator.DescribeClientVpnEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClientVpnRoutesPaginator(self: *Self, params: describe_client_vpn_routes.DescribeClientVpnRoutesInput) paginator.DescribeClientVpnRoutesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeClientVpnTargetNetworksPaginator(self: *Self, params: describe_client_vpn_target_networks.DescribeClientVpnTargetNetworksInput) paginator.DescribeClientVpnTargetNetworksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeCoipPoolsPaginator(self: *Self, params: describe_coip_pools.DescribeCoipPoolsInput) paginator.DescribeCoipPoolsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeDhcpOptionsPaginator(self: *Self, params: describe_dhcp_options.DescribeDhcpOptionsInput) paginator.DescribeDhcpOptionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeEgressOnlyInternetGatewaysPaginator(self: *Self, params: describe_egress_only_internet_gateways.DescribeEgressOnlyInternetGatewaysInput) paginator.DescribeEgressOnlyInternetGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeExportImageTasksPaginator(self: *Self, params: describe_export_image_tasks.DescribeExportImageTasksInput) paginator.DescribeExportImageTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFastLaunchImagesPaginator(self: *Self, params: describe_fast_launch_images.DescribeFastLaunchImagesInput) paginator.DescribeFastLaunchImagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFastSnapshotRestoresPaginator(self: *Self, params: describe_fast_snapshot_restores.DescribeFastSnapshotRestoresInput) paginator.DescribeFastSnapshotRestoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFleetsPaginator(self: *Self, params: describe_fleets.DescribeFleetsInput) paginator.DescribeFleetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFlowLogsPaginator(self: *Self, params: describe_flow_logs.DescribeFlowLogsInput) paginator.DescribeFlowLogsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeFpgaImagesPaginator(self: *Self, params: describe_fpga_images.DescribeFpgaImagesInput) paginator.DescribeFpgaImagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeHostReservationOfferingsPaginator(self: *Self, params: describe_host_reservation_offerings.DescribeHostReservationOfferingsInput) paginator.DescribeHostReservationOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeHostReservationsPaginator(self: *Self, params: describe_host_reservations.DescribeHostReservationsInput) paginator.DescribeHostReservationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeHostsPaginator(self: *Self, params: describe_hosts.DescribeHostsInput) paginator.DescribeHostsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeIamInstanceProfileAssociationsPaginator(self: *Self, params: describe_iam_instance_profile_associations.DescribeIamInstanceProfileAssociationsInput) paginator.DescribeIamInstanceProfileAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeImageReferencesPaginator(self: *Self, params: describe_image_references.DescribeImageReferencesInput) paginator.DescribeImageReferencesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeImageUsageReportEntriesPaginator(self: *Self, params: describe_image_usage_report_entries.DescribeImageUsageReportEntriesInput) paginator.DescribeImageUsageReportEntriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeImageUsageReportsPaginator(self: *Self, params: describe_image_usage_reports.DescribeImageUsageReportsInput) paginator.DescribeImageUsageReportsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeImagesPaginator(self: *Self, params: describe_images.DescribeImagesInput) paginator.DescribeImagesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeImportImageTasksPaginator(self: *Self, params: describe_import_image_tasks.DescribeImportImageTasksInput) paginator.DescribeImportImageTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeImportSnapshotTasksPaginator(self: *Self, params: describe_import_snapshot_tasks.DescribeImportSnapshotTasksInput) paginator.DescribeImportSnapshotTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceConnectEndpointsPaginator(self: *Self, params: describe_instance_connect_endpoints.DescribeInstanceConnectEndpointsInput) paginator.DescribeInstanceConnectEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceCreditSpecificationsPaginator(self: *Self, params: describe_instance_credit_specifications.DescribeInstanceCreditSpecificationsInput) paginator.DescribeInstanceCreditSpecificationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceEventWindowsPaginator(self: *Self, params: describe_instance_event_windows.DescribeInstanceEventWindowsInput) paginator.DescribeInstanceEventWindowsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceImageMetadataPaginator(self: *Self, params: describe_instance_image_metadata.DescribeInstanceImageMetadataInput) paginator.DescribeInstanceImageMetadataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceStatusPaginator(self: *Self, params: describe_instance_status.DescribeInstanceStatusInput) paginator.DescribeInstanceStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceTopologyPaginator(self: *Self, params: describe_instance_topology.DescribeInstanceTopologyInput) paginator.DescribeInstanceTopologyPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceTypeOfferingsPaginator(self: *Self, params: describe_instance_type_offerings.DescribeInstanceTypeOfferingsInput) paginator.DescribeInstanceTypeOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstanceTypesPaginator(self: *Self, params: describe_instance_types.DescribeInstanceTypesInput) paginator.DescribeInstanceTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInstancesPaginator(self: *Self, params: describe_instances.DescribeInstancesInput) paginator.DescribeInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeInternetGatewaysPaginator(self: *Self, params: describe_internet_gateways.DescribeInternetGatewaysInput) paginator.DescribeInternetGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeIpamPoolsPaginator(self: *Self, params: describe_ipam_pools.DescribeIpamPoolsInput) paginator.DescribeIpamPoolsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeIpamPrefixListResolverTargetsPaginator(self: *Self, params: describe_ipam_prefix_list_resolver_targets.DescribeIpamPrefixListResolverTargetsInput) paginator.DescribeIpamPrefixListResolverTargetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeIpamPrefixListResolversPaginator(self: *Self, params: describe_ipam_prefix_list_resolvers.DescribeIpamPrefixListResolversInput) paginator.DescribeIpamPrefixListResolversPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeIpamResourceDiscoveriesPaginator(self: *Self, params: describe_ipam_resource_discoveries.DescribeIpamResourceDiscoveriesInput) paginator.DescribeIpamResourceDiscoveriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeIpamResourceDiscoveryAssociationsPaginator(self: *Self, params: describe_ipam_resource_discovery_associations.DescribeIpamResourceDiscoveryAssociationsInput) paginator.DescribeIpamResourceDiscoveryAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeIpamScopesPaginator(self: *Self, params: describe_ipam_scopes.DescribeIpamScopesInput) paginator.DescribeIpamScopesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeIpamsPaginator(self: *Self, params: describe_ipams.DescribeIpamsInput) paginator.DescribeIpamsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeIpv6PoolsPaginator(self: *Self, params: describe_ipv_6_pools.DescribeIpv6PoolsInput) paginator.DescribeIpv6PoolsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLaunchTemplateVersionsPaginator(self: *Self, params: describe_launch_template_versions.DescribeLaunchTemplateVersionsInput) paginator.DescribeLaunchTemplateVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLaunchTemplatesPaginator(self: *Self, params: describe_launch_templates.DescribeLaunchTemplatesInput) paginator.DescribeLaunchTemplatesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLocalGatewayRouteTableVirtualInterfaceGroupAssociationsPaginator(self: *Self, params: describe_local_gateway_route_table_virtual_interface_group_associations.DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociationsInput) paginator.DescribeLocalGatewayRouteTableVirtualInterfaceGroupAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLocalGatewayRouteTableVpcAssociationsPaginator(self: *Self, params: describe_local_gateway_route_table_vpc_associations.DescribeLocalGatewayRouteTableVpcAssociationsInput) paginator.DescribeLocalGatewayRouteTableVpcAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLocalGatewayRouteTablesPaginator(self: *Self, params: describe_local_gateway_route_tables.DescribeLocalGatewayRouteTablesInput) paginator.DescribeLocalGatewayRouteTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLocalGatewayVirtualInterfaceGroupsPaginator(self: *Self, params: describe_local_gateway_virtual_interface_groups.DescribeLocalGatewayVirtualInterfaceGroupsInput) paginator.DescribeLocalGatewayVirtualInterfaceGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLocalGatewayVirtualInterfacesPaginator(self: *Self, params: describe_local_gateway_virtual_interfaces.DescribeLocalGatewayVirtualInterfacesInput) paginator.DescribeLocalGatewayVirtualInterfacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeLocalGatewaysPaginator(self: *Self, params: describe_local_gateways.DescribeLocalGatewaysInput) paginator.DescribeLocalGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMacHostsPaginator(self: *Self, params: describe_mac_hosts.DescribeMacHostsInput) paginator.DescribeMacHostsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMacModificationTasksPaginator(self: *Self, params: describe_mac_modification_tasks.DescribeMacModificationTasksInput) paginator.DescribeMacModificationTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeManagedPrefixListsPaginator(self: *Self, params: describe_managed_prefix_lists.DescribeManagedPrefixListsInput) paginator.DescribeManagedPrefixListsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeMovingAddressesPaginator(self: *Self, params: describe_moving_addresses.DescribeMovingAddressesInput) paginator.DescribeMovingAddressesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNatGatewaysPaginator(self: *Self, params: describe_nat_gateways.DescribeNatGatewaysInput) paginator.DescribeNatGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNetworkAclsPaginator(self: *Self, params: describe_network_acls.DescribeNetworkAclsInput) paginator.DescribeNetworkAclsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNetworkInsightsAccessScopeAnalysesPaginator(self: *Self, params: describe_network_insights_access_scope_analyses.DescribeNetworkInsightsAccessScopeAnalysesInput) paginator.DescribeNetworkInsightsAccessScopeAnalysesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNetworkInsightsAccessScopesPaginator(self: *Self, params: describe_network_insights_access_scopes.DescribeNetworkInsightsAccessScopesInput) paginator.DescribeNetworkInsightsAccessScopesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNetworkInsightsAnalysesPaginator(self: *Self, params: describe_network_insights_analyses.DescribeNetworkInsightsAnalysesInput) paginator.DescribeNetworkInsightsAnalysesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNetworkInsightsPathsPaginator(self: *Self, params: describe_network_insights_paths.DescribeNetworkInsightsPathsInput) paginator.DescribeNetworkInsightsPathsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNetworkInterfacePermissionsPaginator(self: *Self, params: describe_network_interface_permissions.DescribeNetworkInterfacePermissionsInput) paginator.DescribeNetworkInterfacePermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeNetworkInterfacesPaginator(self: *Self, params: describe_network_interfaces.DescribeNetworkInterfacesInput) paginator.DescribeNetworkInterfacesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePrefixListsPaginator(self: *Self, params: describe_prefix_lists.DescribePrefixListsInput) paginator.DescribePrefixListsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePrincipalIdFormatPaginator(self: *Self, params: describe_principal_id_format.DescribePrincipalIdFormatInput) paginator.DescribePrincipalIdFormatPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describePublicIpv4PoolsPaginator(self: *Self, params: describe_public_ipv_4_pools.DescribePublicIpv4PoolsInput) paginator.DescribePublicIpv4PoolsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReplaceRootVolumeTasksPaginator(self: *Self, params: describe_replace_root_volume_tasks.DescribeReplaceRootVolumeTasksInput) paginator.DescribeReplaceRootVolumeTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedInstancesModificationsPaginator(self: *Self, params: describe_reserved_instances_modifications.DescribeReservedInstancesModificationsInput) paginator.DescribeReservedInstancesModificationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeReservedInstancesOfferingsPaginator(self: *Self, params: describe_reserved_instances_offerings.DescribeReservedInstancesOfferingsInput) paginator.DescribeReservedInstancesOfferingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRouteServerEndpointsPaginator(self: *Self, params: describe_route_server_endpoints.DescribeRouteServerEndpointsInput) paginator.DescribeRouteServerEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRouteServerPeersPaginator(self: *Self, params: describe_route_server_peers.DescribeRouteServerPeersInput) paginator.DescribeRouteServerPeersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRouteServersPaginator(self: *Self, params: describe_route_servers.DescribeRouteServersInput) paginator.DescribeRouteServersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeRouteTablesPaginator(self: *Self, params: describe_route_tables.DescribeRouteTablesInput) paginator.DescribeRouteTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeScheduledInstanceAvailabilityPaginator(self: *Self, params: describe_scheduled_instance_availability.DescribeScheduledInstanceAvailabilityInput) paginator.DescribeScheduledInstanceAvailabilityPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeScheduledInstancesPaginator(self: *Self, params: describe_scheduled_instances.DescribeScheduledInstancesInput) paginator.DescribeScheduledInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSecurityGroupRulesPaginator(self: *Self, params: describe_security_group_rules.DescribeSecurityGroupRulesInput) paginator.DescribeSecurityGroupRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSecurityGroupVpcAssociationsPaginator(self: *Self, params: describe_security_group_vpc_associations.DescribeSecurityGroupVpcAssociationsInput) paginator.DescribeSecurityGroupVpcAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSecurityGroupsPaginator(self: *Self, params: describe_security_groups.DescribeSecurityGroupsInput) paginator.DescribeSecurityGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSnapshotTierStatusPaginator(self: *Self, params: describe_snapshot_tier_status.DescribeSnapshotTierStatusInput) paginator.DescribeSnapshotTierStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSnapshotsPaginator(self: *Self, params: describe_snapshots.DescribeSnapshotsInput) paginator.DescribeSnapshotsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSpotFleetRequestsPaginator(self: *Self, params: describe_spot_fleet_requests.DescribeSpotFleetRequestsInput) paginator.DescribeSpotFleetRequestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSpotInstanceRequestsPaginator(self: *Self, params: describe_spot_instance_requests.DescribeSpotInstanceRequestsInput) paginator.DescribeSpotInstanceRequestsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSpotPriceHistoryPaginator(self: *Self, params: describe_spot_price_history.DescribeSpotPriceHistoryInput) paginator.DescribeSpotPriceHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeStaleSecurityGroupsPaginator(self: *Self, params: describe_stale_security_groups.DescribeStaleSecurityGroupsInput) paginator.DescribeStaleSecurityGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeStoreImageTasksPaginator(self: *Self, params: describe_store_image_tasks.DescribeStoreImageTasksInput) paginator.DescribeStoreImageTasksPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeSubnetsPaginator(self: *Self, params: describe_subnets.DescribeSubnetsInput) paginator.DescribeSubnetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTagsPaginator(self: *Self, params: describe_tags.DescribeTagsInput) paginator.DescribeTagsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTrafficMirrorFiltersPaginator(self: *Self, params: describe_traffic_mirror_filters.DescribeTrafficMirrorFiltersInput) paginator.DescribeTrafficMirrorFiltersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTrafficMirrorSessionsPaginator(self: *Self, params: describe_traffic_mirror_sessions.DescribeTrafficMirrorSessionsInput) paginator.DescribeTrafficMirrorSessionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTrafficMirrorTargetsPaginator(self: *Self, params: describe_traffic_mirror_targets.DescribeTrafficMirrorTargetsInput) paginator.DescribeTrafficMirrorTargetsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTransitGatewayAttachmentsPaginator(self: *Self, params: describe_transit_gateway_attachments.DescribeTransitGatewayAttachmentsInput) paginator.DescribeTransitGatewayAttachmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTransitGatewayConnectPeersPaginator(self: *Self, params: describe_transit_gateway_connect_peers.DescribeTransitGatewayConnectPeersInput) paginator.DescribeTransitGatewayConnectPeersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTransitGatewayConnectsPaginator(self: *Self, params: describe_transit_gateway_connects.DescribeTransitGatewayConnectsInput) paginator.DescribeTransitGatewayConnectsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTransitGatewayMulticastDomainsPaginator(self: *Self, params: describe_transit_gateway_multicast_domains.DescribeTransitGatewayMulticastDomainsInput) paginator.DescribeTransitGatewayMulticastDomainsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTransitGatewayPeeringAttachmentsPaginator(self: *Self, params: describe_transit_gateway_peering_attachments.DescribeTransitGatewayPeeringAttachmentsInput) paginator.DescribeTransitGatewayPeeringAttachmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTransitGatewayPolicyTablesPaginator(self: *Self, params: describe_transit_gateway_policy_tables.DescribeTransitGatewayPolicyTablesInput) paginator.DescribeTransitGatewayPolicyTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTransitGatewayRouteTableAnnouncementsPaginator(self: *Self, params: describe_transit_gateway_route_table_announcements.DescribeTransitGatewayRouteTableAnnouncementsInput) paginator.DescribeTransitGatewayRouteTableAnnouncementsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTransitGatewayRouteTablesPaginator(self: *Self, params: describe_transit_gateway_route_tables.DescribeTransitGatewayRouteTablesInput) paginator.DescribeTransitGatewayRouteTablesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTransitGatewayVpcAttachmentsPaginator(self: *Self, params: describe_transit_gateway_vpc_attachments.DescribeTransitGatewayVpcAttachmentsInput) paginator.DescribeTransitGatewayVpcAttachmentsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTransitGatewaysPaginator(self: *Self, params: describe_transit_gateways.DescribeTransitGatewaysInput) paginator.DescribeTransitGatewaysPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeTrunkInterfaceAssociationsPaginator(self: *Self, params: describe_trunk_interface_associations.DescribeTrunkInterfaceAssociationsInput) paginator.DescribeTrunkInterfaceAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVerifiedAccessEndpointsPaginator(self: *Self, params: describe_verified_access_endpoints.DescribeVerifiedAccessEndpointsInput) paginator.DescribeVerifiedAccessEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVerifiedAccessGroupsPaginator(self: *Self, params: describe_verified_access_groups.DescribeVerifiedAccessGroupsInput) paginator.DescribeVerifiedAccessGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVerifiedAccessInstanceLoggingConfigurationsPaginator(self: *Self, params: describe_verified_access_instance_logging_configurations.DescribeVerifiedAccessInstanceLoggingConfigurationsInput) paginator.DescribeVerifiedAccessInstanceLoggingConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVerifiedAccessInstancesPaginator(self: *Self, params: describe_verified_access_instances.DescribeVerifiedAccessInstancesInput) paginator.DescribeVerifiedAccessInstancesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVerifiedAccessTrustProvidersPaginator(self: *Self, params: describe_verified_access_trust_providers.DescribeVerifiedAccessTrustProvidersInput) paginator.DescribeVerifiedAccessTrustProvidersPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVolumeStatusPaginator(self: *Self, params: describe_volume_status.DescribeVolumeStatusInput) paginator.DescribeVolumeStatusPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVolumesPaginator(self: *Self, params: describe_volumes.DescribeVolumesInput) paginator.DescribeVolumesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVolumesModificationsPaginator(self: *Self, params: describe_volumes_modifications.DescribeVolumesModificationsInput) paginator.DescribeVolumesModificationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVpcClassicLinkDnsSupportPaginator(self: *Self, params: describe_vpc_classic_link_dns_support.DescribeVpcClassicLinkDnsSupportInput) paginator.DescribeVpcClassicLinkDnsSupportPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVpcEndpointConnectionNotificationsPaginator(self: *Self, params: describe_vpc_endpoint_connection_notifications.DescribeVpcEndpointConnectionNotificationsInput) paginator.DescribeVpcEndpointConnectionNotificationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVpcEndpointConnectionsPaginator(self: *Self, params: describe_vpc_endpoint_connections.DescribeVpcEndpointConnectionsInput) paginator.DescribeVpcEndpointConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVpcEndpointServiceConfigurationsPaginator(self: *Self, params: describe_vpc_endpoint_service_configurations.DescribeVpcEndpointServiceConfigurationsInput) paginator.DescribeVpcEndpointServiceConfigurationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVpcEndpointServicePermissionsPaginator(self: *Self, params: describe_vpc_endpoint_service_permissions.DescribeVpcEndpointServicePermissionsInput) paginator.DescribeVpcEndpointServicePermissionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVpcEndpointsPaginator(self: *Self, params: describe_vpc_endpoints.DescribeVpcEndpointsInput) paginator.DescribeVpcEndpointsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVpcPeeringConnectionsPaginator(self: *Self, params: describe_vpc_peering_connections.DescribeVpcPeeringConnectionsInput) paginator.DescribeVpcPeeringConnectionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVpcsPaginator(self: *Self, params: describe_vpcs.DescribeVpcsInput) paginator.DescribeVpcsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn describeVpnConcentratorsPaginator(self: *Self, params: describe_vpn_concentrators.DescribeVpnConcentratorsInput) paginator.DescribeVpnConcentratorsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getAssociatedIpv6PoolCidrsPaginator(self: *Self, params: get_associated_ipv_6_pool_cidrs.GetAssociatedIpv6PoolCidrsInput) paginator.GetAssociatedIpv6PoolCidrsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getAwsNetworkPerformanceDataPaginator(self: *Self, params: get_aws_network_performance_data.GetAwsNetworkPerformanceDataInput) paginator.GetAwsNetworkPerformanceDataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCapacityManagerMetricDataPaginator(self: *Self, params: get_capacity_manager_metric_data.GetCapacityManagerMetricDataInput) paginator.GetCapacityManagerMetricDataPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getCapacityManagerMetricDimensionsPaginator(self: *Self, params: get_capacity_manager_metric_dimensions.GetCapacityManagerMetricDimensionsInput) paginator.GetCapacityManagerMetricDimensionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getGroupsForCapacityReservationPaginator(self: *Self, params: get_groups_for_capacity_reservation.GetGroupsForCapacityReservationInput) paginator.GetGroupsForCapacityReservationPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getInstanceTypesFromInstanceRequirementsPaginator(self: *Self, params: get_instance_types_from_instance_requirements.GetInstanceTypesFromInstanceRequirementsInput) paginator.GetInstanceTypesFromInstanceRequirementsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIpamAddressHistoryPaginator(self: *Self, params: get_ipam_address_history.GetIpamAddressHistoryInput) paginator.GetIpamAddressHistoryPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIpamDiscoveredAccountsPaginator(self: *Self, params: get_ipam_discovered_accounts.GetIpamDiscoveredAccountsInput) paginator.GetIpamDiscoveredAccountsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIpamDiscoveredResourceCidrsPaginator(self: *Self, params: get_ipam_discovered_resource_cidrs.GetIpamDiscoveredResourceCidrsInput) paginator.GetIpamDiscoveredResourceCidrsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIpamPoolAllocationsPaginator(self: *Self, params: get_ipam_pool_allocations.GetIpamPoolAllocationsInput) paginator.GetIpamPoolAllocationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIpamPoolCidrsPaginator(self: *Self, params: get_ipam_pool_cidrs.GetIpamPoolCidrsInput) paginator.GetIpamPoolCidrsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIpamPrefixListResolverRulesPaginator(self: *Self, params: get_ipam_prefix_list_resolver_rules.GetIpamPrefixListResolverRulesInput) paginator.GetIpamPrefixListResolverRulesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIpamPrefixListResolverVersionEntriesPaginator(self: *Self, params: get_ipam_prefix_list_resolver_version_entries.GetIpamPrefixListResolverVersionEntriesInput) paginator.GetIpamPrefixListResolverVersionEntriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIpamPrefixListResolverVersionsPaginator(self: *Self, params: get_ipam_prefix_list_resolver_versions.GetIpamPrefixListResolverVersionsInput) paginator.GetIpamPrefixListResolverVersionsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getIpamResourceCidrsPaginator(self: *Self, params: get_ipam_resource_cidrs.GetIpamResourceCidrsInput) paginator.GetIpamResourceCidrsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getManagedPrefixListAssociationsPaginator(self: *Self, params: get_managed_prefix_list_associations.GetManagedPrefixListAssociationsInput) paginator.GetManagedPrefixListAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getManagedPrefixListEntriesPaginator(self: *Self, params: get_managed_prefix_list_entries.GetManagedPrefixListEntriesInput) paginator.GetManagedPrefixListEntriesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getNetworkInsightsAccessScopeAnalysisFindingsPaginator(self: *Self, params: get_network_insights_access_scope_analysis_findings.GetNetworkInsightsAccessScopeAnalysisFindingsInput) paginator.GetNetworkInsightsAccessScopeAnalysisFindingsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getSecurityGroupsForVpcPaginator(self: *Self, params: get_security_groups_for_vpc.GetSecurityGroupsForVpcInput) paginator.GetSecurityGroupsForVpcPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getSpotPlacementScoresPaginator(self: *Self, params: get_spot_placement_scores.GetSpotPlacementScoresInput) paginator.GetSpotPlacementScoresPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTransitGatewayAttachmentPropagationsPaginator(self: *Self, params: get_transit_gateway_attachment_propagations.GetTransitGatewayAttachmentPropagationsInput) paginator.GetTransitGatewayAttachmentPropagationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTransitGatewayMulticastDomainAssociationsPaginator(self: *Self, params: get_transit_gateway_multicast_domain_associations.GetTransitGatewayMulticastDomainAssociationsInput) paginator.GetTransitGatewayMulticastDomainAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTransitGatewayPolicyTableAssociationsPaginator(self: *Self, params: get_transit_gateway_policy_table_associations.GetTransitGatewayPolicyTableAssociationsInput) paginator.GetTransitGatewayPolicyTableAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTransitGatewayPrefixListReferencesPaginator(self: *Self, params: get_transit_gateway_prefix_list_references.GetTransitGatewayPrefixListReferencesInput) paginator.GetTransitGatewayPrefixListReferencesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTransitGatewayRouteTableAssociationsPaginator(self: *Self, params: get_transit_gateway_route_table_associations.GetTransitGatewayRouteTableAssociationsInput) paginator.GetTransitGatewayRouteTableAssociationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getTransitGatewayRouteTablePropagationsPaginator(self: *Self, params: get_transit_gateway_route_table_propagations.GetTransitGatewayRouteTablePropagationsInput) paginator.GetTransitGatewayRouteTablePropagationsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn getVpnConnectionDeviceTypesPaginator(self: *Self, params: get_vpn_connection_device_types.GetVpnConnectionDeviceTypesInput) paginator.GetVpnConnectionDeviceTypesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listImagesInRecycleBinPaginator(self: *Self, params: list_images_in_recycle_bin.ListImagesInRecycleBinInput) paginator.ListImagesInRecycleBinPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn listSnapshotsInRecycleBinPaginator(self: *Self, params: list_snapshots_in_recycle_bin.ListSnapshotsInRecycleBinInput) paginator.ListSnapshotsInRecycleBinPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchLocalGatewayRoutesPaginator(self: *Self, params: search_local_gateway_routes.SearchLocalGatewayRoutesInput) paginator.SearchLocalGatewayRoutesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchTransitGatewayMulticastGroupsPaginator(self: *Self, params: search_transit_gateway_multicast_groups.SearchTransitGatewayMulticastGroupsInput) paginator.SearchTransitGatewayMulticastGroupsPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn searchTransitGatewayRoutesPaginator(self: *Self, params: search_transit_gateway_routes.SearchTransitGatewayRoutesInput) paginator.SearchTransitGatewayRoutesPaginator {
        return .{
            .client = self,
            .params = params,
            .allocator = self.allocator,
        };
    }

    pub fn waitUntilImageExists(self: *Self, params: describe_images.DescribeImagesInput) aws.waiter.WaiterError!void {
        var w = waiters.ImageExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInstanceExists(self: *Self, params: describe_instances.DescribeInstancesInput) aws.waiter.WaiterError!void {
        var w = waiters.InstanceExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInstanceRunning(self: *Self, params: describe_instances.DescribeInstancesInput) aws.waiter.WaiterError!void {
        var w = waiters.InstanceRunningWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInstanceStatusOk(self: *Self, params: describe_instance_status.DescribeInstanceStatusInput) aws.waiter.WaiterError!void {
        var w = waiters.InstanceStatusOkWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilInternetGatewayExists(self: *Self, params: describe_internet_gateways.DescribeInternetGatewaysInput) aws.waiter.WaiterError!void {
        var w = waiters.InternetGatewayExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilKeyPairExists(self: *Self, params: describe_key_pairs.DescribeKeyPairsInput) aws.waiter.WaiterError!void {
        var w = waiters.KeyPairExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilNatGatewayAvailable(self: *Self, params: describe_nat_gateways.DescribeNatGatewaysInput) aws.waiter.WaiterError!void {
        var w = waiters.NatGatewayAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilNatGatewayDeleted(self: *Self, params: describe_nat_gateways.DescribeNatGatewaysInput) aws.waiter.WaiterError!void {
        var w = waiters.NatGatewayDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilNetworkInterfaceAvailable(self: *Self, params: describe_network_interfaces.DescribeNetworkInterfacesInput) aws.waiter.WaiterError!void {
        var w = waiters.NetworkInterfaceAvailableWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilSecurityGroupExists(self: *Self, params: describe_security_groups.DescribeSecurityGroupsInput) aws.waiter.WaiterError!void {
        var w = waiters.SecurityGroupExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilSpotInstanceRequestFulfilled(self: *Self, params: describe_spot_instance_requests.DescribeSpotInstanceRequestsInput) aws.waiter.WaiterError!void {
        var w = waiters.SpotInstanceRequestFulfilledWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilVolumeDeleted(self: *Self, params: describe_volumes.DescribeVolumesInput) aws.waiter.WaiterError!void {
        var w = waiters.VolumeDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilVpcExists(self: *Self, params: describe_vpcs.DescribeVpcsInput) aws.waiter.WaiterError!void {
        var w = waiters.VpcExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilVpcPeeringConnectionDeleted(self: *Self, params: describe_vpc_peering_connections.DescribeVpcPeeringConnectionsInput) aws.waiter.WaiterError!void {
        var w = waiters.VpcPeeringConnectionDeletedWaiter{ .client = self, .params = params };
        return w.wait();
    }

    pub fn waitUntilVpcPeeringConnectionExists(self: *Self, params: describe_vpc_peering_connections.DescribeVpcPeeringConnectionsInput) aws.waiter.WaiterError!void {
        var w = waiters.VpcPeeringConnectionExistsWaiter{ .client = self, .params = params };
        return w.wait();
    }
};
