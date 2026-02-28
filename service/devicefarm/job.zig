const Counters = @import("counters.zig").Counters;
const Device = @import("device.zig").Device;
const DeviceMinutes = @import("device_minutes.zig").DeviceMinutes;
const ExecutionResult = @import("execution_result.zig").ExecutionResult;
const ExecutionStatus = @import("execution_status.zig").ExecutionStatus;
const TestType = @import("test_type.zig").TestType;

/// Represents a device.
pub const Job = struct {
    /// The job's ARN.
    arn: ?[]const u8,

    /// The job's result counters.
    counters: ?Counters,

    /// When the job was created.
    created: ?i64,

    /// The device (phone or tablet).
    device: ?Device,

    /// Represents the total (metered or unmetered) minutes used by the job.
    device_minutes: ?DeviceMinutes,

    /// The ARN of the instance.
    instance_arn: ?[]const u8,

    /// A message about the job's result.
    message: ?[]const u8,

    /// The job's name.
    name: ?[]const u8,

    /// The job's result.
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

    /// The job's start time.
    started: ?i64,

    /// The job's status.
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

    /// The job's stop time.
    stopped: ?i64,

    /// The job's type.
    ///
    /// Allowed values include the following:
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
    @"type": ?TestType,

    /// This value is set to true if video capture is enabled. Otherwise, it is set
    /// to false.
    video_capture: ?bool,

    /// The endpoint for streaming device video.
    video_endpoint: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .counters = "counters",
        .created = "created",
        .device = "device",
        .device_minutes = "deviceMinutes",
        .instance_arn = "instanceArn",
        .message = "message",
        .name = "name",
        .result = "result",
        .started = "started",
        .status = "status",
        .stopped = "stopped",
        .@"type" = "type",
        .video_capture = "videoCapture",
        .video_endpoint = "videoEndpoint",
    };
};
