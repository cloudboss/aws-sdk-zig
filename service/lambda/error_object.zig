/// An object that contains error information.
pub const ErrorObject = struct {
    /// Machine-readable error data.
    error_data: ?[]const u8,

    /// A human-readable error message.
    error_message: ?[]const u8,

    /// The error type.
    error_type: ?[]const u8,

    /// Stack trace information for the error.
    stack_trace: ?[]const []const u8,
};
