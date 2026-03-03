/// A query, where `QueryString` contains the SQL statements that make up the
/// query.
pub const NamedQuery = struct {
    /// The database to which the query belongs.
    database: []const u8,

    /// The query description.
    description: ?[]const u8 = null,

    /// The query name.
    name: []const u8,

    /// The unique identifier of the query.
    named_query_id: ?[]const u8 = null,

    /// The SQL statements that make up the query.
    query_string: []const u8,

    /// The name of the workgroup that contains the named query.
    work_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .database = "Database",
        .description = "Description",
        .name = "Name",
        .named_query_id = "NamedQueryId",
        .query_string = "QueryString",
        .work_group = "WorkGroup",
    };
};
