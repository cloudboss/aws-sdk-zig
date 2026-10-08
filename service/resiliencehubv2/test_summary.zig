/// Contains summary information about a test.
pub const TestSummary = struct {
    /// The timestamp when the test was created.
    creation_time: i64,

    /// The ARN of the service the test belongs to.
    service_arn: []const u8,

    /// The number of successful runs of the test.
    successful_test_runs: i32,

    /// The unique identifier of the test.
    test_id: []const u8,

    /// The ARN of the test template the test was created from.
    test_template_arn: []const u8,

    /// The total number of runs of the test.
    total_test_runs: i32,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .service_arn = "serviceArn",
        .successful_test_runs = "successfulTestRuns",
        .test_id = "testId",
        .test_template_arn = "testTemplateArn",
        .total_test_runs = "totalTestRuns",
    };
};
