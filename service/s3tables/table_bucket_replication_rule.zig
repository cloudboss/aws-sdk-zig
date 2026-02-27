const ReplicationDestination = @import("replication_destination.zig").ReplicationDestination;

/// Defines a rule for replicating tables from a source table bucket to one or
/// more destination table buckets.
pub const TableBucketReplicationRule = struct {
    /// An array of destination table buckets where tables should be replicated.
    destinations: []const ReplicationDestination,

    pub const json_field_names = .{
        .destinations = "destinations",
    };
};
