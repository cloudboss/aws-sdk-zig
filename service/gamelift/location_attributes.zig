const LocationState = @import("location_state.zig").LocationState;
const FleetAction = @import("fleet_action.zig").FleetAction;
const LocationUpdateStatus = @import("location_update_status.zig").LocationUpdateStatus;

/// Details about a location in a multi-location fleet.
pub const LocationAttributes = struct {
    /// A fleet location and its current life-cycle state.
    location_state: ?LocationState = null,

    /// A list of fleet actions that have been suspended in the fleet location.
    stopped_actions: ?[]const FleetAction = null,

    /// The status of fleet activity updates to the location. The status
    /// `PENDING_UPDATE` indicates that `StopFleetActions` or
    /// `StartFleetActions` has been requested but the update has not yet been
    /// completed for the location.
    update_status: ?LocationUpdateStatus = null,

    pub const json_field_names = .{
        .location_state = "LocationState",
        .stopped_actions = "StoppedActions",
        .update_status = "UpdateStatus",
    };
};
