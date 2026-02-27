/// A content block.
pub const ContentBlock = union(enum) {
    /// The block's text.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
