/// Describes a Capacity Reservation Fleet cancellation error.
pub const CancelCapacityReservationFleetError = struct {
    /// The error code.
    code: ?[]const u8 = null,

    /// The error message.
    message: ?[]const u8 = null,
};
