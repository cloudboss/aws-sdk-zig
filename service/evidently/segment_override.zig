const aws = @import("aws");

/// This structure specifies a segment that you have already created, and
/// defines the traffic split for that segment to be used in a launch.
pub const SegmentOverride = struct {
    /// A number indicating the order to use to evaluate segment overrides, if there
    /// are more than one. Segment overrides with lower numbers are evaluated first.
    evaluation_order: i64,

    /// The ARN of the segment to use.
    segment: []const u8,

    /// The traffic allocation percentages among the feature variations to assign to
    /// this segment. This is a set of key-value pairs. The keys are variation
    /// names. The values represent the amount of traffic to allocate to that
    /// variation for this segment. This is expressed in thousandths of a percent,
    /// so a weight of 50000 represents 50% of traffic.
    weights: []const aws.map.MapEntry(i64),

    pub const json_field_names = .{
        .evaluation_order = "evaluationOrder",
        .segment = "segment",
        .weights = "weights",
    };
};
