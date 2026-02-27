const AutomaticFailoverStatus = @import("automatic_failover_status.zig").AutomaticFailoverStatus;

/// A member of a Global datastore. It contains the Replication Group Id, the
/// Amazon
/// region and the role of the replication group.
pub const GlobalReplicationGroupMember = struct {
    /// Indicates whether automatic failover is enabled for the replication group.
    automatic_failover: ?AutomaticFailoverStatus,

    /// The replication group id of the Global datastore member.
    replication_group_id: ?[]const u8,

    /// The Amazon region of the Global datastore member.
    replication_group_region: ?[]const u8,

    /// Indicates the role of the replication group, primary or secondary.
    role: ?[]const u8,

    /// The status of the membership of the replication group.
    status: ?[]const u8,
};
