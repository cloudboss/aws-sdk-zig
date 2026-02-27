const aws = @import("aws");

/// Override of a particular evaluation for a profile job.
pub const StatisticOverride = struct {
    /// A map that includes overrides of an evaluation’s parameters.
    parameters: []const aws.map.StringMapEntry,

    /// The name of an evaluation
    statistic: []const u8,

    pub const json_field_names = .{
        .parameters = "Parameters",
        .statistic = "Statistic",
    };
};
