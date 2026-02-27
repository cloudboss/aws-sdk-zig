/// The translated content.
pub const TranslatedDocument = struct {
    /// The document containing the translated content.
    content: []const u8,

    pub const json_field_names = .{
        .content = "Content",
    };
};
