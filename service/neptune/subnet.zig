const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;

/// Specifies a subnet.
///
/// This data type is used as a response element in the DescribeDBSubnetGroups
/// action.
pub const Subnet = struct {
    /// Specifies the EC2 Availability Zone that the subnet is in.
    subnet_availability_zone: ?AvailabilityZone,

    /// Specifies the identifier of the subnet.
    subnet_identifier: ?[]const u8,

    /// Specifies the status of the subnet.
    subnet_status: ?[]const u8,
};
