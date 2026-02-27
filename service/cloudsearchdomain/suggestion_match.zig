/// An autocomplete suggestion that matches the query string specified in a
/// `SuggestRequest`.
pub const SuggestionMatch = struct {
    /// The document ID of the suggested document.
    id: ?[]const u8,

    /// The relevance score of a suggested match.
    score: i64 = 0,

    /// The string that matches the query string specified in the `SuggestRequest`.
    suggestion: ?[]const u8,

    pub const json_field_names = .{
        .id = "id",
        .score = "score",
        .suggestion = "suggestion",
    };
};
