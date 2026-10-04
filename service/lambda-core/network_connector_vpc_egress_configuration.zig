const ComputeResourceType = @import("compute_resource_type.zig").ComputeResourceType;
const NetworkProtocol = @import("network_protocol.zig").NetworkProtocol;

/// Configuration for a VPC egress network connector. Specifies the VPC subnets,
/// security groups, network protocol, and associated Lambda compute resource
/// types.
pub const NetworkConnectorVpcEgressConfiguration = struct {
    /// The types of Lambda compute resources that can use this connector.
    /// Currently, only `MicroVm` is supported.
    associated_compute_resource_types: ?[]const ComputeResourceType = null,

    /// The network protocol for the connector. Specify `IPv4` for IPv4-only
    /// networking, or `DualStack` for both IPv4 and IPv6.
    network_protocol: ?NetworkProtocol = null,

    /// The IDs of the VPC security groups to attach to the ENIs. Specify 0 to 5
    /// security groups. All security groups must be in the same VPC as the subnets.
    security_group_ids: ?[]const []const u8 = null,

    /// The IDs of the VPC subnets where Lambda provisions elastic network
    /// interfaces (ENIs). Specify 1 to 16 subnets. All subnets must be in the same
    /// VPC.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .associated_compute_resource_types = "AssociatedComputeResourceTypes",
        .network_protocol = "NetworkProtocol",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
