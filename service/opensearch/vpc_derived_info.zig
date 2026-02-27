/// Information about the subnets and security groups for an Amazon OpenSearch
/// Service
/// domain provisioned within a virtual private cloud (VPC). For more
/// information, see
/// [Launching your Amazon OpenSearch Service domains using a
/// VPC](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/vpc.html). This
/// information only exists if the domain was created with `VPCOptions`.
pub const VPCDerivedInfo = struct {
    /// The list of Availability Zones associated with the VPC subnets.
    availability_zones: ?[]const []const u8,

    /// The list of security group IDs associated with the VPC endpoints for the
    /// domain.
    security_group_ids: ?[]const []const u8,

    /// A list of subnet IDs associated with the VPC endpoints for the domain.
    subnet_ids: ?[]const []const u8,

    /// The ID for your VPC. Amazon VPC generates this value when you create a VPC.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VPCId",
    };
};
