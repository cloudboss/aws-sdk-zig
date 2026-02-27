/// An object containing error details.
pub const ErrorDetails = struct {
    /// The error code for an error.
    error_code: ?[]const u8,

    /// The error message for an error.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
