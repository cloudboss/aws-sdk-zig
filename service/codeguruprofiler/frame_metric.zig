const MetricType = @import("metric_type.zig").MetricType;

/// The frame name, metric type, and thread states. These are used
/// to derive the value of the metric for the frame.
pub const FrameMetric = struct {
    /// Name of the method common across the multiple occurrences of a frame in an
    /// application
    /// profile.
    frame_name: []const u8,

    /// List of application runtime thread states used to get the counts for a frame
    /// a derive a metric value.
    thread_states: []const []const u8,

    /// A type of aggregation that specifies how a metric for a frame is analyzed.
    /// The
    /// supported value `AggregatedRelativeTotalTime` is an aggregation of the
    /// metric
    /// value for one frame that is calculated across the occurrences of all frames
    /// in a profile.
    @"type": MetricType,

    pub const json_field_names = .{
        .frame_name = "frameName",
        .thread_states = "threadStates",
        .@"type" = "type",
    };
};
