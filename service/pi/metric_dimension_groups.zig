const DimensionGroupDetail = @import("dimension_group_detail.zig").DimensionGroupDetail;

/// The available dimension information for a metric type.
pub const MetricDimensionGroups = struct {
    /// The available dimension groups for a metric type.
    groups: ?[]const DimensionGroupDetail,

    /// The metric type to which the dimension information belongs.
    metric: ?[]const u8,

    pub const json_field_names = .{
        .groups = "Groups",
        .metric = "Metric",
    };
};
