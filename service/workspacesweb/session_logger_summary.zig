const LogConfiguration = @import("log_configuration.zig").LogConfiguration;

/// The summary of the session logger resource.
pub const SessionLoggerSummary = struct {
    /// The date the session logger resource was created.
    creation_date: ?i64 = null,

    /// The human-readable display name.
    display_name: ?[]const u8 = null,

    /// The configuration that specifies where the logs are fowarded.
    log_configuration: ?LogConfiguration = null,

    /// The ARN of the session logger resource.
    session_logger_arn: []const u8,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .display_name = "displayName",
        .log_configuration = "logConfiguration",
        .session_logger_arn = "sessionLoggerArn",
    };
};
