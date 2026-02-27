const CloudWatchLogGroupLogDestination = @import("cloud_watch_log_group_log_destination.zig").CloudWatchLogGroupLogDestination;

/// Defines the Amazon CloudWatch Logs destination log group for
/// conversation text logs.
pub const TextLogDestination = struct {
    /// Defines the Amazon CloudWatch Logs log group where text and metadata logs
    /// are
    /// delivered.
    cloud_watch: CloudWatchLogGroupLogDestination,

    pub const json_field_names = .{
        .cloud_watch = "cloudWatch",
    };
};
