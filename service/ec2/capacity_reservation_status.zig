/// Describes the availability of capacity for a Capacity Reservation.
pub const CapacityReservationStatus = struct {
    /// The ID of the Capacity Reservation.
    capacity_reservation_id: ?[]const u8,

    /// The remaining capacity. Indicates the amount of resources that can be
    /// launched into the Capacity Reservation.
    total_available_capacity: ?i32,

    /// The combined amount of `Available` and `Unavailable` capacity in the
    /// Capacity Reservation.
    total_capacity: ?i32,

    /// The used capacity. Indicates that the capacity is in use by resources that
    /// are running in the Capacity Reservation.
    total_unavailable_capacity: ?i32,
};
