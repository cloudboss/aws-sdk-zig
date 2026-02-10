const ActivityStatus = @import("activity_status.zig").ActivityStatus;
const SpotFleetRequestConfigData = @import("spot_fleet_request_config_data.zig").SpotFleetRequestConfigData;
const BatchState = @import("batch_state.zig").BatchState;
const Tag = @import("tag.zig").Tag;

/// Describes a Spot Fleet request.
pub const SpotFleetRequestConfig = struct {
    /// The progress of the Spot Fleet request.
    /// If there is an error, the status is `error`.
    /// After all requests are placed, the status is `pending_fulfillment`.
    /// If the size of the fleet is equal to or greater than its target capacity,
    /// the status is `fulfilled`.
    /// If the size of the fleet is decreased, the status is `pending_termination`
    /// while Spot Instances are terminating.
    activity_status: ?ActivityStatus,

    /// The creation date and time of the request.
    create_time: ?i64,

    /// The configuration of the Spot Fleet request.
    spot_fleet_request_config: ?SpotFleetRequestConfigData,

    /// The ID of the Spot Fleet request.
    spot_fleet_request_id: ?[]const u8,

    /// The state of the Spot Fleet request.
    spot_fleet_request_state: ?BatchState,

    /// The tags for a Spot Fleet resource.
    tags: ?[]const Tag,
};
