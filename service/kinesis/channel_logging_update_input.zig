const CloudWatchLogsUpdateInput = @import("cloud_watch_logs_update_input.zig").CloudWatchLogsUpdateInput;

/// The updated Amazon CloudWatch Logs configuration for a channel. Used in
/// UpdateChannel.
pub const ChannelLoggingUpdateInput = struct {
    /// The updated Amazon CloudWatch Logs settings, including whether logging is
    /// enabled and the target log group and log stream.
    cloud_watch_logs: CloudWatchLogsUpdateInput,

    pub const json_field_names = .{
        .cloud_watch_logs = "CloudWatchLogs",
    };
};
