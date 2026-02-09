const GlobalTableStatus = @import("global_table_status.zig").GlobalTableStatus;
const ReplicaDescription = @import("replica_description.zig").ReplicaDescription;

/// Contains details about the global table.
pub const GlobalTableDescription = struct {
    /// The creation time of the global table.
    creation_date_time: ?i64,

    /// The unique identifier of the global table.
    global_table_arn: ?[]const u8,

    /// The global table name.
    global_table_name: ?[]const u8,

    /// The current state of the global table:
    ///
    /// * `CREATING` - The global table is being created.
    ///
    /// * `UPDATING` - The global table is being updated.
    ///
    /// * `DELETING` - The global table is being deleted.
    ///
    /// * `ACTIVE` - The global table is ready for use.
    global_table_status: ?GlobalTableStatus,

    /// The Regions where the global table has replicas.
    replication_group: ?[]const ReplicaDescription,
};
