/// Details about the error.
pub const ErrorDetail = struct {
    /// A detailed error code.
    detailed_error_code: ?[]const u8 = null,

    /// A detailed error message.
    detailed_error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .detailed_error_code = "DetailedErrorCode",
        .detailed_error_message = "DetailedErrorMessage",
    };
};
