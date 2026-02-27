/// A set of rules used to make a recommendation during an analysis.
pub const Pattern = struct {
    /// A list of the different counters used to determine if there is a match.
    counters_to_aggregate: ?[]const []const u8,

    /// The description of the recommendation. This explains a potential
    /// inefficiency in a profiled application.
    description: ?[]const u8,

    /// The universally unique identifier (UUID) of this pattern.
    id: ?[]const u8,

    /// The name for this pattern.
    name: ?[]const u8,

    /// A string that contains the steps recommended to address the potential
    /// inefficiency.
    resolution_steps: ?[]const u8,

    /// A list of frame names that were searched during the analysis that generated
    /// a recommendation.
    target_frames: ?[]const []const []const u8,

    /// The percentage of time an application spends in one method that triggers
    /// a recommendation. The percentage of time is the same as the percentage of
    /// the total gathered sample counts during analysis.
    threshold_percent: f64 = 0,

    pub const json_field_names = .{
        .counters_to_aggregate = "countersToAggregate",
        .description = "description",
        .id = "id",
        .name = "name",
        .resolution_steps = "resolutionSteps",
        .target_frames = "targetFrames",
        .threshold_percent = "thresholdPercent",
    };
};
