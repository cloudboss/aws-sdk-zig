/// Options to specify the subnets and security groups for VPC endpoint. For
/// more information, see [ VPC Endpoints for Amazon Elasticsearch Service
/// Domains](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html).
pub const VPCDerivedInfo = struct {
    /// The availability zones for the Elasticsearch domain. Exists only if the
    /// domain was created with VPCOptions.
    availability_zones: ?[]const []const u8 = null,

    /// Specifies the security groups for VPC endpoint.
    security_group_ids: ?[]const []const u8 = null,

    /// Specifies the subnets for VPC endpoint.
    subnet_ids: ?[]const []const u8 = null,

    /// The VPC Id for the Elasticsearch domain. Exists only if the domain was
    /// created with VPCOptions.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
        .vpc_id = "VPCId",
    };
};
