/// Replication direction designates if this is a failover replication, or a
/// failback replication. When a DRS agent is installed on an instance, the
/// replication direction is failover. In cases where a recovery launch was made
/// in the recovery location and a new recovery instance was created, and then a
/// failback replication was initiated from that recovery instance back to the
/// origin location, then the replication direction will be failback.
pub const ReplicationDirection = enum {
    failover,
    failback,

    pub const json_field_names = .{
        .failover = "FAILOVER",
        .failback = "FAILBACK",
    };
};
