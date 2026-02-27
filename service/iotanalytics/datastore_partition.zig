const Partition = @import("partition.zig").Partition;
const TimestampPartition = @import("timestamp_partition.zig").TimestampPartition;

/// A single dimension to partition a data store. The dimension must be an
/// `AttributePartition` or a `TimestampPartition`.
pub const DatastorePartition = struct {
    /// A partition dimension defined by an `attributeName`.
    attribute_partition: ?Partition,

    /// A partition dimension defined by a timestamp attribute.
    timestamp_partition: ?TimestampPartition,

    pub const json_field_names = .{
        .attribute_partition = "attributePartition",
        .timestamp_partition = "timestampPartition",
    };
};
