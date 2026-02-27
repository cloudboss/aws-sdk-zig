/// Contains the actual text content from a source document that is being cited
/// or referenced in the model's response.
pub const CitationSourceContent = union(enum) {
    /// The text content from the source document that is being cited.
    text: ?[]const u8,

    pub const json_field_names = .{
        .text = "text",
    };
};
