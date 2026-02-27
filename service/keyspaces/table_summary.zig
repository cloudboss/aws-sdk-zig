/// Returns the name of the specified table, the keyspace it is stored in, and
/// the unique identifier in the format of an Amazon Resource Name (ARN).
pub const TableSummary = struct {
    /// The name of the keyspace that the table is stored in.
    keyspace_name: []const u8,

    /// The unique identifier of the table in the format of an Amazon Resource Name
    /// (ARN).
    resource_arn: []const u8,

    /// The name of the table.
    table_name: []const u8,

    pub const json_field_names = .{
        .keyspace_name = "keyspaceName",
        .resource_arn = "resourceArn",
        .table_name = "tableName",
    };
};
