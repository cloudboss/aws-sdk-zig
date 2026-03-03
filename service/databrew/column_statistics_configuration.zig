const ColumnSelector = @import("column_selector.zig").ColumnSelector;
const StatisticsConfiguration = @import("statistics_configuration.zig").StatisticsConfiguration;

/// Configuration for column evaluations for a profile job.
/// ColumnStatisticsConfiguration can be used to select
/// evaluations and override parameters of evaluations for particular columns.
pub const ColumnStatisticsConfiguration = struct {
    /// List of column selectors. Selectors can be used to select columns from the
    /// dataset.
    /// When selectors are undefined, configuration will be applied to all supported
    /// columns.
    selectors: ?[]const ColumnSelector = null,

    /// Configuration for evaluations. Statistics can be used to select evaluations
    /// and override
    /// parameters of evaluations.
    statistics: StatisticsConfiguration,

    pub const json_field_names = .{
        .selectors = "Selectors",
        .statistics = "Statistics",
    };
};
