const DatastoreStatus = @import("datastore_status.zig").DatastoreStatus;

/// The filters applied to a data store query.
pub const DatastoreFilter = struct {
    /// Filter to set cutoff dates for records. All data stores created after the
    /// specified date
    /// are included in the results.
    created_after: ?i64 = null,

    /// Filter to set cutoff dates for records. All data stores created before the
    /// specified
    /// date are included in the results.
    created_before: ?i64 = null,

    /// Filter data store results by name.
    datastore_name: ?[]const u8 = null,

    /// Filter data store results by status.
    datastore_status: ?DatastoreStatus = null,

    pub const json_field_names = .{
        .created_after = "CreatedAfter",
        .created_before = "CreatedBefore",
        .datastore_name = "DatastoreName",
        .datastore_status = "DatastoreStatus",
    };
};
