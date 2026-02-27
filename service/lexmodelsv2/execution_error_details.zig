/// Details about an error in an execution of a test set.
pub const ExecutionErrorDetails = struct {
    /// The error code for the error.
    error_code: []const u8,

    /// The message describing the error.
    error_message: []const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
