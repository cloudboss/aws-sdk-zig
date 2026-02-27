const ApiGatewayEndpointType = @import("api_gateway_endpoint_type.zig").ApiGatewayEndpointType;

/// A wrapper object holding the Amazon API Gateway proxy configuration.
pub const ApiGatewayProxyConfig = struct {
    /// The resource ID of the API Gateway for the proxy.
    api_gateway_id: ?[]const u8,

    /// The type of API Gateway endpoint created.
    endpoint_type: ?ApiGatewayEndpointType,

    /// The Amazon Resource Name (ARN) of the Network Load Balancer configured by
    /// the API Gateway proxy.
    nlb_arn: ?[]const u8,

    /// The name of the Network Load Balancer that is configured by the API Gateway
    /// proxy.
    nlb_name: ?[]const u8,

    /// The endpoint URL of the API Gateway proxy.
    proxy_url: ?[]const u8,

    /// The name of the API Gateway stage. The name defaults to `prod`.
    stage_name: ?[]const u8,

    /// The `VpcLink` ID of the API Gateway proxy.
    vpc_link_id: ?[]const u8,

    pub const json_field_names = .{
        .api_gateway_id = "ApiGatewayId",
        .endpoint_type = "EndpointType",
        .nlb_arn = "NlbArn",
        .nlb_name = "NlbName",
        .proxy_url = "ProxyUrl",
        .stage_name = "StageName",
        .vpc_link_id = "VpcLinkId",
    };
};
