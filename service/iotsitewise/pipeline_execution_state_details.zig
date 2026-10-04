const PipelineErrorCode = @import("pipeline_error_code.zig").PipelineErrorCode;
const DetailedPipelineError = @import("detailed_pipeline_error.zig").DetailedPipelineError;

/// Additional information about the current execution status. Populated when
/// the execution has terminated.
pub const PipelineExecutionStateDetails = struct {
    /// Classification of the failure. Present when the execution failed.
    code: ?PipelineErrorCode = null,

    /// Per-step error entries to help diagnose a failed execution. Present when the
    /// execution failed.
    details: ?[]const DetailedPipelineError = null,

    /// Human-readable description of the outcome. For a failed execution, this
    /// describes why it failed; for a cancelled execution, this is the reason you
    /// supplied when calling CancelPipelineExecution.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .details = "details",
        .message = "message",
    };
};
