/// A description of the error that caused an operation to fail.
pub const ErrorInfo = struct {
    error_string: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_string = "ErrorString",
    };
};
