const ApiGatewayEndpointType = @import("api_gateway_endpoint_type.zig").ApiGatewayEndpointType;

/// A wrapper object holding the Amazon API Gateway endpoint input.
pub const ApiGatewayProxyInput = struct {
    /// The type of endpoint to use for the API Gateway proxy. If no value is
    /// specified in
    /// the request, the value is set to `REGIONAL` by default.
    ///
    /// If the value is set to `PRIVATE` in the request, this creates a private API
    /// endpoint that is isolated from the public internet. The private endpoint can
    /// only be accessed
    /// by using Amazon Virtual Private Cloud (Amazon VPC) interface endpoints for
    /// the Amazon API Gateway that has been granted access.
    /// For more information about creating a private connection with Refactor
    /// Spaces and interface
    /// endpoint (Amazon Web Services PrivateLink) availability, see [Access
    /// Refactor Spaces using an interface endpoint (Amazon Web Services
    /// PrivateLink)](https://docs.aws.amazon.com/migrationhub-refactor-spaces/latest/userguide/vpc-interface-endpoints.html).
    endpoint_type: ?ApiGatewayEndpointType = null,

    /// The name of the API Gateway stage. The name defaults to `prod`.
    stage_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_type = "EndpointType",
        .stage_name = "StageName",
    };
};
