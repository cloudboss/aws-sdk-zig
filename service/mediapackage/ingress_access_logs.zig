/// Configure ingress access logging.
pub const IngressAccessLogs = struct {
    /// Customize the log group name.
    log_group_name: ?[]const u8,

    pub const json_field_names = .{
        .log_group_name = "LogGroupName",
    };
};
