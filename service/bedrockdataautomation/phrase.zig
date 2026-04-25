/// Phrase structure for vocabulary
pub const Phrase = struct {
    display_as_text: ?[]const u8 = null,

    text: []const u8,

    pub const json_field_names = .{
        .display_as_text = "displayAsText",
        .text = "text",
    };
};
