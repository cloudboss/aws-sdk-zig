const PartitionKey = @import("partition_key.zig").PartitionKey;

/// A Schema specifies the expected data model of the table.
pub const Schema = struct {
    /// A non-empty list of partition keys defining the attributes used to partition
    /// the table
    /// data. The order of the list determines the partition hierarchy. The name and
    /// type of each
    /// partition key as well as the partition key order cannot be changed after the
    /// table is
    /// created. However, the enforcement level of each partition key can be
    /// changed.
    composite_partition_key: ?[]const PartitionKey = null,

    pub const json_field_names = .{
        .composite_partition_key = "CompositePartitionKey",
    };
};
