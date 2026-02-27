const KeyspaceStatus = @import("keyspace_status.zig").KeyspaceStatus;

/// This shows the summary status of the keyspace after a new Amazon Web
/// Services Region was added.
pub const ReplicationGroupStatus = struct {
    /// The status of the keyspace.
    keyspace_status: KeyspaceStatus,

    /// The name of the Region that was added to the keyspace.
    region: []const u8,

    /// This shows the replication progress of tables in the keyspace. The value is
    /// expressed as a percentage of the newly replicated tables with status
    /// `Active` compared to the total number of tables in the keyspace.
    tables_replication_progress: ?[]const u8,

    pub const json_field_names = .{
        .keyspace_status = "keyspaceStatus",
        .region = "region",
        .tables_replication_progress = "tablesReplicationProgress",
    };
};
