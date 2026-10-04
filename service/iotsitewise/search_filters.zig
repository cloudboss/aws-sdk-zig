const TimeInterval = @import("time_interval.zig").TimeInterval;

/// Optional filters that restrict a search to a subset of the workspace's data.
pub const SearchFilters = struct {
    /// Restricts the search to these datasets.
    dataset_ids: ?[]const []const u8 = null,

    /// Restricts the search to these time intervals.
    time_intervals: ?[]const TimeInterval = null,

    /// Restricts the search to these time series.
    time_series_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .dataset_ids = "datasetIds",
        .time_intervals = "timeIntervals",
        .time_series_ids = "timeSeriesIds",
    };
};
