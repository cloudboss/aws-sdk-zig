/// Contains information about a partition key for an event data store.
pub const PartitionKey = struct {
    /// The name of the partition key.
    name: []const u8,

    /// The data type of the partition key. For example, `bigint` or `string`.
    @"type": []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .@"type" = "Type",
    };
};
