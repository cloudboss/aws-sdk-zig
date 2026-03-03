const ErrorStatistics = @import("error_statistics.zig").ErrorStatistics;
const FaultStatistics = @import("fault_statistics.zig").FaultStatistics;

/// Response statistics for an edge.
pub const EdgeStatistics = struct {
    /// Information about requests that failed with a 4xx Client Error status code.
    error_statistics: ?ErrorStatistics = null,

    /// Information about requests that failed with a 5xx Server Error status code.
    fault_statistics: ?FaultStatistics = null,

    /// The number of requests that completed with a 2xx Success status code.
    ok_count: ?i64 = null,

    /// The total number of completed requests.
    total_count: ?i64 = null,

    /// The aggregate response time of completed requests.
    total_response_time: ?f64 = null,

    pub const json_field_names = .{
        .error_statistics = "ErrorStatistics",
        .fault_statistics = "FaultStatistics",
        .ok_count = "OkCount",
        .total_count = "TotalCount",
        .total_response_time = "TotalResponseTime",
    };
};
