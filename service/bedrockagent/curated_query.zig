/// Contains configurations for a query, each of which defines information about
/// example queries to help the query engine generate appropriate SQL queries.
pub const CuratedQuery = struct {
    /// An example natural language query.
    natural_language: []const u8,

    /// The SQL equivalent of the natural language query.
    sql: []const u8,

    pub const json_field_names = .{
        .natural_language = "naturalLanguage",
        .sql = "sql",
    };
};
