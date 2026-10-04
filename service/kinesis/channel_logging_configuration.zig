const CloudWatchLogs = @import("cloud_watch_logs.zig").CloudWatchLogs;

/// The Amazon CloudWatch Logs configuration for a channel.
pub const ChannelLoggingConfiguration = struct {
    /// The Amazon CloudWatch Logs settings for the channel.
    cloud_watch_logs: CloudWatchLogs,

    pub const json_field_names = .{
        .cloud_watch_logs = "CloudWatchLogs",
    };
};
