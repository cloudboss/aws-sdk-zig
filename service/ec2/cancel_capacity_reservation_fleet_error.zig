/// Describes a Capacity Reservation Fleet cancellation error.
pub const CancelCapacityReservationFleetError = struct {
    /// The error code.
    code: ?[]const u8,

    /// The error message.
    message: ?[]const u8,
};
