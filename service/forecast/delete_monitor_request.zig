pub const DeleteMonitorRequest = struct {
    /// The Amazon Resource Name (ARN) of the monitor resource to delete.
    monitor_arn: []const u8,

    pub const json_field_names = .{
        .monitor_arn = "MonitorArn",
    };
};
