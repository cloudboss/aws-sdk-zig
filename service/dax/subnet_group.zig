const Subnet = @import("subnet.zig").Subnet;
const NetworkType = @import("network_type.zig").NetworkType;

/// Represents the output of one of the following actions:
///
/// * *CreateSubnetGroup*
///
/// * *ModifySubnetGroup*
pub const SubnetGroup = struct {
    /// The description of the subnet group.
    description: ?[]const u8 = null,

    /// The name of the subnet group.
    subnet_group_name: ?[]const u8 = null,

    /// A list of subnets associated with the subnet group.
    subnets: ?[]const Subnet = null,

    /// The network types supported by this subnet. Returns an array of strings that
    /// can
    /// include `ipv4`, `ipv6`, or both, indicating whether the subnet
    /// group supports IPv4 only, IPv6 only, or dual-stack deployments.
    supported_network_types: ?[]const NetworkType = null,

    /// The Amazon Virtual Private Cloud identifier (VPC ID) of the subnet group.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .subnet_group_name = "SubnetGroupName",
        .subnets = "Subnets",
        .supported_network_types = "SupportedNetworkTypes",
        .vpc_id = "VpcId",
    };
};
