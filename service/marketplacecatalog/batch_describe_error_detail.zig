/// An object that contains an error code and error message.
pub const BatchDescribeErrorDetail = struct {
    /// The error code returned.
    error_code: ?[]const u8 = null,

    /// The error message returned.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
