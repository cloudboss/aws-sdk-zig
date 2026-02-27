const Operation = @import("operation.zig").Operation;

/// An update operation for a record.
pub const RecordPatch = struct {
    /// The last modified date of the client
    /// device.
    device_last_modified_date: ?i64,

    /// The key associated with the record patch.
    key: []const u8,

    /// An operation, either replace or remove.
    op: Operation,

    /// Last known server sync count for this record. Set
    /// to 0 if unknown.
    sync_count: i64,

    /// The value associated with the record
    /// patch.
    value: ?[]const u8,

    pub const json_field_names = .{
        .device_last_modified_date = "DeviceLastModifiedDate",
        .key = "Key",
        .op = "Op",
        .sync_count = "SyncCount",
        .value = "Value",
    };
};
