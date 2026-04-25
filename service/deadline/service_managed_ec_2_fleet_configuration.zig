const ServiceManagedEc2AutoScalingConfiguration = @import("service_managed_ec_2_auto_scaling_configuration.zig").ServiceManagedEc2AutoScalingConfiguration;
const ServiceManagedEc2InstanceCapabilities = @import("service_managed_ec_2_instance_capabilities.zig").ServiceManagedEc2InstanceCapabilities;
const ServiceManagedEc2InstanceMarketOptions = @import("service_managed_ec_2_instance_market_options.zig").ServiceManagedEc2InstanceMarketOptions;
const VpcConfiguration = @import("vpc_configuration.zig").VpcConfiguration;

/// The configuration details for a service managed EC2 fleet.
pub const ServiceManagedEc2FleetConfiguration = struct {
    /// The auto scaling configuration settings for the service managed EC2 fleet.
    auto_scaling_configuration: ?ServiceManagedEc2AutoScalingConfiguration = null,

    /// The instance capabilities for the service managed EC2 fleet.
    instance_capabilities: ServiceManagedEc2InstanceCapabilities,

    /// The instance market options for the service managed EC2 fleet.
    instance_market_options: ServiceManagedEc2InstanceMarketOptions,

    /// The storage profile ID for the service managed EC2 fleet.
    storage_profile_id: ?[]const u8 = null,

    /// The VPC configuration for the service managed EC2 fleet.
    vpc_configuration: ?VpcConfiguration = null,

    pub const json_field_names = .{
        .auto_scaling_configuration = "autoScalingConfiguration",
        .instance_capabilities = "instanceCapabilities",
        .instance_market_options = "instanceMarketOptions",
        .storage_profile_id = "storageProfileId",
        .vpc_configuration = "vpcConfiguration",
    };
};
