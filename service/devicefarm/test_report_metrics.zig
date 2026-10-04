/// Contains aggregated metrics across all tests in a job.
pub const TestReportMetrics = struct {
    /// The median execution duration of tests in the job, in seconds.
    median_test_execution_duration_seconds: ?f64 = null,

    /// The number of tests that errored.
    tests_errored: ?i32 = null,

    /// The number of tests that failed.
    tests_failed: ?i32 = null,

    /// The number of tests with other result types.
    tests_other: ?i32 = null,

    /// The number of tests that passed.
    tests_passed: ?i32 = null,

    /// The percentage of tests that passed.
    tests_passed_percentage: ?f64 = null,

    /// The number of tests that were skipped.
    tests_skipped: ?i32 = null,

    /// The total number of tests in the job.
    tests_total: ?i32 = null,

    /// The total execution duration of all tests in the job, in seconds.
    total_test_execution_duration_seconds: ?f64 = null,

    pub const json_field_names = .{
        .median_test_execution_duration_seconds = "medianTestExecutionDurationSeconds",
        .tests_errored = "testsErrored",
        .tests_failed = "testsFailed",
        .tests_other = "testsOther",
        .tests_passed = "testsPassed",
        .tests_passed_percentage = "testsPassedPercentage",
        .tests_skipped = "testsSkipped",
        .tests_total = "testsTotal",
        .total_test_execution_duration_seconds = "totalTestExecutionDurationSeconds",
    };
};
