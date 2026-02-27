const Duration = @import("duration.zig").Duration;

/// An object that represents the outlier detection for a virtual node's
/// listener.
pub const OutlierDetection = struct {
    /// The base amount of time for which a host is ejected.
    base_ejection_duration: Duration,

    /// The time interval between ejection sweep analysis.
    interval: Duration,

    /// Maximum percentage of hosts in load balancing pool for upstream service that
    /// can be
    /// ejected. Will eject at least one host regardless of the value.
    max_ejection_percent: i32,

    /// Number of consecutive `5xx` errors required for ejection.
    max_server_errors: i64,

    pub const json_field_names = .{
        .base_ejection_duration = "baseEjectionDuration",
        .interval = "interval",
        .max_ejection_percent = "maxEjectionPercent",
        .max_server_errors = "maxServerErrors",
    };
};
