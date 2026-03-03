/// Represents a single security group and its status.
pub const SecurityGroupMembership = struct {
    /// The identifier of the security group.
    security_group_id: ?[]const u8 = null,

    /// The status of the security group membership. The status changes whenever a
    /// security group is modified, or when the security groups assigned to a
    /// cluster are modified.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .security_group_id = "SecurityGroupId",
        .status = "Status",
    };
};
