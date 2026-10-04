const aws = @import("aws");

const IcebergPartitionSpec = @import("iceberg_partition_spec.zig").IcebergPartitionSpec;
const IcebergSchema = @import("iceberg_schema.zig").IcebergSchema;
const IcebergSortOrder = @import("iceberg_sort_order.zig").IcebergSortOrder;

/// The Apache Iceberg table metadata, including format version, table
/// identifier, schemas, partition specifications, sort orders, and table
/// properties. This structure captures the current state of an Iceberg table's
/// metadata as managed by the Glue Data Catalog.
pub const IcebergTableMetadata = struct {
    /// The identifier of the schema that is currently active for the Iceberg table.
    /// Matches an entry in `Schemas`.
    current_schema_id: i32 = 0,

    /// The identifier of the sort order that is currently used by default when
    /// writing new data to the Iceberg table.
    default_sort_order_id: i32 = 0,

    /// The identifier of the partition specification that is currently used by
    /// default when writing new data to the Iceberg table.
    default_spec_id: i32 = 0,

    /// The Apache Iceberg table format version, such as `1` or `2`. Determines the
    /// set of features and on-disk layout supported by the table.
    format_version: ?[]const u8 = null,

    /// The highest column identifier that has been assigned in the Iceberg table's
    /// schema, used to ensure unique IDs as new columns are added.
    last_column_id: i32 = 0,

    /// The highest partition field identifier that has been assigned across the
    /// table's partition specifications.
    last_partition_id: i32 = 0,

    /// The base S3 location where the Iceberg table's data and metadata files are
    /// stored.
    location: ?[]const u8 = null,

    /// The list of partition specifications that have been associated with the
    /// Iceberg table over its history, supporting partition evolution.
    partition_specs: ?[]const IcebergPartitionSpec = null,

    /// A map of key-value pairs that define table-level properties and
    /// configuration settings for the Iceberg table.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// The list of schemas that have been associated with the Iceberg table over
    /// its history, supporting schema evolution.
    schemas: ?[]const IcebergSchema = null,

    /// The list of sort order specifications that have been associated with the
    /// Iceberg table over its history.
    sort_orders: ?[]const IcebergSortOrder = null,

    /// The unique identifier (UUID) for the Iceberg table, assigned when the table
    /// is created and used to track the table across metadata updates.
    table_uuid: ?[]const u8 = null,

    pub const json_field_names = .{
        .current_schema_id = "CurrentSchemaId",
        .default_sort_order_id = "DefaultSortOrderId",
        .default_spec_id = "DefaultSpecId",
        .format_version = "FormatVersion",
        .last_column_id = "LastColumnId",
        .last_partition_id = "LastPartitionId",
        .location = "Location",
        .partition_specs = "PartitionSpecs",
        .properties = "Properties",
        .schemas = "Schemas",
        .sort_orders = "SortOrders",
        .table_uuid = "TableUuid",
    };
};
