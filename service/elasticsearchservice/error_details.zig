pub const ErrorDetails = struct {
    error_message: ?[]const u8 = null,

    error_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .error_type = "ErrorType",
    };
};
