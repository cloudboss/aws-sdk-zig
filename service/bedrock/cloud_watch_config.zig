const S3Config = @import("s3_config.zig").S3Config;

/// CloudWatch logging configuration.
pub const CloudWatchConfig = struct {
    /// S3 configuration for delivering a large amount of data.
    large_data_delivery_s3_config: ?S3Config = null,

    /// The log group name.
    log_group_name: []const u8,

    /// The role Amazon Resource Name (ARN).
    role_arn: []const u8,

    pub const json_field_names = .{
        .large_data_delivery_s3_config = "largeDataDeliveryS3Config",
        .log_group_name = "logGroupName",
        .role_arn = "roleArn",
    };
};
