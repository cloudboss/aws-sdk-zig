const AwsEc2SecurityGroupIpPermission = @import("aws_ec_2_security_group_ip_permission.zig").AwsEc2SecurityGroupIpPermission;

/// Details about an Amazon EC2 security group.
pub const AwsEc2SecurityGroupDetails = struct {
    /// The ID of the security group.
    group_id: ?[]const u8 = null,

    /// The name of the security group.
    group_name: ?[]const u8 = null,

    /// The inbound rules associated with the security group.
    ip_permissions: ?[]const AwsEc2SecurityGroupIpPermission = null,

    /// [VPC only] The outbound rules associated with the security group.
    ip_permissions_egress: ?[]const AwsEc2SecurityGroupIpPermission = null,

    /// The Amazon Web Services account ID of the owner of the security group.
    owner_id: ?[]const u8 = null,

    /// [VPC only] The ID of the VPC for the security group.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .group_id = "GroupId",
        .group_name = "GroupName",
        .ip_permissions = "IpPermissions",
        .ip_permissions_egress = "IpPermissionsEgress",
        .owner_id = "OwnerId",
        .vpc_id = "VpcId",
    };
};
