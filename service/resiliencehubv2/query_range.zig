const QueryDataPoint = @import("query_data_point.zig").QueryDataPoint;
const QueryGranularity = @import("query_granularity.zig").QueryGranularity;

/// Defines a time range for dependency query data.
pub const QueryRange = struct {
    /// The data points within the query range.
    data_points: []const QueryDataPoint,

    /// The end time of the query range.
    end_time: i64,

    /// The granularity of the query range data points.
    granularity: QueryGranularity,

    /// The start time of the query range.
    start_time: i64,

    pub const json_field_names = .{
        .data_points = "dataPoints",
        .end_time = "endTime",
        .granularity = "granularity",
        .start_time = "startTime",
    };
};
