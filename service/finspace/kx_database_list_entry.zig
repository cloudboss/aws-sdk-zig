/// Details about a FinSpace managed kdb database
pub const KxDatabaseListEntry = struct {
    /// The timestamp at which the database was created in FinSpace. The value is
    /// determined as epoch time in milliseconds. For example, the value for Monday,
    /// November 1, 2021 12:00:00 PM UTC is specified as 1635768000000.
    created_timestamp: ?i64,

    /// The name of the kdb database.
    database_name: ?[]const u8,

    /// The last time that the database was modified. The value is determined as
    /// epoch time in milliseconds. For example, the value for Monday, November 1,
    /// 2021 12:00:00 PM UTC is specified as 1635768000000.
    last_modified_timestamp: ?i64,

    pub const json_field_names = .{
        .created_timestamp = "createdTimestamp",
        .database_name = "databaseName",
        .last_modified_timestamp = "lastModifiedTimestamp",
    };
};
