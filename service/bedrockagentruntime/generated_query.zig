const GeneratedQueryType = @import("generated_query_type.zig").GeneratedQueryType;

/// Contains information about a query generated for a natural language query.
pub const GeneratedQuery = struct {
    /// An SQL query that corresponds to the natural language query.
    sql: ?[]const u8 = null,

    /// The type of transformed query.
    @"type": ?GeneratedQueryType = null,

    pub const json_field_names = .{
        .sql = "sql",
        .@"type" = "type",
    };
};
