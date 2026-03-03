const S3LogConfiguration = @import("s3_log_configuration.zig").S3LogConfiguration;

/// The configuration of the log.
pub const LogConfiguration = struct {
    /// The configuration for delivering the logs to S3.
    s_3: ?S3LogConfiguration = null,

    pub const json_field_names = .{
        .s_3 = "s3",
    };
};
