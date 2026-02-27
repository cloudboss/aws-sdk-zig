const VpcEndpointStatus = @import("vpc_endpoint_status.zig").VpcEndpointStatus;
const VPCDerivedInfo = @import("vpc_derived_info.zig").VPCDerivedInfo;

/// The connection endpoint for connecting to an Amazon OpenSearch Service
/// domain through a
/// proxy.
pub const VpcEndpoint = struct {
    /// The Amazon Resource Name (ARN) of the domain associated with the endpoint.
    domain_arn: ?[]const u8,

    /// The connection endpoint ID for connecting to the domain.
    endpoint: ?[]const u8,

    /// The current status of the endpoint.
    status: ?VpcEndpointStatus,

    /// The unique identifier of the endpoint.
    vpc_endpoint_id: ?[]const u8,

    /// The creator of the endpoint.
    vpc_endpoint_owner: ?[]const u8,

    /// Options to specify the subnets and security groups for an Amazon OpenSearch
    /// Service VPC
    /// endpoint.
    vpc_options: ?VPCDerivedInfo,

    pub const json_field_names = .{
        .domain_arn = "DomainArn",
        .endpoint = "Endpoint",
        .status = "Status",
        .vpc_endpoint_id = "VpcEndpointId",
        .vpc_endpoint_owner = "VpcEndpointOwner",
        .vpc_options = "VpcOptions",
    };
};
