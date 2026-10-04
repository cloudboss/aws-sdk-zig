/// Citation information for AI-generated responses.
pub const Citation = struct {
    /// Content text from the compliance source.
    source_content: ?[]const u8 = null,

    /// Label identifying the compliance source.
    source_label: ?[]const u8 = null,

    /// Link to the compliance source.
    source_link: ?[]const u8 = null,

    pub const json_field_names = .{
        .source_content = "sourceContent",
        .source_label = "sourceLabel",
        .source_link = "sourceLink",
    };
};
