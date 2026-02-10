const SubnetCidrReservationType = @import("subnet_cidr_reservation_type.zig").SubnetCidrReservationType;
const Tag = @import("tag.zig").Tag;

/// Describes a subnet CIDR reservation.
pub const SubnetCidrReservation = struct {
    /// The CIDR that has been reserved.
    cidr: ?[]const u8,

    /// The description assigned to the subnet CIDR reservation.
    description: ?[]const u8,

    /// The ID of the account that owns the subnet CIDR reservation.
    owner_id: ?[]const u8,

    /// The type of reservation.
    reservation_type: ?SubnetCidrReservationType,

    /// The ID of the subnet CIDR reservation.
    subnet_cidr_reservation_id: ?[]const u8,

    /// The ID of the subnet.
    subnet_id: ?[]const u8,

    /// The tags assigned to the subnet CIDR reservation.
    tags: ?[]const Tag,
};
