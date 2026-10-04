const NetworkConnectorVpcEgressConfiguration = @import("network_connector_vpc_egress_configuration.zig").NetworkConnectorVpcEgressConfiguration;

/// The network configuration for a network connector. Different connector types
/// use different configuration shapes; specify the configuration that matches
/// your connector type.
pub const NetworkConnectorConfiguration = union(enum) {
    /// Configuration for a VPC egress network connector. Specifies the subnets,
    /// security groups, and network protocol for routing outbound traffic through
    /// your VPC.
    vpc_egress_configuration: ?NetworkConnectorVpcEgressConfiguration,

    pub const json_field_names = .{
        .vpc_egress_configuration = "VpcEgressConfiguration",
    };
};
