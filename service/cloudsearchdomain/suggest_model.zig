const SuggestionMatch = @import("suggestion_match.zig").SuggestionMatch;

/// Container for the suggestion information returned in a `SuggestResponse`.
pub const SuggestModel = struct {
    /// The number of documents that were found to match the query string.
    found: i64 = 0,

    /// The query string specified in the suggest request.
    query: ?[]const u8,

    /// The documents that match the query string.
    suggestions: ?[]const SuggestionMatch,

    pub const json_field_names = .{
        .found = "found",
        .query = "query",
        .suggestions = "suggestions",
    };
};
