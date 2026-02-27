/// The partition key portion of the primary key is required and determines how
/// Amazon Keyspaces stores the data. The partition key can be a single column,
/// or it can be a compound value composed of two or more columns.
pub const PartitionKey = struct {
    /// The name(s) of the partition key column(s).
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
