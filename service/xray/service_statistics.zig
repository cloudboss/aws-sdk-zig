const ErrorStatistics = @import("error_statistics.zig").ErrorStatistics;
const FaultStatistics = @import("fault_statistics.zig").FaultStatistics;

/// Response statistics for a service.
pub const ServiceStatistics = struct {
    /// Information about requests that failed with a 4xx Client Error status code.
    error_statistics: ?ErrorStatistics,

    /// Information about requests that failed with a 5xx Server Error status code.
    fault_statistics: ?FaultStatistics,

    /// The number of requests that completed with a 2xx Success status code.
    ok_count: ?i64,

    /// The total number of completed requests.
    total_count: ?i64,

    /// The aggregate response time of completed requests.
    total_response_time: ?f64,

    pub const json_field_names = .{
        .error_statistics = "ErrorStatistics",
        .fault_statistics = "FaultStatistics",
        .ok_count = "OkCount",
        .total_count = "TotalCount",
        .total_response_time = "TotalResponseTime",
    };
};
