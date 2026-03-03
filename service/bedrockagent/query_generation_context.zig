const CuratedQuery = @import("curated_query.zig").CuratedQuery;
const QueryGenerationTable = @import("query_generation_table.zig").QueryGenerationTable;

/// >Contains configurations for context to use during query generation.
pub const QueryGenerationContext = struct {
    /// An array of objects, each of which defines information about example queries
    /// to help the query engine generate appropriate SQL queries.
    curated_queries: ?[]const CuratedQuery = null,

    /// An array of objects, each of which defines information about a table in the
    /// database.
    tables: ?[]const QueryGenerationTable = null,

    pub const json_field_names = .{
        .curated_queries = "curatedQueries",
        .tables = "tables",
    };
};
