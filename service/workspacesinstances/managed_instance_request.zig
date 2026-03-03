const BlockDeviceMappingRequest = @import("block_device_mapping_request.zig").BlockDeviceMappingRequest;
const CapacityReservationSpecification = @import("capacity_reservation_specification.zig").CapacityReservationSpecification;
const CpuOptionsRequest = @import("cpu_options_request.zig").CpuOptionsRequest;
const CreditSpecificationRequest = @import("credit_specification_request.zig").CreditSpecificationRequest;
const EnclaveOptionsRequest = @import("enclave_options_request.zig").EnclaveOptionsRequest;
const HibernationOptionsRequest = @import("hibernation_options_request.zig").HibernationOptionsRequest;
const IamInstanceProfileSpecification = @import("iam_instance_profile_specification.zig").IamInstanceProfileSpecification;
const InstanceMarketOptionsRequest = @import("instance_market_options_request.zig").InstanceMarketOptionsRequest;
const InstanceIpv6Address = @import("instance_ipv_6_address.zig").InstanceIpv6Address;
const LicenseConfigurationRequest = @import("license_configuration_request.zig").LicenseConfigurationRequest;
const InstanceMaintenanceOptionsRequest = @import("instance_maintenance_options_request.zig").InstanceMaintenanceOptionsRequest;
const InstanceMetadataOptionsRequest = @import("instance_metadata_options_request.zig").InstanceMetadataOptionsRequest;
const RunInstancesMonitoringEnabled = @import("run_instances_monitoring_enabled.zig").RunInstancesMonitoringEnabled;
const InstanceNetworkInterfaceSpecification = @import("instance_network_interface_specification.zig").InstanceNetworkInterfaceSpecification;
const InstanceNetworkPerformanceOptionsRequest = @import("instance_network_performance_options_request.zig").InstanceNetworkPerformanceOptionsRequest;
const Placement = @import("placement.zig").Placement;
const PrivateDnsNameOptionsRequest = @import("private_dns_name_options_request.zig").PrivateDnsNameOptionsRequest;
const TagSpecification = @import("tag_specification.zig").TagSpecification;

/// Defines comprehensive configuration for a managed WorkSpace Instance.
pub const ManagedInstanceRequest = struct {
    /// Configures block device mappings for storage.
    block_device_mappings: ?[]const BlockDeviceMappingRequest = null,

    /// Specifies capacity reservation preferences.
    capacity_reservation_specification: ?CapacityReservationSpecification = null,

    /// Configures CPU-specific settings.
    cpu_options: ?CpuOptionsRequest = null,

    /// Defines CPU credit configuration for burstable instances.
    credit_specification: ?CreditSpecificationRequest = null,

    /// Prevents API-initiated instance stop.
    disable_api_stop: ?bool = null,

    /// Enables optimized EBS performance.
    ebs_optimized: ?bool = null,

    /// Enables primary IPv6 address configuration.
    enable_primary_ipv_6: ?bool = null,

    /// Configures AWS Nitro Enclave settings.
    enclave_options: ?EnclaveOptionsRequest = null,

    /// Configures instance hibernation capabilities.
    hibernation_options: ?HibernationOptionsRequest = null,

    /// Specifies IAM instance profile configuration.
    iam_instance_profile: ?IamInstanceProfileSpecification = null,

    /// Identifies the Amazon Machine Image (AMI) for the instance.
    image_id: ?[]const u8 = null,

    /// Configures marketplace-specific deployment options.
    instance_market_options: ?InstanceMarketOptionsRequest = null,

    /// Specifies the WorkSpace Instance type.
    instance_type: ?[]const u8 = null,

    /// Specifies number of IPv6 addresses to assign.
    ipv_6_address_count: ?i32 = null,

    /// Configures specific IPv6 addresses.
    ipv_6_addresses: ?[]const InstanceIpv6Address = null,

    /// Identifies the kernel for the instance.
    kernel_id: ?[]const u8 = null,

    /// Specifies the key pair for instance access.
    key_name: ?[]const u8 = null,

    /// Configures license-related settings.
    license_specifications: ?[]const LicenseConfigurationRequest = null,

    /// Defines automatic maintenance settings.
    maintenance_options: ?InstanceMaintenanceOptionsRequest = null,

    /// Configures instance metadata service settings.
    metadata_options: ?InstanceMetadataOptionsRequest = null,

    /// Enables or disables detailed instance monitoring.
    monitoring: ?RunInstancesMonitoringEnabled = null,

    /// Configures network interface settings.
    network_interfaces: ?[]const InstanceNetworkInterfaceSpecification = null,

    /// Defines network performance configuration.
    network_performance_options: ?InstanceNetworkPerformanceOptionsRequest = null,

    /// Specifies instance placement preferences.
    placement: ?Placement = null,

    /// Configures private DNS name settings.
    private_dns_name_options: ?PrivateDnsNameOptionsRequest = null,

    /// Specifies the primary private IP address.
    private_ip_address: ?[]const u8 = null,

    /// Identifies the ramdisk for the instance.
    ramdisk_id: ?[]const u8 = null,

    /// Specifies security group identifiers.
    security_group_ids: ?[]const []const u8 = null,

    /// Configures security group settings.
    security_groups: ?[]const []const u8 = null,

    /// Identifies the subnet for the instance.
    subnet_id: ?[]const u8 = null,

    /// Configures resource tagging specifications.
    tag_specifications: ?[]const TagSpecification = null,

    /// Provides custom initialization data for the instance.
    user_data: ?[]const u8 = null,

    pub const json_field_names = .{
        .block_device_mappings = "BlockDeviceMappings",
        .capacity_reservation_specification = "CapacityReservationSpecification",
        .cpu_options = "CpuOptions",
        .credit_specification = "CreditSpecification",
        .disable_api_stop = "DisableApiStop",
        .ebs_optimized = "EbsOptimized",
        .enable_primary_ipv_6 = "EnablePrimaryIpv6",
        .enclave_options = "EnclaveOptions",
        .hibernation_options = "HibernationOptions",
        .iam_instance_profile = "IamInstanceProfile",
        .image_id = "ImageId",
        .instance_market_options = "InstanceMarketOptions",
        .instance_type = "InstanceType",
        .ipv_6_address_count = "Ipv6AddressCount",
        .ipv_6_addresses = "Ipv6Addresses",
        .kernel_id = "KernelId",
        .key_name = "KeyName",
        .license_specifications = "LicenseSpecifications",
        .maintenance_options = "MaintenanceOptions",
        .metadata_options = "MetadataOptions",
        .monitoring = "Monitoring",
        .network_interfaces = "NetworkInterfaces",
        .network_performance_options = "NetworkPerformanceOptions",
        .placement = "Placement",
        .private_dns_name_options = "PrivateDnsNameOptions",
        .private_ip_address = "PrivateIpAddress",
        .ramdisk_id = "RamdiskId",
        .security_group_ids = "SecurityGroupIds",
        .security_groups = "SecurityGroups",
        .subnet_id = "SubnetId",
        .tag_specifications = "TagSpecifications",
        .user_data = "UserData",
    };
};
