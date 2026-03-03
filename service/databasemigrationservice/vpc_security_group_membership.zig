/// Describes the status of a security group associated with the virtual private
/// cloud (VPC)
/// hosting your replication and DB instances.
pub const VpcSecurityGroupMembership = struct {
    /// The status of the VPC security group.
    status: ?[]const u8 = null,

    /// The VPC security group ID.
    vpc_security_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .status = "Status",
        .vpc_security_group_id = "VpcSecurityGroupId",
    };
};
