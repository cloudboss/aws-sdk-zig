/// If this canary is to test an endpoint in a VPC, this structure contains
/// information about the subnets and security groups of the VPC endpoint.
/// For more information, see [
/// Running a Canary in a
/// VPC](https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch_Synthetics_Canaries_VPC.html).
pub const VpcConfigOutput = struct {
    /// Indicates whether this canary allows outbound IPv6 traffic if it is
    /// connected to dual-stack subnets.
    ipv_6_allowed_for_dual_stack: ?bool = null,

    /// The IDs of the security groups for this canary.
    security_group_ids: ?[]const []const u8 = null,

    /// The IDs of the subnets where this canary is to run.
    subnet_ids: ?[]const []const u8 = null,

    /// The IDs of the VPC where this canary is to run.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ipv_6_allowed_for_dual_stack = "Ipv6AllowedForDualStack",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VpcId",
    };
};
