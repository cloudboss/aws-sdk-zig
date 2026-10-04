/// Describes the configuration that a Capacity Reservation has at the time a
/// modification
/// quote is generated.
pub const ModificationQuoteCurrentConfiguration = struct {
    /// The number of instances in the Capacity Reservation.
    instance_count: ?i32 = null,

    /// The start date that the Capacity Reservation was originally requested with.
    /// This value
    /// does not change when you push out the start date.
    original_start_date: ?i64 = null,

    /// The current state of the Capacity Reservation.
    reservation_state: ?[]const u8 = null,

    /// The start date that the Capacity Reservation has before the quoted
    /// modification is
    /// applied.
    start_date: ?i64 = null,
};
