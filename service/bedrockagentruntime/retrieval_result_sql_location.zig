/// Contains information about the SQL query used to retrieve the result.
pub const RetrievalResultSqlLocation = struct {
    /// The SQL query used to retrieve the result.
    query: ?[]const u8 = null,

    pub const json_field_names = .{
        .query = "query",
    };
};
