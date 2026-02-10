const CapacityReservationTenancy = @import("capacity_reservation_tenancy.zig").CapacityReservationTenancy;

/// Information about a Capacity Reservation.
pub const CapacityReservationInfo = struct {
    /// The Availability Zone for the Capacity Reservation.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone.
    availability_zone_id: ?[]const u8,

    /// The instance type for the Capacity Reservation.
    instance_type: ?[]const u8,

    /// The tenancy of the Capacity Reservation.
    tenancy: ?CapacityReservationTenancy,
};
