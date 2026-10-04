/// Describes the configuration of a Capacity Reservation.
pub const CapacityReservationConfiguration = struct {
    /// The number of instances in the Capacity Reservation.
    instance_count: ?i32 = null,

    /// The current state of the Capacity Reservation.
    reservation_state: ?[]const u8 = null,
};
