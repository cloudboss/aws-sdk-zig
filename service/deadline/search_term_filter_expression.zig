const SearchTermMatchingType = @import("search_term_matching_type.zig").SearchTermMatchingType;

/// Searches for a particular search term.
pub const SearchTermFilterExpression = struct {
    /// Specifies how Deadline Cloud matches your search term in the results. If you
    /// don't specify a `matchType` the default is `FUZZY_MATCH`.
    ///
    /// * `FUZZY_MATCH` - Matches if a portion of the search term is found in the
    ///   result.
    /// * `CONTAINS` - Matches if the exact search term is contained in the result.
    match_type: SearchTermMatchingType = "FUZZY_MATCH",

    /// The term to search for.
    search_term: []const u8,

    pub const json_field_names = .{
        .match_type = "matchType",
        .search_term = "searchTerm",
    };
};
