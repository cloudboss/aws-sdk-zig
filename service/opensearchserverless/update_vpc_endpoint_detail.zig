const VpcEndpointStatus = @import("vpc_endpoint_status.zig").VpcEndpointStatus;

/// Update details for an OpenSearch Serverless-managed interface endpoint.
pub const UpdateVpcEndpointDetail = struct {
    /// The unique identifier of the endpoint.
    id: ?[]const u8 = null,

    /// The timestamp of when the endpoint was last modified.
    last_modified_date: ?i64 = null,

    /// The name of the endpoint.
    name: ?[]const u8 = null,

    /// The unique identifiers of the security groups that define the ports,
    /// protocols, and sources for inbound traffic that you are authorizing into
    /// your endpoint.
    security_group_ids: ?[]const []const u8 = null,

    /// The current status of the endpoint update process.
    status: ?VpcEndpointStatus = null,

    /// The ID of the subnets from which you access OpenSearch Serverless.
    subnet_ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .id = "id",
        .last_modified_date = "lastModifiedDate",
        .name = "name",
        .security_group_ids = "securityGroupIds",
        .status = "status",
        .subnet_ids = "subnetIds",
    };
};
