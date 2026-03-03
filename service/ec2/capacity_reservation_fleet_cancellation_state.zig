const CapacityReservationFleetState = @import("capacity_reservation_fleet_state.zig").CapacityReservationFleetState;

/// Describes a Capacity Reservation Fleet that was successfully cancelled.
pub const CapacityReservationFleetCancellationState = struct {
    /// The ID of the Capacity Reservation Fleet that was successfully cancelled.
    capacity_reservation_fleet_id: ?[]const u8 = null,

    /// The current state of the Capacity Reservation Fleet.
    current_fleet_state: ?CapacityReservationFleetState = null,

    /// The previous state of the Capacity Reservation Fleet.
    previous_fleet_state: ?CapacityReservationFleetState = null,
};
