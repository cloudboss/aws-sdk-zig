/// Represents a StatusException.
pub const StatusException = struct {
    /// The exception.
    exception: ?[]const u8,

    /// The error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .exception = "Exception",
        .message = "Message",
    };
};
