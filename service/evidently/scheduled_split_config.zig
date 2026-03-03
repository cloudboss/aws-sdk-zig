const aws = @import("aws");

const SegmentOverride = @import("segment_override.zig").SegmentOverride;

/// This structure defines the traffic allocation percentages among the feature
/// variations during one step of a launch, and the start time of that step.
pub const ScheduledSplitConfig = struct {
    /// The traffic allocation percentages among the feature variations during one
    /// step of a launch. This is a set of key-value pairs. The keys are variation
    /// names. The values represent the percentage of traffic to allocate to that
    /// variation during this step.
    ///
    /// The values is expressed in thousandths of a percent, so assigning a weight
    /// of 50000 assigns 50% of traffic to that variation.
    ///
    /// If the sum of the weights for all the variations in a segment override does
    /// not add up to 100,000, then the remaining traffic that matches this segment
    /// is not assigned by this segment override, and instead moves on to the next
    /// segment override or the default traffic split.
    group_weights: []const aws.map.MapEntry(i64),

    /// Use this parameter to specify different traffic splits for one or more
    /// audience *segments*. A segment is a portion of your audience that share one
    /// or more characteristics. Examples could be Chrome browser users, users in
    /// Europe, or Firefox browser users in Europe who also fit other criteria that
    /// your application collects, such as age.
    ///
    /// This parameter is an array of up to six segment override objects. Each of
    /// these objects specifies a segment that you have already created, and defines
    /// the traffic split for that segment.
    segment_overrides: ?[]const SegmentOverride = null,

    /// The date and time that this step of the launch starts.
    start_time: i64,

    pub const json_field_names = .{
        .group_weights = "groupWeights",
        .segment_overrides = "segmentOverrides",
        .start_time = "startTime",
    };
};
