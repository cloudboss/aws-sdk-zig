const Tag = @import("tag.zig").Tag;

pub const CreateMonitorRequest = struct {
    /// The name of the monitor resource.
    monitor_name: []const u8,

    /// The Amazon Resource Name (ARN) of the predictor to monitor.
    resource_arn: []const u8,

    /// A list of
    /// [tags](https://docs.aws.amazon.com/forecast/latest/dg/tagging-forecast-resources.html) to apply to the monitor resource.
    tags: ?[]const Tag,

    pub const json_field_names = .{
        .monitor_name = "MonitorName",
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
