/// The exception associated with a root cause.
pub const RootCauseException = struct {
    /// The message of the exception.
    message: ?[]const u8 = null,

    /// The name of the exception.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .message = "Message",
        .name = "Name",
    };
};
