/// The basic data structure of a dataset.
pub const Record = struct {
    /// The last modified date of the client
    /// device.
    device_last_modified_date: ?i64,

    /// The key for the record.
    key: ?[]const u8,

    /// The user/device that made the last change to this
    /// record.
    last_modified_by: ?[]const u8,

    /// The date on which the record was last
    /// modified.
    last_modified_date: ?i64,

    /// The server sync count for this record.
    sync_count: ?i64,

    /// The value for the record.
    value: ?[]const u8,

    pub const json_field_names = .{
        .device_last_modified_date = "DeviceLastModifiedDate",
        .key = "Key",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .sync_count = "SyncCount",
        .value = "Value",
    };
};
