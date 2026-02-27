const aws = @import("aws");

const StorageDescriptor = @import("storage_descriptor.zig").StorageDescriptor;

/// Represents a slice of table data.
pub const Partition = struct {
    /// The ID of the Data Catalog in which the partition resides.
    catalog_id: ?[]const u8,

    /// The time at which the partition was created.
    creation_time: ?i64,

    /// The name of the catalog database in which to create the partition.
    database_name: ?[]const u8,

    /// The last time at which the partition was accessed.
    last_access_time: ?i64,

    /// The last time at which column statistics were computed for this
    /// partition.
    last_analyzed_time: ?i64,

    /// These key-value pairs define partition parameters.
    parameters: ?[]const aws.map.StringMapEntry,

    /// Provides information about the physical
    /// location where the partition is stored.
    storage_descriptor: ?StorageDescriptor,

    /// The name of the database table in which to create the partition.
    table_name: ?[]const u8,

    /// The values of the partition.
    values: ?[]const []const u8,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .creation_time = "CreationTime",
        .database_name = "DatabaseName",
        .last_access_time = "LastAccessTime",
        .last_analyzed_time = "LastAnalyzedTime",
        .parameters = "Parameters",
        .storage_descriptor = "StorageDescriptor",
        .table_name = "TableName",
        .values = "Values",
    };
};
