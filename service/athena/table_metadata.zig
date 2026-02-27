const aws = @import("aws");

const Column = @import("column.zig").Column;

/// Contains metadata for a table.
pub const TableMetadata = struct {
    /// A list of the columns in the table.
    columns: ?[]const Column,

    /// The time that the table was created.
    create_time: ?i64,

    /// The last time the table was accessed.
    last_access_time: ?i64,

    /// The name of the table.
    name: []const u8,

    /// A set of custom key/value pairs for table properties.
    parameters: ?[]const aws.map.StringMapEntry,

    /// A list of the partition keys in the table.
    partition_keys: ?[]const Column,

    /// The type of table. In Athena, only `EXTERNAL_TABLE` is
    /// supported.
    table_type: ?[]const u8,

    pub const json_field_names = .{
        .columns = "Columns",
        .create_time = "CreateTime",
        .last_access_time = "LastAccessTime",
        .name = "Name",
        .parameters = "Parameters",
        .partition_keys = "PartitionKeys",
        .table_type = "TableType",
    };
};
