/// Describes a database log event.
pub const LogEvent = struct {
    /// The timestamp when the database log event was created.
    created_at: ?i64,

    /// The message of the database log event.
    message: ?[]const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .message = "message",
    };
};
