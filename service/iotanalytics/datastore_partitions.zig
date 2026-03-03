const DatastorePartition = @import("datastore_partition.zig").DatastorePartition;

/// Contains information about the partition dimensions in a data store.
pub const DatastorePartitions = struct {
    /// A list of partition dimensions in a data store.
    partitions: ?[]const DatastorePartition = null,

    pub const json_field_names = .{
        .partitions = "partitions",
    };
};
