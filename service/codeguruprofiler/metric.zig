const MetricType = @import("metric_type.zig").MetricType;

/// Details about the metric that the analysis used when it detected the
/// anomaly.
/// The metric what is analyzed to create recommendations. It includes the name
/// of the
/// frame that was analyzed and the type and thread states used to derive the
/// metric
/// value for that frame.
pub const Metric = struct {
    /// The name of the method that appears as a frame in any stack in a profile.
    frame_name: []const u8,

    /// The list of application runtime thread states that is used to calculate the
    /// metric value for the frame.
    thread_states: []const []const u8,

    /// A type that specifies how a metric for a frame is analyzed.
    /// The supported value `AggregatedRelativeTotalTime` is an
    /// aggregation of the metric value for one frame that is calculated across the
    /// occurences of all frames in a profile.
    type: MetricType,

    pub const json_field_names = .{
        .frame_name = "frameName",
        .thread_states = "threadStates",
        .type = "type",
    };
};
