pub const CloudWatchLogs = struct {
    enabled: bool,

    log_group: ?[]const u8,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .log_group = "LogGroup",
    };
};
