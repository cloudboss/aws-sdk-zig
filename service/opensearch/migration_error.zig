/// Contains error details for a migration that failed or completed with errors.
pub const MigrationError = struct {
    /// The error code identifying the type of failure.
    code: ?[]const u8 = null,

    /// A human-readable description of the error.
    message: ?[]const u8 = null,

    pub const json_field_names = .{
        .code = "code",
        .message = "message",
    };
};
