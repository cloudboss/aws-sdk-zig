/// Suggestions for refining individual query terms. Suggestions are returned as
/// objects which note the term, suggested replacement, and its index in the
/// query.
pub const QueryRefinement = struct {
    /// End index of the parsed query.
    end_index: i32,

    /// The sub-string of the original query that is replaced by this query term.
    original_term: []const u8,

    /// The term that will be suggested to the user.
    refined_term: []const u8,

    /// Start index of the parsed component.
    start_index: i32,

    pub const json_field_names = .{
        .end_index = "EndIndex",
        .original_term = "OriginalTerm",
        .refined_term = "RefinedTerm",
        .start_index = "StartIndex",
    };
};
