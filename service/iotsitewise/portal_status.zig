const MonitorErrorDetails = @import("monitor_error_details.zig").MonitorErrorDetails;
const PortalState = @import("portal_state.zig").PortalState;

/// Contains information about the current status of a portal.
pub const PortalStatus = struct {
    /// Contains associated error information, if any.
    @"error": ?MonitorErrorDetails = null,

    /// The current state of the portal.
    state: PortalState,

    pub const json_field_names = .{
        .@"error" = "error",
        .state = "state",
    };
};
