/// Describes the error(s) encountered with the last update of the environment.
pub const UpdateError = struct {
    /// The error code that corresponds to the error with the last update.
    error_code: ?[]const u8,

    /// The error message that corresponds to the error code.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "ErrorCode",
        .error_message = "ErrorMessage",
    };
};
