const Subnet = @import("subnet.zig").Subnet;
const NetworkType = @import("network_type.zig").NetworkType;

/// Represents the output of one of the following operations:
///
/// * CreateSubnetGroup
///
/// * UpdateSubnetGroup
///
/// A subnet group is a collection of subnets (typically private) that you can
/// designate for your clusters running in an Amazon Virtual Private Cloud (VPC)
/// environment.
pub const SubnetGroup = struct {
    /// The ARN (Amazon Resource Name) of the subnet group.
    arn: ?[]const u8,

    /// A description of the subnet group
    description: ?[]const u8,

    /// The name of the subnet group
    name: ?[]const u8,

    /// A list of subnets associated with the subnet group.
    subnets: ?[]const Subnet,

    /// The network types supported by this subnet group. Returns an array of
    /// strings that can include 'ipv4', 'ipv6', or both, indicating the IP address
    /// types that can be used for clusters deployed in this subnet group.
    supported_network_types: ?[]const NetworkType,

    /// The Amazon Virtual Private Cloud identifier (VPC ID) of the subnet group.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "ARN",
        .description = "Description",
        .name = "Name",
        .subnets = "Subnets",
        .supported_network_types = "SupportedNetworkTypes",
        .vpc_id = "VpcId",
    };
};
