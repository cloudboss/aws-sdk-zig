const LoggingConfigurationStatus = @import("logging_configuration_status.zig").LoggingConfigurationStatus;

/// Contains information about the current rules and alerting logging
/// configuration for the workspace.
///
/// These logging configurations are only for rules and alerting logs.
pub const LoggingConfigurationMetadata = struct {
    /// The date and time that the logging configuration was created.
    created_at: i64,

    /// The ARN of the CloudWatch log group to which the vended log data will be
    /// published.
    log_group_arn: []const u8,

    /// The date and time that the logging configuration was most recently changed.
    modified_at: i64,

    /// The current status of the logging configuration.
    status: LoggingConfigurationStatus,

    /// The ID of the workspace the logging configuration is for.
    workspace: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .log_group_arn = "logGroupArn",
        .modified_at = "modifiedAt",
        .status = "status",
        .workspace = "workspace",
    };
};
