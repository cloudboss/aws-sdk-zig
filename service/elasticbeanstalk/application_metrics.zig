const Latency = @import("latency.zig").Latency;
const StatusCodes = @import("status_codes.zig").StatusCodes;

/// Application request metrics for an AWS Elastic Beanstalk environment.
pub const ApplicationMetrics = struct {
    /// The amount of time that the metrics cover (usually 10 seconds). For example,
    /// you might
    /// have 5 requests (`request_count`) within the most recent time slice of 10
    /// seconds
    /// (`duration`).
    duration: ?i32 = null,

    /// Represents the average latency for the slowest X percent of requests over
    /// the last 10
    /// seconds. Latencies are in seconds with one millisecond resolution.
    latency: ?Latency = null,

    /// Average number of requests handled by the web server per second over the
    /// last 10
    /// seconds.
    request_count: i32 = 0,

    /// Represents the percentage of requests over the last 10 seconds that resulted
    /// in each
    /// type of status code response.
    status_codes: ?StatusCodes = null,
};
