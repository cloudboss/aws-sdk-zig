/// Contains information about the endpoints for the API.
pub const AwsApiGatewayEndpointConfiguration = struct {
    /// A list of endpoint types for the REST API.
    ///
    /// For an edge-optimized API, the endpoint type is `EDGE`. For a Regional API,
    /// the endpoint type is `REGIONAL`. For a private API, the endpoint type is
    /// `PRIVATE`.
    types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .types = "Types",
    };
};
