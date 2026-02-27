/// Contains logging configuration information for an extension.
pub const LoggingConfig = struct {
    /// The Amazon CloudWatch Logs group to which CloudFormation sends error logging
    /// information when invoking the
    /// extension's handlers.
    log_group_name: []const u8,

    /// The Amazon Resource Name (ARN) of the role that CloudFormation should assume
    /// when sending log
    /// entries to CloudWatch Logs.
    log_role_arn: []const u8,
};
