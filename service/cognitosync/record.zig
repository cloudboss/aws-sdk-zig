/// The basic data structure of a dataset.
pub const Record = struct {
    /// The last modified date of the client
    /// device.
    device_last_modified_date: ?i64 = null,

    /// The key for the record.
    key: ?[]const u8 = null,

    /// The user/device that made the last change to this
    /// record.
    last_modified_by: ?[]const u8 = null,

    /// The date on which the record was last
    /// modified.
    last_modified_date: ?i64 = null,

    /// The server sync count for this record.
    sync_count: ?i64 = null,

    /// The value for the record.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .device_last_modified_date = "DeviceLastModifiedDate",
        .key = "Key",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .sync_count = "SyncCount",
        .value = "Value",
    };
};
