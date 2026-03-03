/// Information that OpenSearch derives based on `VPCOptions` for the
/// domain.
pub const AwsElasticsearchDomainVPCOptions = struct {
    /// The list of Availability Zones associated with the VPC subnets.
    availability_zones: ?[]const []const u8 = null,

    /// The list of security group IDs associated with the VPC endpoints for the
    /// domain.
    security_group_ids: ?[]const []const u8 = null,

    /// A list of subnet IDs associated with the VPC endpoints for the domain.
    subnet_ids: ?[]const []const u8 = null,

    /// ID for the VPC.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VPCId",
    };
};
