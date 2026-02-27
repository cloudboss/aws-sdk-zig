const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;

/// Detailed information about a subnet.
pub const Subnet = struct {
    /// Specifies the Availability Zone for the subnet.
    subnet_availability_zone: ?AvailabilityZone,

    /// Specifies the identifier of the subnet.
    subnet_identifier: ?[]const u8,

    /// Specifies the status of the subnet.
    subnet_status: ?[]const u8,
};
