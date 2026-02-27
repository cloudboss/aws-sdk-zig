/// A subset of the attributes that describe a log group. In CloudWatch a log
/// group is a group of
/// log streams that share the same retention, monitoring, and access control
/// settings.
pub const LogGroupSummary = struct {
    /// The name of the log group.
    log_group_name: []const u8,

    /// The type of log.
    log_type: []const u8,

    pub const json_field_names = .{
        .log_group_name = "logGroupName",
        .log_type = "logType",
    };
};
