/// Contains the relevant text excerpt from a source that was used to generate a
/// citation text segment in an Amazon Q Business chat response.
pub const SnippetExcerpt = struct {
    /// The relevant text excerpt from a source that was used to generate a citation
    /// text segment in an Amazon Q chat response.
    text: ?[]const u8 = null,

    pub const json_field_names = .{
        .text = "text",
    };
};
