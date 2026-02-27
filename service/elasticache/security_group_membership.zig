/// Represents a single cache security group and its status.
pub const SecurityGroupMembership = struct {
    /// The identifier of the cache security group.
    security_group_id: ?[]const u8,

    /// The status of the cache security group membership. The status changes
    /// whenever a cache
    /// security group is modified, or when the cache security groups assigned to a
    /// cluster are
    /// modified.
    status: ?[]const u8,
};
