/// A content block in the system prompt.
pub const HarnessSystemContentBlock = union(enum) {
    /// The text content of the system prompt block.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
