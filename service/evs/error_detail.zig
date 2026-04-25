/// An object that contains error details for an entitlement.
pub const ErrorDetail = struct {
    /// The error code.
    error_code: []const u8,

    /// The error message.
    error_message: []const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
