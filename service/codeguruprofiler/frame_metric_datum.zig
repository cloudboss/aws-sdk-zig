const FrameMetric = @import("frame_metric.zig").FrameMetric;

/// Information about a frame metric and its values.
pub const FrameMetricDatum = struct {
    frame_metric: FrameMetric,

    /// A list of values that are associated with a frame metric.
    values: []const f64,

    pub const json_field_names = .{
        .frame_metric = "frameMetric",
        .values = "values",
    };
};
