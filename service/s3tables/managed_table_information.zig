const ReplicationInformation = @import("replication_information.zig").ReplicationInformation;

/// Contains information about tables that are managed by S3 Tables, including
/// replication information for replica tables.
pub const ManagedTableInformation = struct {
    /// If this table is a replica, contains information about the source table from
    /// which it is replicated.
    replication_information: ?ReplicationInformation,

    pub const json_field_names = .{
        .replication_information = "replicationInformation",
    };
};
