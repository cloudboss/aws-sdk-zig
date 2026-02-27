/// Object for field Options errors.
pub const FieldOptionError = struct {
    /// Error code from creating or updating field option.
    error_code: []const u8,

    /// Error message from creating or updating field option.
    message: []const u8,

    /// The field option value that caused the error.
    value: []const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .message = "message",
        .value = "value",
    };
};
