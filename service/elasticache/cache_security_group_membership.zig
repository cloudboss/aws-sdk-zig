/// Represents a cluster's status within a particular cache security group.
pub const CacheSecurityGroupMembership = struct {
    /// The name of the cache security group.
    cache_security_group_name: ?[]const u8 = null,

    /// The membership status in the cache security group. The status changes when a
    /// cache
    /// security group is modified, or when the cache security groups assigned to a
    /// cluster are
    /// modified.
    status: ?[]const u8 = null,
};
