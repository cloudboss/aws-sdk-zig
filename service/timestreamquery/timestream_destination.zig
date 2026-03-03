/// Destination for scheduled query.
pub const TimestreamDestination = struct {
    /// Timestream database name.
    database_name: ?[]const u8 = null,

    /// Timestream table name.
    table_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .database_name = "DatabaseName",
        .table_name = "TableName",
    };
};
