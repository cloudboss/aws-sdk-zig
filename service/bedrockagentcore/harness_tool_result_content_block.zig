/// A content block within a tool result.
pub const HarnessToolResultContentBlock = union(enum) {
    /// JSON content.
    json: ?[]const u8,
    /// Text content.
    text: ?[]const u8,

    pub const json_field_names = .{
        .json = "json",
        .text = "text",
    };
};
