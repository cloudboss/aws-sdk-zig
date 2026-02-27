const aws = @import("aws");

/// Information about a test report.
pub const TestReportSummary = struct {
    /// The number of nanoseconds it took to run all of the test cases in this
    /// report.
    duration_in_nano_seconds: i64,

    /// A map that contains the number of each type of status returned by the test
    /// results in
    /// this `TestReportSummary`.
    status_counts: []const aws.map.MapEntry(i32),

    /// The number of test cases in this `TestReportSummary`. The total includes
    /// truncated test cases.
    total: i32,

    pub const json_field_names = .{
        .duration_in_nano_seconds = "durationInNanoSeconds",
        .status_counts = "statusCounts",
        .total = "total",
    };
};
