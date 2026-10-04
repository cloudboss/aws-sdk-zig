const BatchDeleteErrorCode = @import("batch_delete_error_code.zig").BatchDeleteErrorCode;

/// Represents an error that occurred when attempting to delete a configuration.
pub const BatchDeleteError = struct {
    /// Error code indicating the type of failure.
    code: BatchDeleteErrorCode,

    /// Descriptive error message.
    message: []const u8,

    /// ARN of the configuration that failed to delete.
    resource_arn: []const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
        .resource_arn = "ResourceArn",
    };
};
