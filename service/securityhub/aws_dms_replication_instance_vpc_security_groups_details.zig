/// Provides details about the virtual private cloud (VPC) security group that’s
/// associated with the replication instance.
pub const AwsDmsReplicationInstanceVpcSecurityGroupsDetails = struct {
    /// The identifier of the VPC security group that’s associated with the
    /// replication instance.
    vpc_security_group_id: ?[]const u8,

    pub const json_field_names = .{
        .vpc_security_group_id = "VpcSecurityGroupId",
    };
};
