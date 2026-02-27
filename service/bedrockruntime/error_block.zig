/// A block containing error information when content processing fails.
pub const ErrorBlock = struct {
    /// A human-readable error message describing what went wrong during content
    /// processing.
    message: ?[]const u8,

    pub const json_field_names = .{
        .message = "message",
    };
};
