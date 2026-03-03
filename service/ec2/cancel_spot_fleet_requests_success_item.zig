const BatchState = @import("batch_state.zig").BatchState;

/// Describes a Spot Fleet request that was successfully canceled.
pub const CancelSpotFleetRequestsSuccessItem = struct {
    /// The current state of the Spot Fleet request.
    current_spot_fleet_request_state: ?BatchState = null,

    /// The previous state of the Spot Fleet request.
    previous_spot_fleet_request_state: ?BatchState = null,

    /// The ID of the Spot Fleet request.
    spot_fleet_request_id: ?[]const u8 = null,
};
