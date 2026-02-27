/// Describes the members of a VPC security group.
pub const VpcSecurityGroupMembership = struct {
    /// The status of the VPC security group.
    status: ?[]const u8,

    /// The unique identifier of the VPC security group.
    vpc_security_group_id: ?[]const u8,

    pub const json_field_names = .{
        .status = "status",
        .vpc_security_group_id = "vpcSecurityGroupId",
    };
};
