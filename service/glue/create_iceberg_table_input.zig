const aws = @import("aws");

const IcebergPartitionSpec = @import("iceberg_partition_spec.zig").IcebergPartitionSpec;
const IcebergSchema = @import("iceberg_schema.zig").IcebergSchema;
const IcebergSortOrder = @import("iceberg_sort_order.zig").IcebergSortOrder;

/// The configuration parameters required to create a new Iceberg table in the
/// Glue Data Catalog,
/// including table properties and metadata specifications.
pub const CreateIcebergTableInput = struct {
    /// The S3 location where the Iceberg table data will be stored.
    location: []const u8,

    /// The partitioning specification that defines how the Iceberg table data will
    /// be organized and partitioned for optimal query performance.
    partition_spec: ?IcebergPartitionSpec,

    /// Key-value pairs of additional table properties and configuration settings
    /// for the Iceberg table.
    properties: ?[]const aws.map.StringMapEntry,

    /// The schema definition that specifies the structure, field types, and
    /// metadata for the Iceberg table.
    schema: IcebergSchema,

    /// The sort order specification that defines how data should be ordered within
    /// each partition to optimize query performance.
    write_order: ?IcebergSortOrder,

    pub const json_field_names = .{
        .location = "Location",
        .partition_spec = "PartitionSpec",
        .properties = "Properties",
        .schema = "Schema",
        .write_order = "WriteOrder",
    };
};
