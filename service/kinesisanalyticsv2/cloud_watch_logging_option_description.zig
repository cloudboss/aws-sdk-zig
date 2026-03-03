/// Describes the Amazon CloudWatch logging option.
pub const CloudWatchLoggingOptionDescription = struct {
    /// The ID of the CloudWatch logging option description.
    cloud_watch_logging_option_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the CloudWatch log to receive application
    /// messages.
    log_stream_arn: []const u8,

    /// The IAM ARN of the role to use to send application messages.
    ///
    /// Provided for backward compatibility. Applications created with the current
    /// API version have an
    /// application-level service execution role rather than a resource-level role.
    role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_watch_logging_option_id = "CloudWatchLoggingOptionId",
        .log_stream_arn = "LogStreamARN",
        .role_arn = "RoleARN",
    };
};
