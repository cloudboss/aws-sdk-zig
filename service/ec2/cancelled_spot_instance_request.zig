const CancelSpotInstanceRequestState = @import("cancel_spot_instance_request_state.zig").CancelSpotInstanceRequestState;

/// Describes a request to cancel a Spot Instance.
pub const CancelledSpotInstanceRequest = struct {
    /// The ID of the Spot Instance request.
    spot_instance_request_id: ?[]const u8,

    /// The state of the Spot Instance request.
    state: ?CancelSpotInstanceRequestState,
};
