/// Defines a single partition field in an Iceberg partition specification.
pub const IcebergPartitionField = struct {
    /// An optional unique identifier for this partition field. If not specified, S3
    /// Tables automatically assigns a field ID.
    field_id: ?i32 = null,

    /// The name for this partition field. This name is used in the partitioned file
    /// paths.
    name: []const u8,

    /// The ID of the source schema field to partition by. This must reference a
    /// valid field ID from the table schema.
    source_id: i32,

    /// The partition transform to apply to the source field. Supported transforms
    /// include `identity`, `year`, `month`, `day`, `hour`, `bucket`, and
    /// `truncate`. For more information, see the [Apache Iceberg partition
    /// transforms
    /// documentation](https://iceberg.apache.org/spec/#partition-transforms).
    transform: []const u8,

    pub const json_field_names = .{
        .field_id = "fieldId",
        .name = "name",
        .source_id = "sourceId",
        .transform = "transform",
    };
};
