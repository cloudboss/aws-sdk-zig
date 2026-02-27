/// An error from a batch read set operation.
pub const ReadSetBatchError = struct {
    /// The error's code.
    code: []const u8,

    /// The error's ID.
    id: []const u8,

    /// The error's message.
    message: []const u8,

    pub const json_field_names = .{
        .code = "code",
        .id = "id",
        .message = "message",
    };
};
