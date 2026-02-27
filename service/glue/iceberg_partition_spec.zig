const IcebergPartitionField = @import("iceberg_partition_field.zig").IcebergPartitionField;

/// Defines the partitioning specification for an Iceberg table, determining how
/// table data will be organized and partitioned for optimal query performance.
pub const IcebergPartitionSpec = struct {
    /// The list of partition fields that define how the table data should be
    /// partitioned, including source fields and their transformations.
    fields: []const IcebergPartitionField,

    /// The unique identifier for this partition specification within the Iceberg
    /// table's metadata history.
    spec_id: i32 = 0,

    pub const json_field_names = .{
        .fields = "Fields",
        .spec_id = "SpecId",
    };
};
