/// This API is in preview release for Amazon Connect and is subject to change.
///
/// List of errors for dataset association failures.
pub const ErrorResult = struct {
    /// The error code.
    error_code: ?[]const u8,

    /// The corresponding error message for the error code.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
