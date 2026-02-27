const ReplicationConfiguration = @import("replication_configuration.zig").ReplicationConfiguration;

pub const GetBucketReplicationResult = struct {
    /// A container for one or more replication rules. A replication configuration
    /// must have at
    /// least one rule and you can add up to 100 rules. The maximum size of a
    /// replication
    /// configuration is 128 KB.
    replication_configuration: ?ReplicationConfiguration,
};
