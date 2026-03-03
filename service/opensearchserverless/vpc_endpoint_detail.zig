const VpcEndpointStatus = @import("vpc_endpoint_status.zig").VpcEndpointStatus;

/// Details about an OpenSearch Serverless-managed interface endpoint.
pub const VpcEndpointDetail = struct {
    /// The date the endpoint was created.
    created_date: ?i64 = null,

    /// A failure code associated with the request.
    failure_code: ?[]const u8 = null,

    /// A message associated with the failure code.
    failure_message: ?[]const u8 = null,

    /// The unique identifier of the endpoint.
    id: ?[]const u8 = null,

    /// The name of the endpoint.
    name: ?[]const u8 = null,

    /// The unique identifiers of the security groups that define the ports,
    /// protocols, and sources for inbound traffic that you are authorizing into
    /// your endpoint.
    security_group_ids: ?[]const []const u8 = null,

    /// The current status of the endpoint.
    status: ?VpcEndpointStatus = null,

    /// The ID of the subnets from which you access OpenSearch Serverless.
    subnet_ids: ?[]const []const u8 = null,

    /// The ID of the VPC from which you access OpenSearch Serverless.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_date = "createdDate",
        .failure_code = "failureCode",
        .failure_message = "failureMessage",
        .id = "id",
        .name = "name",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_id = "vpcId",
    };
};
