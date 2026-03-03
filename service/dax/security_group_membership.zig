/// An individual VPC security group and its status.
pub const SecurityGroupMembership = struct {
    /// The unique ID for this security group.
    security_group_identifier: ?[]const u8 = null,

    /// The status of this security group.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .security_group_identifier = "SecurityGroupIdentifier",
        .status = "Status",
    };
};
