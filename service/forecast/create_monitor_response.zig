pub const CreateMonitorResponse = struct {
    /// The Amazon Resource Name (ARN) of the monitor resource.
    monitor_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .monitor_arn = "MonitorArn",
    };
};
