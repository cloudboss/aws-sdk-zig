const Device = @import("device.zig").Device;
const ProblemDetail = @import("problem_detail.zig").ProblemDetail;
const ExecutionResult = @import("execution_result.zig").ExecutionResult;

/// Represents a specific warning or failure.
pub const Problem = struct {
    /// Information about the associated device.
    device: ?Device,

    /// Information about the associated job.
    job: ?ProblemDetail,

    /// A message about the problem's result.
    message: ?[]const u8,

    /// The problem's result.
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

    /// Information about the associated run.
    run: ?ProblemDetail,

    /// Information about the associated suite.
    suite: ?ProblemDetail,

    /// Information about the associated test.
    @"test": ?ProblemDetail,

    pub const json_field_names = .{
        .device = "device",
        .job = "job",
        .message = "message",
        .result = "result",
        .run = "run",
        .suite = "suite",
        .@"test" = "test",
    };
};
