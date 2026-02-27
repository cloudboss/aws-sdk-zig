const NetworkType = @import("network_type.zig").NetworkType;

/// Represents the subnet associated with a DAX cluster. This parameter
/// refers to subnets defined in Amazon Virtual Private Cloud (Amazon VPC) and
/// used with
/// DAX.
pub const Subnet = struct {
    /// The Availability Zone (AZ) for the subnet.
    subnet_availability_zone: ?[]const u8,

    /// The system-assigned identifier for the subnet.
    subnet_identifier: ?[]const u8,

    /// The network types supported by this subnet. Returns an array of strings that
    /// can
    /// include `ipv4`, `ipv6`, or both, indicating whether the subnet
    /// supports IPv4 only, IPv6 only, or dual-stack deployments.
    supported_network_types: ?[]const NetworkType,

    pub const json_field_names = .{
        .subnet_availability_zone = "SubnetAvailabilityZone",
        .subnet_identifier = "SubnetIdentifier",
        .supported_network_types = "SupportedNetworkTypes",
    };
};
