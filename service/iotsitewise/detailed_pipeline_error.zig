const DetailedPipelineErrorCode = @import("detailed_pipeline_error_code.zig").DetailedPipelineErrorCode;

/// Contains a detailed error entry for granular troubleshooting of pipeline
/// failures.
pub const DetailedPipelineError = struct {
    /// The error code.
    code: DetailedPipelineErrorCode,

    /// The associated error message.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
