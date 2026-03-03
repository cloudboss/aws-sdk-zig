/// Contains information about an error that occurred during a Resource Explorer
/// setup operation.
pub const ErrorDetails = struct {
    /// The error code that identifies the type of error that occurred.
    code: ?[]const u8 = null,

    /// A human-readable description of the error that occurred.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "Code",
        .message = "Message",
    };
};
