pub const SuggestionType = enum {
    query,
    document_attributes,

    pub const json_field_names = .{
        .query = "QUERY",
        .document_attributes = "DOCUMENT_ATTRIBUTES",
    };
};
