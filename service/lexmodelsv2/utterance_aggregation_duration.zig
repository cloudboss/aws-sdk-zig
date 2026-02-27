const RelativeAggregationDuration = @import("relative_aggregation_duration.zig").RelativeAggregationDuration;

/// Provides parameters for setting the time window and duration for
/// aggregating utterance data.
pub const UtteranceAggregationDuration = struct {
    /// The desired time window for aggregating utterances.
    relative_aggregation_duration: RelativeAggregationDuration,

    pub const json_field_names = .{
        .relative_aggregation_duration = "relativeAggregationDuration",
    };
};
