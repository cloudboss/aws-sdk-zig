/// Specifies a search result location within the content array, providing
/// positioning information for cited content using search result index and
/// block positions.
pub const SearchResultLocation = struct {
    /// The ending position in the content array where the cited content ends.
    end: ?i32,

    /// The index of the search result content block where the cited content is
    /// found.
    search_result_index: ?i32,

    /// The starting position in the content array where the cited content begins.
    start: ?i32,

    pub const json_field_names = .{
        .end = "end",
        .search_result_index = "searchResultIndex",
        .start = "start",
    };
};
