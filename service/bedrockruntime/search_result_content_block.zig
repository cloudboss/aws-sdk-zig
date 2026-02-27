/// A block within a search result that contains the content.
pub const SearchResultContentBlock = struct {
    /// The actual text content
    text: []const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
