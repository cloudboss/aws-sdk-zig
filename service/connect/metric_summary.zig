const MetricStatus = @import("metric_status.zig").MetricStatus;
const MetricType = @import("metric_type.zig").MetricType;

/// Contains summary information about a metric.
pub const MetricSummary = struct {
    /// The Amazon Resource Name (ARN) of the metric.
    arn: []const u8,

    /// The identifier of the metric.
    id: []const u8,

    /// The region where the metric was last modified.
    last_modified_region: ?[]const u8 = null,

    /// The timestamp of when the metric was last modified.
    last_modified_time: ?i64 = null,

    /// The name of the metric.
    name: []const u8,

    /// The publish status of the metric.
    status: MetricStatus,

    /// The type of the metric.
    @"type": MetricType,

    pub const json_field_names = .{
        .arn = "Arn",
        .id = "Id",
        .last_modified_region = "LastModifiedRegion",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .status = "Status",
        .@"type" = "Type",
    };
};
