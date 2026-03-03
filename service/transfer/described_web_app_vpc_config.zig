/// Contains the VPC configuration details for a web app endpoint, including the
/// VPC identifier, subnet IDs, and VPC endpoint ID used for hosting the
/// endpoint.
pub const DescribedWebAppVpcConfig = struct {
    /// The list of subnet IDs within the VPC where the web app endpoint is
    /// deployed. These subnets must be in the same VPC and provide network
    /// connectivity for the endpoint.
    subnet_ids: ?[]const []const u8 = null,

    /// The identifier of the VPC endpoint created for the web app.
    vpc_endpoint_id: ?[]const u8 = null,

    /// The identifier of the VPC where the web app endpoint is hosted.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .subnet_ids = "SubnetIds",
        .vpc_endpoint_id = "VpcEndpointId",
        .vpc_id = "VpcId",
    };
};
