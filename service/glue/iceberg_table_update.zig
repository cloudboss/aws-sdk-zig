const aws = @import("aws");

const IcebergUpdateAction = @import("iceberg_update_action.zig").IcebergUpdateAction;
const IcebergEncryptedKey = @import("iceberg_encrypted_key.zig").IcebergEncryptedKey;
const IcebergPartitionSpec = @import("iceberg_partition_spec.zig").IcebergPartitionSpec;
const IcebergSchema = @import("iceberg_schema.zig").IcebergSchema;
const IcebergSortOrder = @import("iceberg_sort_order.zig").IcebergSortOrder;

/// Defines a complete set of updates to be applied to an Iceberg table,
/// including schema changes, partitioning modifications, sort order
/// adjustments, location updates, and property changes.
pub const IcebergTableUpdate = struct {
    /// The type of update action to be performed on the Iceberg table. Defines the
    /// specific operation such as adding schema, setting current schema, adding
    /// partition spec, or managing encryption keys.
    action: ?IcebergUpdateAction,

    /// Encryption key information associated with an Iceberg table update
    /// operation. Used when adding or removing encryption keys from the table
    /// metadata during table evolution.
    encryption_key: ?IcebergEncryptedKey,

    /// Identifier of the encryption key involved in an Iceberg table update
    /// operation. References the specific key being added to or removed from the
    /// table's encryption configuration.
    key_id: ?[]const u8,

    /// The updated S3 location where the Iceberg table data will be stored.
    location: []const u8,

    /// The updated partitioning specification that defines how the table data
    /// should be reorganized and partitioned.
    partition_spec: ?IcebergPartitionSpec,

    /// Updated key-value pairs of table properties and configuration settings for
    /// the Iceberg table.
    properties: ?[]const aws.map.StringMapEntry,

    /// The updated schema definition for the Iceberg table, specifying any changes
    /// to field structure, data types, or schema metadata.
    schema: IcebergSchema,

    /// The updated sort order specification that defines how data should be ordered
    /// within partitions for optimal query performance.
    sort_order: ?IcebergSortOrder,

    pub const json_field_names = .{
        .action = "Action",
        .encryption_key = "EncryptionKey",
        .key_id = "KeyId",
        .location = "Location",
        .partition_spec = "PartitionSpec",
        .properties = "Properties",
        .schema = "Schema",
        .sort_order = "SortOrder",
    };
};
