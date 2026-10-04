const aws = @import("aws");

const TestType = @import("test_type.zig").TestType;

/// Represents test settings. This data structure is passed in as the test
/// parameter to ScheduleRun. For an
/// example of the JSON request syntax, see ScheduleRun.
pub const ScheduleRunTest = struct {
    /// The test's filter.
    filter: ?[]const u8 = null,

    /// The test's parameters, such as test framework parameters and fixture
    /// settings.
    /// Parameters are represented by name-value pairs of strings.
    ///
    /// For fuzz tests (Android only):
    ///
    /// * event_count: The number of events, between 1 and 10000, that the UI fuzz
    /// test should perform.
    ///
    /// * throttle: The time, in ms, between 0 and 1000, that the UI fuzz test
    ///   should
    /// wait between events.
    ///
    /// * seed: A seed to use for randomizing the UI fuzz test. Using the same seed
    /// value between tests ensures identical event sequences.
    ///
    /// For Instrumentation:
    ///
    /// * filter: A test filter string. Examples:
    ///
    /// * Running a single test case: `com.android.abc.Test1`
    ///
    /// * Running a single test: `com.android.abc.Test1#smoke`
    ///
    /// * Running multiple tests:
    /// `com.android.abc.Test1,com.android.abc.Test2`
    ///
    /// For XCTest and XCTestUI:
    ///
    /// * filter: A test filter string. Examples:
    ///
    /// * Running a single test class: `LoginTests`
    ///
    /// * Running a multiple test classes: `LoginTests,SmokeTests`
    ///
    /// * Running a single test: `LoginTests/testValid`
    ///
    /// * Running multiple tests:
    /// `LoginTests/testValid,LoginTests/testInvalid`
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The ARN of the uploaded test to be run.
    test_package_arn: ?[]const u8 = null,

    /// The ARN of the YAML-formatted test specification.
    test_spec_arn: ?[]const u8 = null,

    /// The test's type.
    ///
    /// Must be one of the following values:
    ///
    /// * BUILTIN_FUZZ
    ///
    /// * APPIUM_JAVA_JUNIT
    ///
    /// * APPIUM_JAVA_TESTNG
    ///
    /// * APPIUM_PYTHON
    ///
    /// * APPIUM_NODE
    ///
    /// * APPIUM_RUBY
    ///
    /// * APPIUM_WEB_JAVA_JUNIT
    ///
    /// * APPIUM_WEB_JAVA_TESTNG
    ///
    /// * APPIUM_WEB_PYTHON
    ///
    /// * APPIUM_WEB_NODE
    ///
    /// * APPIUM_WEB_RUBY
    ///
    /// * INSTRUMENTATION
    ///
    /// * XCTEST
    ///
    /// * XCTEST_UI
    @"type": TestType,

    pub const json_field_names = .{
        .filter = "filter",
        .parameters = "parameters",
        .test_package_arn = "testPackageArn",
        .test_spec_arn = "testSpecArn",
        .@"type" = "type",
    };
};
