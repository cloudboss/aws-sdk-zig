const CancelSpotFleetRequestsError = @import("cancel_spot_fleet_requests_error.zig").CancelSpotFleetRequestsError;

/// Describes a Spot Fleet request that was not successfully canceled.
pub const CancelSpotFleetRequestsErrorItem = struct {
    /// The error.
    @"error": ?CancelSpotFleetRequestsError = null,

    /// The ID of the Spot Fleet request.
    spot_fleet_request_id: ?[]const u8 = null,
};
