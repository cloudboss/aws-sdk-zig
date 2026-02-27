/// A search result returned by the `SearchSampleQueries` operation.
pub const SearchSampleQueriesSearchResult = struct {
    /// A longer description of a sample query.
    description: ?[]const u8,

    /// The name of a sample query.
    name: ?[]const u8,

    /// A value between 0 and 1 indicating the similarity between the search phrase
    /// and result.
    relevance: f32 = 0,

    /// The SQL code of the sample query.
    sql: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .relevance = "Relevance",
        .sql = "SQL",
    };
};
