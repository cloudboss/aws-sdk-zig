/// Object for errors on fields.
pub const FieldError = struct {
    /// The error code from getting a field.
    error_code: []const u8,

    /// The field identifier that caused the error.
    id: []const u8,

    /// The error message from getting a field.
    message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .id = "id",
        .message = "message",
    };
};
