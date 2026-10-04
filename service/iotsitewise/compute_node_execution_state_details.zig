const ComputeNodeErrorCode = @import("compute_node_error_code.zig").ComputeNodeErrorCode;
const DetailedPipelineError = @import("detailed_pipeline_error.zig").DetailedPipelineError;

/// Additional information about a compute node that has failed.
pub const ComputeNodeExecutionStateDetails = struct {
    /// Classification of the failure.
    code: ComputeNodeErrorCode,

    /// Detailed error entries to help diagnose the failure.
    details: ?[]const DetailedPipelineError = null,

    /// Human-readable description of why the compute node failed.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .details = "details",
        .message = "message",
    };
};
