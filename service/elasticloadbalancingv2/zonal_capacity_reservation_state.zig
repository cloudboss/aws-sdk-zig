const CapacityReservationStatus = @import("capacity_reservation_status.zig").CapacityReservationStatus;

/// The capacity reservation status for each Availability Zone.
pub const ZonalCapacityReservationState = struct {
    /// Information about the Availability Zone.
    availability_zone: ?[]const u8,

    /// The number of effective capacity units.
    effective_capacity_units: ?f64,

    /// The state of the capacity reservation.
    state: ?CapacityReservationStatus,
};
