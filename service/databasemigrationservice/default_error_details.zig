/// Provides error information about a schema conversion operation.
pub const DefaultErrorDetails = struct {
    /// The error message.
    message: ?[]const u8,

    pub const json_field_names = .{
        .message = "Message",
    };
};
