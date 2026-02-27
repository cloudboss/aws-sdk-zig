/// Contains information about an error returned from a user access task.
pub const TaskError = struct {
    /// The code of the error.
    error_code: ?[]const u8,

    /// The message of the error.
    error_message: ?[]const u8,

    pub const json_field_names = .{
        .error_code = "errorCode",
        .error_message = "errorMessage",
    };
};
