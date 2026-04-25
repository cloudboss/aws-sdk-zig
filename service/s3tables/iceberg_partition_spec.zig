const IcebergPartitionField = @import("iceberg_partition_field.zig").IcebergPartitionField;

/// Defines how data in an Iceberg table is partitioned. Partitioning helps
/// optimize query performance by organizing data into separate files based on
/// field values. Each partition field specifies a transform to apply to a
/// source field.
pub const IcebergPartitionSpec = struct {
    /// The list of partition fields that define how the table data is partitioned.
    /// Each field specifies a source field and a transform to apply. This field is
    /// required if `partitionSpec` is provided.
    fields: []const IcebergPartitionField,

    /// The unique identifier for this partition specification. If not specified,
    /// defaults to `0`.
    spec_id: ?i32 = null,

    pub const json_field_names = .{
        .fields = "fields",
        .spec_id = "specId",
    };
};
