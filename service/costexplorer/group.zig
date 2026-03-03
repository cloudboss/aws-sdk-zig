const aws = @import("aws");

const MetricValue = @import("metric_value.zig").MetricValue;

/// One level of grouped data in the results.
pub const Group = struct {
    /// The keys that are included in this group.
    keys: ?[]const []const u8 = null,

    /// The metrics that are included in this group.
    metrics: ?[]const aws.map.MapEntry(MetricValue) = null,

    pub const json_field_names = .{
        .keys = "Keys",
        .metrics = "Metrics",
    };
};
