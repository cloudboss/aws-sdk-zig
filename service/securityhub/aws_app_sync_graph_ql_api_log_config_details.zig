/// Specifies the logging configuration when writing GraphQL operations and
/// tracing to Amazon CloudWatch for an
/// AppSync GraphQL API.
pub const AwsAppSyncGraphQlApiLogConfigDetails = struct {
    /// The Amazon Resource Name (ARN) of the service role that AppSync assumes to
    /// publish to CloudWatch Logs
    /// in your account.
    cloud_watch_logs_role_arn: ?[]const u8,

    /// Set to `TRUE` to exclude sections that contain information such as headers,
    /// context, and evaluated mapping templates,
    /// regardless of logging level.
    exclude_verbose_content: ?bool,

    /// The field logging level.
    field_log_level: ?[]const u8,

    pub const json_field_names = .{
        .cloud_watch_logs_role_arn = "CloudWatchLogsRoleArn",
        .exclude_verbose_content = "ExcludeVerboseContent",
        .field_log_level = "FieldLogLevel",
    };
};
