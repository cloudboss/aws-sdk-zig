const Counters = @import("counters.zig").Counters;
const DeviceMinutes = @import("device_minutes.zig").DeviceMinutes;
const ExecutionResult = @import("execution_result.zig").ExecutionResult;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const TestType = @import("test_type.zig").TestType;

/// Represents a collection of one or more tests.
pub const Suite = struct {
    /// The suite's ARN.
    arn: ?[]const u8 = null,

    /// The suite's result counters.
    counters: ?Counters = null,

    /// When the suite was created.
    created: ?i64 = null,

    /// Represents the total (metered or unmetered) minutes used by the test
    /// suite.
    device_minutes: ?DeviceMinutes = null,

    /// A message about the suite's result.
    message: ?[]const u8 = null,

    /// The suite's name.
    name: ?[]const u8 = null,

    /// The suite's result.
    ///
    /// Allowed values include:
    ///
    /// * PENDING
    ///
    /// * PASSED
    ///
    /// * WARNED
    ///
    /// * FAILED
    ///
    /// * SKIPPED
    ///
    /// * ERRORED
    ///
    /// * STOPPED
    result: ?ExecutionResult = null,

    /// The suite's start time.
    started: ?i64 = null,

    /// The suite's status.
    ///
    /// Allowed values include:
    ///
    /// * PENDING
    ///
    /// * PENDING_CONCURRENCY
    ///
    /// * PENDING_DEVICE
    ///
    /// * PROCESSING
    ///
    /// * SCHEDULING
    ///
    /// * PREPARING
    ///
    /// * RUNNING
    ///
    /// * COMPLETED
    ///
    /// * STOPPING
    status: ?ExecutionStatus = null,

    /// The suite's stop time.
    stopped: ?i64 = null,

    /// The suite's type.
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
    @"type": ?TestType = null,

    pub const json_field_names = .{
        .arn = "arn",
        .counters = "counters",
        .created = "created",
        .device_minutes = "deviceMinutes",
        .message = "message",
        .name = "name",
        .result = "result",
        .started = "started",
        .status = "status",
        .stopped = "stopped",
        .@"type" = "type",
    };
};
