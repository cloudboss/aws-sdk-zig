/// Indicates the error that was encountered while importing a resource.
pub const ErrorDetail = struct {
    /// Provides additional information about the error.
    error_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
    };
};
