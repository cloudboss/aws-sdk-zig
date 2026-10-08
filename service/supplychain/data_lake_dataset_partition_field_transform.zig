const DataLakeDatasetPartitionTransformType = @import("data_lake_dataset_partition_transform_type.zig").DataLakeDatasetPartitionTransformType;

/// The detail of the partition field transformation.
pub const DataLakeDatasetPartitionFieldTransform = struct {
    /// The type of partitioning transformation for this field. The available
    /// options are:
    ///
    /// * **IDENTITY** - Partitions data on a given field by its exact values.
    ///
    /// * **YEAR** - Partitions data on a timestamp field using year granularity.
    ///
    /// * **MONTH** - Partitions data on a timestamp field using month granularity.
    ///
    /// * **DAY** - Partitions data on a timestamp field using day granularity.
    ///
    /// * **HOUR** - Partitions data on a timestamp field using hour granularity.
    type: DataLakeDatasetPartitionTransformType,

    pub const json_field_names = .{
        .type = "type",
    };
};
