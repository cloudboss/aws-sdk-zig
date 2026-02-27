const DataLakeDatasetPartitionField = @import("data_lake_dataset_partition_field.zig").DataLakeDatasetPartitionField;

/// The partition specification for a dataset.
pub const DataLakeDatasetPartitionSpec = struct {
    /// The fields on which to partition a dataset. The partitions will be applied
    /// hierarchically based on the order of this list.
    fields: []const DataLakeDatasetPartitionField,

    pub const json_field_names = .{
        .fields = "fields",
    };
};
