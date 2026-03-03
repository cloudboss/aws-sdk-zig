const ErrorCode = @import("error_code.zig").ErrorCode;

/// Contains information about the errors encountered.
pub const BatchPutMessageErrorEntry = struct {
    /// The error code.
    error_code: ?ErrorCode = null,

    /// A message that describes the error.
    error_message: ?[]const u8 = null,

    /// The ID of the message that caused the error. (See the value corresponding to
    /// the
    /// `"messageId"` key in the `"message"` object.)
    message_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .message_id = "messageId",
    };
};
