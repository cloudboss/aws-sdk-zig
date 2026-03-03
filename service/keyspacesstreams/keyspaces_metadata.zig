/// Contains metadata information associated with Amazon Keyspaces cells and
/// rows.
pub const KeyspacesMetadata = struct {
    /// The time at which the associated data will expire, based on the time-to-live
    /// (TTL) setting.
    expiration_time: ?[]const u8 = null,

    /// The timestamp at which the associated data was written to the database.
    write_time: ?[]const u8 = null,

    pub const json_field_names = .{
        .expiration_time = "expirationTime",
        .write_time = "writeTime",
    };
};
