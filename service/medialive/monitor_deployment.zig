const SignalMapMonitorDeploymentStatus = @import("signal_map_monitor_deployment_status.zig").SignalMapMonitorDeploymentStatus;

/// Represents the latest monitor deployment of a signal map.
pub const MonitorDeployment = struct {
    /// URI associated with a signal map's monitor deployment.
    details_uri: ?[]const u8,

    /// Error message associated with a failed monitor deployment of a signal map.
    error_message: ?[]const u8,

    status: SignalMapMonitorDeploymentStatus,

    pub const json_field_names = .{
        .details_uri = "DetailsUri",
        .error_message = "ErrorMessage",
        .status = "Status",
    };
};
