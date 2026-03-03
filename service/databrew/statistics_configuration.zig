const StatisticOverride = @import("statistic_override.zig").StatisticOverride;

/// Configuration of evaluations for a profile job. This configuration can be
/// used to select
/// evaluations and override the parameters of selected evaluations.
pub const StatisticsConfiguration = struct {
    /// List of included evaluations. When the list is undefined, all supported
    /// evaluations will be included.
    included_statistics: ?[]const []const u8 = null,

    /// List of overrides for evaluations.
    overrides: ?[]const StatisticOverride = null,

    pub const json_field_names = .{
        .included_statistics = "IncludedStatistics",
        .overrides = "Overrides",
    };
};
