const CloudWatchLogOptions = @import("cloud_watch_log_options.zig").CloudWatchLogOptions;

/// Options for logging VPN tunnel activity.
pub const VpnTunnelLogOptions = struct {
    /// Options for sending VPN tunnel logs to CloudWatch.
    cloud_watch_log_options: ?CloudWatchLogOptions = null,
};
