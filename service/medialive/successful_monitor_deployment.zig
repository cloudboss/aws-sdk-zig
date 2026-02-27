const SignalMapMonitorDeploymentStatus = @import("signal_map_monitor_deployment_status.zig").SignalMapMonitorDeploymentStatus;

/// Represents the latest successful monitor deployment of a signal map.
pub const SuccessfulMonitorDeployment = struct {
    /// URI associated with a signal map's monitor deployment.
    details_uri: []const u8,

    status: SignalMapMonitorDeploymentStatus,

    pub const json_field_names = .{
        .details_uri = "DetailsUri",
        .status = "Status",
    };
};
