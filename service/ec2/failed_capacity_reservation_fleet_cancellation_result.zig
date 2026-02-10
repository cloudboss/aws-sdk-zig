const CancelCapacityReservationFleetError = @import("cancel_capacity_reservation_fleet_error.zig").CancelCapacityReservationFleetError;

/// Describes a Capacity Reservation Fleet that could not be cancelled.
pub const FailedCapacityReservationFleetCancellationResult = struct {
    /// Information about the Capacity Reservation Fleet cancellation error.
    cancel_capacity_reservation_fleet_error: ?CancelCapacityReservationFleetError,

    /// The ID of the Capacity Reservation Fleet that could not be cancelled.
    capacity_reservation_fleet_id: ?[]const u8,
};
