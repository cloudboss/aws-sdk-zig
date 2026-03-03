/// The cost associated with the Reserved Instance.
pub const ReservationValue = struct {
    /// The hourly rate of the reservation.
    hourly_price: ?[]const u8 = null,

    /// The balance of the total value (the sum of remainingUpfrontValue +
    /// hourlyPrice * number of
    /// hours remaining).
    remaining_total_value: ?[]const u8 = null,

    /// The remaining upfront cost of the reservation.
    remaining_upfront_value: ?[]const u8 = null,
};
