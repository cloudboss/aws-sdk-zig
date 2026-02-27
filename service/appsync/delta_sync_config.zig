/// Describes a Delta Sync configuration.
pub const DeltaSyncConfig = struct {
    /// The number of minutes that an Item is stored in the data source.
    base_table_ttl: i64 = 0,

    /// The Delta Sync table name.
    delta_sync_table_name: ?[]const u8,

    /// The number of minutes that a Delta Sync log entry is stored in the Delta
    /// Sync
    /// table.
    delta_sync_table_ttl: i64 = 0,

    pub const json_field_names = .{
        .base_table_ttl = "baseTableTTL",
        .delta_sync_table_name = "deltaSyncTableName",
        .delta_sync_table_ttl = "deltaSyncTableTTL",
    };
};
