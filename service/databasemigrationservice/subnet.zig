const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;

/// In response to a request by the `DescribeReplicationSubnetGroups` operation,
/// this object identifies a subnet by its given Availability Zone, subnet
/// identifier, and
/// status.
pub const Subnet = struct {
    /// The Availability Zone of the subnet.
    subnet_availability_zone: ?AvailabilityZone = null,

    /// The subnet identifier.
    subnet_identifier: ?[]const u8 = null,

    /// The status of the subnet.
    subnet_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .subnet_availability_zone = "SubnetAvailabilityZone",
        .subnet_identifier = "SubnetIdentifier",
        .subnet_status = "SubnetStatus",
    };
};
