const VpcEndpointStatus = @import("vpc_endpoint_status.zig").VpcEndpointStatus;

/// Summary information for an Amazon OpenSearch Service-managed VPC endpoint.
pub const VpcEndpointSummary = struct {
    /// The Amazon Resource Name (ARN) of the domain associated with the endpoint.
    domain_arn: ?[]const u8,

    /// The current status of the endpoint.
    status: ?VpcEndpointStatus,

    /// The unique identifier of the endpoint.
    vpc_endpoint_id: ?[]const u8,

    /// The creator of the endpoint.
    vpc_endpoint_owner: ?[]const u8,

    pub const json_field_names = .{
        .domain_arn = "DomainArn",
        .status = "Status",
        .vpc_endpoint_id = "VpcEndpointId",
        .vpc_endpoint_owner = "VpcEndpointOwner",
    };
};
