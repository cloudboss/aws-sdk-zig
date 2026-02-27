/// One of the of text strings. Each string has a size limit of 1KB.
pub const TextSegment = struct {
    /// The text content.
    text: []const u8,

    pub const json_field_names = .{
        .text = "Text",
    };
};
