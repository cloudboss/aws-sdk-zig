/// Contains information that OpenSearch Service derives based on the
/// `VPCOptions` for the domain.
pub const AwsOpenSearchServiceDomainVpcOptionsDetails = struct {
    /// The list of security group IDs that are associated with the VPC endpoints
    /// for the domain.
    security_group_ids: ?[]const []const u8,

    /// A list of subnet IDs that are associated with the VPC endpoints for the
    /// domain.
    subnet_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
