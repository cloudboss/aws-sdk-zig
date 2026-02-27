const BatchItemErrorCode = @import("batch_item_error_code.zig").BatchItemErrorCode;

/// Contains the batch request error details associated with the request.
pub const BatchItemError = struct {
    /// The error code associated with the batch request error.
    code: ?BatchItemErrorCode,

    /// A message with the reason for the batch request error.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
