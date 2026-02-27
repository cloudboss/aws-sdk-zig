/// An object containing an error message, if there was an error.
pub const ErrorDetails = struct {
    /// The error message from the job, if there is one.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_message = "errorMessage",
    };
};
