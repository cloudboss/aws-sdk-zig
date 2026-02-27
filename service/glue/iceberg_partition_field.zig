/// Defines a single partition field within an Iceberg partition specification,
/// including the source field, transformation function, partition name,
/// and unique identifier.
pub const IcebergPartitionField = struct {
    /// The unique identifier assigned to this partition field within the Iceberg
    /// table's partition specification.
    field_id: i32 = 0,

    /// The name of the partition field as it will appear in the partitioned table
    /// structure.
    name: []const u8,

    /// The identifier of the source field from the table schema that this partition
    /// field is based on.
    source_id: i32 = 0,

    /// The transformation function applied to the source field to create the
    /// partition, such as identity, bucket, truncate, year, month, day, or hour.
    transform: []const u8,

    pub const json_field_names = .{
        .field_id = "FieldId",
        .name = "Name",
        .source_id = "SourceId",
        .transform = "Transform",
    };
};
