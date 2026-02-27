const CapacityReservationStateEnum = @import("capacity_reservation_state_enum.zig").CapacityReservationStateEnum;

/// The status of a capacity reservation.
pub const CapacityReservationStatus = struct {
    /// The status code.
    code: ?CapacityReservationStateEnum,

    /// The reason code for the status.
    reason: ?[]const u8,
};
