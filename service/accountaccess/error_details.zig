const ErrorCode = @import("error_code.zig").ErrorCode;

/// Contains information about an error that occurred during application
/// processing.
pub const ErrorDetails = struct {
    /// The error code that identifies the type of error.
    code: ErrorCode,

    /// A human-readable message that describes the error.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
