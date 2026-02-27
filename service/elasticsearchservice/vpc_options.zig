/// Options to specify the subnets and security groups for VPC endpoint. For
/// more information, see [ VPC Endpoints for Amazon Elasticsearch Service
/// Domains](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-vpc.html).
pub const VPCOptions = struct {
    /// Specifies the security groups for VPC endpoint.
    security_group_ids: ?[]const []const u8,

    /// Specifies the subnets for VPC endpoint.
    subnet_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .security_group_ids = "SecurityGroupIds",
        .subnet_ids = "SubnetIds",
    };
};
