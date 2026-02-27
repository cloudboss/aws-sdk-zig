/// A prepared SQL statement for use with Athena.
pub const PreparedStatement = struct {
    /// The description of the prepared statement.
    description: ?[]const u8,

    /// The last modified time of the prepared statement.
    last_modified_time: ?i64,

    /// The query string for the prepared statement.
    query_statement: ?[]const u8,

    /// The name of the prepared statement.
    statement_name: ?[]const u8,

    /// The name of the workgroup to which the prepared statement belongs.
    work_group_name: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .query_statement = "QueryStatement",
        .statement_name = "StatementName",
        .work_group_name = "WorkGroupName",
    };
};
