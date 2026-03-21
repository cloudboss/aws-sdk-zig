const LogRedactionConfiguration = @import("log_redaction_configuration.zig").LogRedactionConfiguration;
const LogType = @import("log_type.zig").LogType;

/// Provides the information necessary for a user to access the logs.
pub const LogsConfigurationPolicy = struct {
    /// A list of account IDs that are allowed to access the logs.
    allowed_account_ids: []const []const u8,

    /// A regular expression pattern that is used to parse the logs and return
    /// information that matches the pattern.
    filter_pattern: ?[]const u8 = null,

    /// Specifies the log redaction configuration for this policy.
    log_redaction_configuration: ?LogRedactionConfiguration = null,

    /// Specifies the type of log this policy applies to. The currently supported
    /// policies are ALL or ERROR_SUMMARY.
    log_type: LogType = .all,

    pub const json_field_names = .{
        .allowed_account_ids = "allowedAccountIds",
        .filter_pattern = "filterPattern",
        .log_redaction_configuration = "logRedactionConfiguration",
        .log_type = "logType",
    };
};
