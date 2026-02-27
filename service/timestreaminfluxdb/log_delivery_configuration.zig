const S3Configuration = @import("s3_configuration.zig").S3Configuration;

/// Configuration for sending InfluxDB engine logs to send to specified S3
/// bucket.
pub const LogDeliveryConfiguration = struct {
    /// Configuration for S3 bucket log delivery.
    s_3_configuration: S3Configuration,

    pub const json_field_names = .{
        .s_3_configuration = "s3Configuration",
    };
};
