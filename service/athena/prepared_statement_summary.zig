/// The name and last modified time of the prepared statement.
pub const PreparedStatementSummary = struct {
    /// The last modified time of the prepared statement.
    last_modified_time: ?i64,

    /// The name of the prepared statement.
    statement_name: ?[]const u8,

    pub const json_field_names = .{
        .last_modified_time = "LastModifiedTime",
        .statement_name = "StatementName",
    };
};
