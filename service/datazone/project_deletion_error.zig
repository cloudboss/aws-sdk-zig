/// Specifies the error message that is returned if the operation cannot be
/// successfully completed.
pub const ProjectDeletionError = struct {
    /// The code of the project deletion error.
    code: ?[]const u8,

    /// The message of the project deletion error.
    message: ?[]const u8,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
