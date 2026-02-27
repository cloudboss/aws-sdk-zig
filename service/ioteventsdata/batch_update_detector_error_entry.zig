const ErrorCode = @import("error_code.zig").ErrorCode;

/// Information about the error that occurred when attempting to update a
/// detector.
pub const BatchUpdateDetectorErrorEntry = struct {
    /// The error code.
    error_code: ?ErrorCode,

    /// A message that describes the error.
    error_message: ?[]const u8,

    /// The `"messageId"` of the update request that caused the error. (The value of
    /// the `"messageId"` in the update request `"Detector"` object.)
    message_id: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
        .message_id = "messageId",
    };
};
