/// Contains detailed error information from pipeline test operations, providing
/// structured error responses for better debugging and troubleshooting
/// capabilities.
pub const PipelineOutputError = struct {
    /// The detailed error message describing what went wrong during the pipeline
    /// test operation for this record.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
    };
};
