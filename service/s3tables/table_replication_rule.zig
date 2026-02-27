const ReplicationDestination = @import("replication_destination.zig").ReplicationDestination;

/// Defines a rule for replicating a table to one or more destination tables.
pub const TableReplicationRule = struct {
    /// An array of destination table buckets where this table should be replicated.
    destinations: []const ReplicationDestination,

    pub const json_field_names = .{
        .destinations = "destinations",
    };
};
