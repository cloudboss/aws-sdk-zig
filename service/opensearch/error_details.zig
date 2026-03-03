/// Additional information if the package is in an error state. Null otherwise.
pub const ErrorDetails = struct {
    /// A message describing the error.
    error_message: ?[]const u8 = null,

    /// The type of error that occurred.
    error_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "ErrorMessage",
        .error_type = "ErrorType",
    };
};
