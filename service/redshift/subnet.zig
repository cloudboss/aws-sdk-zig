const AvailabilityZone = @import("availability_zone.zig").AvailabilityZone;

/// Describes a subnet.
pub const Subnet = struct {
    subnet_availability_zone: ?AvailabilityZone,

    /// The identifier of the subnet.
    subnet_identifier: ?[]const u8,

    /// The status of the subnet.
    subnet_status: ?[]const u8,
};
