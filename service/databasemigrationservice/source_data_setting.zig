/// Defines settings for a source data provider for a data migration.
pub const SourceDataSetting = struct {
    /// The change data capture (CDC) start position for the source data provider.
    cdc_start_position: ?[]const u8,

    /// The change data capture (CDC) start time for the source data provider.
    cdc_start_time: ?i64,

    /// The change data capture (CDC) stop time for the source data provider.
    cdc_stop_time: ?i64,

    /// The name of the replication slot on the source data provider. This attribute
    /// is only
    /// valid for a PostgreSQL or Aurora PostgreSQL source.
    slot_name: ?[]const u8,

    pub const json_field_names = .{
        .cdc_start_position = "CDCStartPosition",
        .cdc_start_time = "CDCStartTime",
        .cdc_stop_time = "CDCStopTime",
        .slot_name = "SlotName",
    };
};
