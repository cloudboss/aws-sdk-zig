/// The error details of a failed notebook export in Amazon SageMaker Unified
/// Studio.
pub const NotebookExportError = struct {
    /// The error message. The maximum length is 256 characters.
    message: []const u8,

    pub const json_field_names = .{
        .message = "message",
    };
};
