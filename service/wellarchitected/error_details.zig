/// Details about an error that occurred during recommendation generation.
pub const ErrorDetails = struct {
    /// The status code identifying the type of error.
    code: []const u8,

    /// A human-readable description of the error.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
