/// A block of input content.
pub const InputContentBlock = struct {
    /// The binary input content.
    blob: ?[]const u8 = null,

    /// The path to the input content.
    path: []const u8,

    /// The text input content.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .blob = "blob",
        .path = "path",
        .text = "text",
    };
};
