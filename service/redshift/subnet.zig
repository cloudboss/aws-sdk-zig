const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;

/// Describes a subnet.
pub const Subnet = struct {
    subnet_availability_zone: ?AvailabilityZone = null,

    /// The identifier of the subnet.
    subnet_identifier: ?[]const u8 = null,

    /// The status of the subnet.
    subnet_status: ?[]const u8 = null,
};
