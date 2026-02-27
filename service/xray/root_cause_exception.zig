/// The exception associated with a root cause.
pub const RootCauseException = struct {
    /// The message of the exception.
    message: ?[]const u8,

    /// The name of the exception.
    name: ?[]const u8,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
