/// Represents information about an error in CodePipeline.
pub const ErrorDetails = struct {
    /// The system ID or number code of the error.
    code: ?[]const u8,

    /// The text of the error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
