/// A relationship between a security group and a user.
pub const AwsEc2SecurityGroupUserIdGroupPair = struct {
    /// The ID of the security group.
    group_id: ?[]const u8,

    /// The name of the security group.
    group_name: ?[]const u8,

    /// The status of a VPC peering connection, if applicable.
    peering_status: ?[]const u8,

    /// The ID of an Amazon Web Services account.
    ///
    /// For a referenced security group in another VPC, the account ID of the
    /// referenced
    /// security group is returned in the response. If the referenced security group
    /// is deleted,
    /// this value is not returned.
    ///
    /// [EC2-Classic] Required when adding or removing rules that reference a
    /// security group in
    /// another VPC.
    user_id: ?[]const u8,

    /// The ID of the VPC for the referenced security group, if applicable.
    vpc_id: ?[]const u8,

    /// The ID of the VPC peering connection, if applicable.
    vpc_peering_connection_id: ?[]const u8,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .group_name = "GroupName",
        .peering_status = "PeeringStatus",
        .user_id = "UserId",
        .vpc_id = "VpcId",
        .vpc_peering_connection_id = "VpcPeeringConnectionId",
    };
};
