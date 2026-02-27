/// Placeholder documentation for ValidationError
pub const ValidationError = struct {
    /// Path to the source of the error.
    element_path: ?[]const u8,

    /// The error message.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .element_path = "ElementPath",
        .error_message = "ErrorMessage",
    };
};
