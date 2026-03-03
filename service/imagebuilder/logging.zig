const S3Logs = @import("s3_logs.zig").S3Logs;

/// Logging configuration defines where Image Builder uploads your logs.
pub const Logging = struct {
    /// The Amazon S3 logging configuration.
    s_3_logs: ?S3Logs = null,

    pub const json_field_names = .{
        .s_3_logs = "s3Logs",
    };
};
