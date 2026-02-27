/// A search filter defines which resources can be part of a search query result
/// set.
pub const SearchFilter = struct {
    /// The string that contains the search keywords, prefixes, and operators to
    /// control the results that can be returned by a Search operation. For more
    /// details, see [Search query
    /// syntax](https://docs.aws.amazon.com/resource-explorer/latest/APIReference/about-query-syntax.html).
    filter_string: []const u8,

    pub const json_field_names = .{
        .filter_string = "FilterString",
    };
};
