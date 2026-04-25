const aws = @import("aws");

const IcebergPartitionSpec = @import("iceberg_partition_spec.zig").IcebergPartitionSpec;
const IcebergSchema = @import("iceberg_schema.zig").IcebergSchema;
const IcebergSchemaV2 = @import("iceberg_schema_v2.zig").IcebergSchemaV2;
const IcebergSortOrder = @import("iceberg_sort_order.zig").IcebergSortOrder;

/// Contains details about the metadata for an Iceberg table.
pub const IcebergMetadata = struct {
    /// The partition specification for the Iceberg table. Partitioning organizes
    /// data into separate files based on the values of one or more fields, which
    /// can improve query performance by reducing the amount of data scanned. Each
    /// partition field applies a transform (such as identity, year, month, or
    /// bucket) to a single field.
    partition_spec: ?IcebergPartitionSpec = null,

    /// A map of custom configuration properties for the Iceberg table.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// The schema for an Iceberg table. Use this property to define table schemas
    /// with primitive types only. For schemas that include nested or complex types
    /// such as `struct`, `list`, or `map`, use `schemaV2` instead.
    schema: ?IcebergSchema = null,

    /// The schema for an Iceberg table using the V2 format. Use this property to
    /// define table schemas that include nested or complex data types such as
    /// `struct`, `list`, or `map`, in addition to primitive types. For schemas with
    /// only primitive types, you can use either `schema` or `schemaV2`.
    schema_v2: ?IcebergSchemaV2 = null,

    /// The sort order for the Iceberg table. Sort order defines how data is sorted
    /// within data files, which can improve query performance by enabling more
    /// efficient data skipping and filtering.
    write_order: ?IcebergSortOrder = null,

    pub const json_field_names = .{
        .partition_spec = "partitionSpec",
        .properties = "properties",
        .schema = "schema",
        .schema_v2 = "schemaV2",
        .write_order = "writeOrder",
    };
};
