/// The VPC security groups and subnets that are attached to a Lambda function.
pub const VpcConfigResponse = struct {
    /// Allows outbound IPv6 traffic on VPC functions that are connected to
    /// dual-stack subnets.
    ipv_6_allowed_for_dual_stack: ?bool,

    /// A list of VPC security group IDs.
    security_group_ids: ?[]const []const u8,

    /// A list of VPC subnet IDs.
    subnet_ids: ?[]const []const u8,

    /// The ID of the VPC.
    vpc_id: ?[]const u8,
};
