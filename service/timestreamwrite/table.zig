const MagneticStoreWriteProperties = @import("magnetic_store_write_properties.zig").MagneticStoreWriteProperties;
const RetentionProperties = @import("retention_properties.zig").RetentionProperties;
const Schema = @import("schema.zig").Schema;
const TableStatus = @import("table_status.zig").TableStatus;

/// Represents a database table in Timestream. Tables contain one or more
/// related
/// time series. You can modify the retention duration of the memory store and
/// the magnetic
/// store for a table.
pub const Table = struct {
    /// The Amazon Resource Name that uniquely identifies this table.
    arn: ?[]const u8 = null,

    /// The time when the Timestream table was created.
    creation_time: ?i64 = null,

    /// The name of the Timestream database that contains this table.
    database_name: ?[]const u8 = null,

    /// The time when the Timestream table was last updated.
    last_updated_time: ?i64 = null,

    /// Contains properties to set on the table when enabling magnetic store writes.
    magnetic_store_write_properties: ?MagneticStoreWriteProperties = null,

    /// The retention duration for the memory store and magnetic store.
    retention_properties: ?RetentionProperties = null,

    /// The schema of the table.
    schema: ?Schema = null,

    /// The name of the Timestream table.
    table_name: ?[]const u8 = null,

    /// The current state of the table:
    ///
    /// * `DELETING` - The table is being deleted.
    ///
    /// * `ACTIVE` - The table is ready for use.
    table_status: ?TableStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .database_name = "DatabaseName",
        .last_updated_time = "LastUpdatedTime",
        .magnetic_store_write_properties = "MagneticStoreWriteProperties",
        .retention_properties = "RetentionProperties",
        .schema = "Schema",
        .table_name = "TableName",
        .table_status = "TableStatus",
    };
};
