/// Configure egress access logging.
pub const EgressAccessLogs = struct {
    /// Customize the log group name.
    log_group_name: ?[]const u8,

    pub const json_field_names = .{
        .log_group_name = "LogGroupName",
    };
};
