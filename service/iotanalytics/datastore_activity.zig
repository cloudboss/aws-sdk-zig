/// The datastore activity that specifies where to store the processed data.
pub const DatastoreActivity = struct {
    /// The name of the data store where processed messages are stored.
    datastore_name: []const u8,

    /// The name of the datastore activity.
    name: []const u8,

    pub const json_field_names = .{
        .datastore_name = "datastoreName",
        .name = "name",
    };
};
