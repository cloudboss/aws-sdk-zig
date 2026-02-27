const ApiGatewayToolConfiguration = @import("api_gateway_tool_configuration.zig").ApiGatewayToolConfiguration;

/// The configuration for an Amazon API Gateway target.
pub const ApiGatewayTargetConfiguration = struct {
    /// The configuration for defining REST API tool filters and overrides for the
    /// gateway target.
    api_gateway_tool_configuration: ApiGatewayToolConfiguration,

    /// The ID of the API Gateway REST API.
    rest_api_id: []const u8,

    /// The ID of the stage of the REST API to add as a target.
    stage: []const u8,

    pub const json_field_names = .{
        .api_gateway_tool_configuration = "apiGatewayToolConfiguration",
        .rest_api_id = "restApiId",
        .stage = "stage",
    };
};
