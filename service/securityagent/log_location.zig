const CloudWatchLog = @import("cloud_watch_log.zig").CloudWatchLog;
const LogType = @import("log_type.zig").LogType;

/// The log location for a task, specifying where task execution logs are
/// stored.
pub const LogLocation = struct {
    /// The CloudWatch Logs location for the task logs.
    cloud_watch_log: ?CloudWatchLog = null,

    /// The type of log storage. Currently, only CLOUDWATCH is supported.
    log_type: ?LogType = null,

    pub const json_field_names = .{
        .cloud_watch_log = "cloudWatchLog",
        .log_type = "logType",
    };
};
