const DataLakeDatasetPartitionFieldTransform = @import("data_lake_dataset_partition_field_transform.zig").DataLakeDatasetPartitionFieldTransform;

/// The detail of the partition field.
pub const DataLakeDatasetPartitionField = struct {
    /// The name of the partition field.
    name: []const u8,

    /// The transformation of the partition field. A transformation specifies how to
    /// partition on a given field. For example, with timestamp you can specify that
    /// you'd like to partition fields by day, e.g. data record with value
    /// 2025-01-03T00:00:00Z in partition field is in 2025-01-03 partition. Also
    /// noted that data record without any value in optional partition field is in
    /// NULL partition.
    transform: DataLakeDatasetPartitionFieldTransform,

    pub const json_field_names = .{
        .name = "name",
        .transform = "transform",
    };
};
