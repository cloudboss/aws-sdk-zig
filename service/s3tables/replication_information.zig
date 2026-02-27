/// Contains information about the source of a replicated table.
pub const ReplicationInformation = struct {
    /// The Amazon Resource Name (ARN) of the source table from which this table is
    /// replicated.
    source_table_arn: []const u8,

    pub const json_field_names = .{
        .source_table_arn = "sourceTableARN",
    };
};
