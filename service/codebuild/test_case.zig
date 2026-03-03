/// Information about a test case created using a framework such as NUnit or
/// Cucumber. A
/// test case might be a unit test or a configuration test.
pub const TestCase = struct {
    /// The number of nanoseconds it took to run this test case.
    duration_in_nano_seconds: ?i64 = null,

    /// The date and time a test case expires. A test case expires 30 days after it
    /// is
    /// created. An expired test case is not available to view in CodeBuild.
    expired: ?i64 = null,

    /// A message associated with a test case. For example, an error message or
    /// stack trace.
    message: ?[]const u8 = null,

    /// The name of the test case.
    name: ?[]const u8 = null,

    /// A string that is applied to a series of related test cases. CodeBuild
    /// generates the
    /// prefix. The prefix depends on the framework used to generate the tests.
    prefix: ?[]const u8 = null,

    /// The ARN of the report to which the test case belongs.
    report_arn: ?[]const u8 = null,

    /// The status returned by the test case after it was run. Valid statuses are
    /// `SUCCEEDED`, `FAILED`, `ERROR`,
    /// `SKIPPED`, and `UNKNOWN`.
    status: ?[]const u8 = null,

    /// The path to the raw data file that contains the test result.
    test_raw_data_path: ?[]const u8 = null,

    /// The name of the test suite that the test case is a part of.
    test_suite_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .duration_in_nano_seconds = "durationInNanoSeconds",
        .expired = "expired",
        .message = "message",
        .name = "name",
        .prefix = "prefix",
        .report_arn = "reportArn",
        .status = "status",
        .test_raw_data_path = "testRawDataPath",
        .test_suite_name = "testSuiteName",
    };
};
