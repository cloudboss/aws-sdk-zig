const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;
const NetworkType = @import("network_type.zig").NetworkType;

/// Represents the subnet associated with a cluster. This parameter refers to
/// subnets defined in Amazon Virtual Private Cloud (Amazon VPC) and used with
/// MemoryDB.
pub const Subnet = struct {
    /// The Availability Zone where the subnet resides
    availability_zone: ?AvailabilityZone,

    /// The unique identifier for the subnet.
    identifier: ?[]const u8,

    /// The network types supported by this subnet. Returns an array of strings that
    /// can include 'ipv4', 'ipv6', or both, indicating whether the subnet supports
    /// IPv4 only, IPv6 only, or dual-stack deployments.
    supported_network_types: ?[]const NetworkType,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .identifier = "Identifier",
        .supported_network_types = "SupportedNetworkTypes",
    };
};
