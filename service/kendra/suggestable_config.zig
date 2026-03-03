/// Provides the configuration information for a document field/attribute that
/// you want to base query
/// suggestions on.
pub const SuggestableConfig = struct {
    /// The name of the document field/attribute.
    attribute_name: ?[]const u8 = null,

    /// `TRUE` means the document field/attribute is suggestible, so the contents
    /// within the
    /// field can be used for query suggestions.
    suggestable: ?bool = null,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .suggestable = "Suggestable",
    };
};
