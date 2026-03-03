const GroupBy = @import("group_by.zig").GroupBy;
const TemporalStatistics = @import("temporal_statistics.zig").TemporalStatistics;

/// The structure representing the configuration for Temporal Statistics
/// operation.
pub const TemporalStatisticsConfigInput = struct {
    /// The input for the temporal statistics grouping by time frequency option.
    group_by: ?GroupBy = null,

    /// The list of the statistics method options.
    statistics: []const TemporalStatistics,

    /// The list of target band names for the temporal statistic to calculate.
    target_bands: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .group_by = "GroupBy",
        .statistics = "Statistics",
        .target_bands = "TargetBands",
    };
};
