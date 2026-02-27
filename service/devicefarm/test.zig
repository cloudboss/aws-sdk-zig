const Counters = @import("counters.zig").Counters;
const DeviceMinutes = @import("device_minutes.zig").DeviceMinutes;
const ExecutionResult = @import("execution_result.zig").ExecutionResult;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const TestType = @import("test_type.zig").TestType;

/// Represents a condition that is evaluated.
pub const Test = struct {
    /// The test's ARN.
    arn: ?[]const u8,

    /// The test's result counters.
    counters: ?Counters,

    /// When the test was created.
    created: ?i64,

    /// Represents the total (metered or unmetered) minutes used by the test.
    device_minutes: ?DeviceMinutes,

    /// A message about the test's result.
    message: ?[]const u8,

    /// The test's name.
    name: ?[]const u8,

    /// The test's result.
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
    result: ?ExecutionResult,

    /// The test's start time.
    started: ?i64,

    /// The test's status.
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
    status: ?ExecutionStatus,

    /// The test's stop time.
    stopped: ?i64,

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
    type: ?TestType,

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
        .type = "type",
    };
};
