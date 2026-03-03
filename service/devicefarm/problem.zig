const Device = @import("device.zig").Device;
const ProblemDetail = @import("problem_detail.zig").ProblemDetail;
const ExecutionResult = @import("execution_result.zig").ExecutionResult;

/// Represents a specific warning or failure.
pub const Problem = struct {
    /// Information about the associated device.
    device: ?Device = null,

    /// Information about the associated job.
    job: ?ProblemDetail = null,

    /// A message about the problem's result.
    message: ?[]const u8 = null,

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
    result: ?ExecutionResult = null,

    /// Information about the associated run.
    run: ?ProblemDetail = null,

    /// Information about the associated suite.
    suite: ?ProblemDetail = null,

    /// Information about the associated test.
    @"test": ?ProblemDetail = null,

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
