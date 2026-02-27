const ApiGatewayTargetConfiguration = @import("api_gateway_target_configuration.zig").ApiGatewayTargetConfiguration;
const McpLambdaTargetConfiguration = @import("mcp_lambda_target_configuration.zig").McpLambdaTargetConfiguration;
const McpServerTargetConfiguration = @import("mcp_server_target_configuration.zig").McpServerTargetConfiguration;
const ApiSchemaConfiguration = @import("api_schema_configuration.zig").ApiSchemaConfiguration;

/// The Model Context Protocol (MCP) configuration for a target. This structure
/// defines how the gateway uses MCP to communicate with the target.
pub const McpTargetConfiguration = union(enum) {
    /// The configuration for an Amazon API Gateway target.
    api_gateway: ?ApiGatewayTargetConfiguration,
    /// The Lambda configuration for the Model Context Protocol target. This
    /// configuration defines how the gateway uses a Lambda function to communicate
    /// with the target.
    lambda: ?McpLambdaTargetConfiguration,
    /// The MCP server specified as the gateway target.
    mcp_server: ?McpServerTargetConfiguration,
    /// The OpenAPI schema for the Model Context Protocol target. This schema
    /// defines the API structure of the target.
    open_api_schema: ?ApiSchemaConfiguration,
    /// The Smithy model for the Model Context Protocol target. This model defines
    /// the API structure of the target using the Smithy specification.
    smithy_model: ?ApiSchemaConfiguration,

    pub const json_field_names = .{
        .api_gateway = "apiGateway",
        .lambda = "lambda",
        .mcp_server = "mcpServer",
        .open_api_schema = "openApiSchema",
        .smithy_model = "smithyModel",
    };
};
