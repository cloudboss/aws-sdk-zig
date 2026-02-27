/// Details about the error.
pub const ErrorDetail = struct {
    /// The error code that identifies the type of error.
    error_code: ?[]const u8,

    /// The message for the error.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
