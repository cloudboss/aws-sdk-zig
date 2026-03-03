const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;

/// List of summaries of data stores.
pub const DatastoreSummary = struct {
    /// The timestamp when the data store was created.
    created_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) for the data store.
    datastore_arn: ?[]const u8 = null,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The data store name.
    datastore_name: []const u8,

    /// The data store status.
    datastore_status: DatastoreStatus,

    /// The timestamp when the data store was last updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .datastore_arn = "datastoreArn",
        .datastore_id = "datastoreId",
        .datastore_name = "datastoreName",
        .datastore_status = "datastoreStatus",
        .updated_at = "updatedAt",
    };
};
