const aws = @import("aws");

const MonitorState = @import("monitor_state.zig").MonitorState;

/// Displays summary information about a monitor.
pub const MonitorSummary = struct {
    /// The time, in seconds, that metrics are collected and sent to Amazon
    /// CloudWatch. Valid values are either `30` or `60`.
    aggregation_period: ?i64 = null,

    /// The ARN of the monitor.
    monitor_arn: []const u8,

    /// The name of the monitor.
    monitor_name: []const u8,

    /// The state of the monitor.
    state: MonitorState,

    /// The list of key-value pairs assigned to the monitor.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aggregation_period = "aggregationPeriod",
        .monitor_arn = "monitorArn",
        .monitor_name = "monitorName",
        .state = "state",
        .tags = "tags",
    };
};
