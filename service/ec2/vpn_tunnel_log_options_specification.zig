const CloudWatchLogOptionsSpecification = @import("cloud_watch_log_options_specification.zig").CloudWatchLogOptionsSpecification;

/// Options for logging VPN tunnel activity.
pub const VpnTunnelLogOptionsSpecification = struct {
    /// Options for sending VPN tunnel logs to CloudWatch.
    cloud_watch_log_options: ?CloudWatchLogOptionsSpecification,
};
