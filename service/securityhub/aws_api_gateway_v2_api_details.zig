const AwsCorsConfiguration = @import("aws_cors_configuration.zig").AwsCorsConfiguration;

/// Contains information about a version 2 API in Amazon API Gateway.
pub const AwsApiGatewayV2ApiDetails = struct {
    /// The URI of the API.
    ///
    /// Uses the format
    /// `
    /// **.execute-api.**.amazonaws.com`
    ///
    /// The stage name is typically appended to the URI to form a complete path to a
    /// deployed
    /// API stage.
    api_endpoint: ?[]const u8,

    /// The identifier of the API.
    api_id: ?[]const u8,

    /// An API key selection expression. Supported only for WebSocket APIs.
    api_key_selection_expression: ?[]const u8,

    /// A cross-origin resource sharing (CORS) configuration. Supported only for
    /// HTTP
    /// APIs.
    cors_configuration: ?AwsCorsConfiguration,

    /// Indicates when the API was created.
    ///
    /// For more information about the validation and formatting of timestamp fields
    /// in Security Hub, see
    /// [Timestamps](https://docs.aws.amazon.com/securityhub/1.0/APIReference/Welcome.html#timestamps).
    created_date: ?[]const u8,

    /// A description of the API.
    description: ?[]const u8,

    /// The name of the API.
    name: ?[]const u8,

    /// The API protocol for the API.
    ///
    /// Valid values: `WEBSOCKET` | `HTTP`
    protocol_type: ?[]const u8,

    /// The route selection expression for the API.
    ///
    /// For HTTP APIs, must be `${request.method} ${request.path}`. This is the
    /// default value for HTTP APIs.
    ///
    /// For WebSocket APIs, there is no default value.
    route_selection_expression: ?[]const u8,

    /// The version identifier for the API.
    version: ?[]const u8,

    pub const json_field_names = .{
        .api_endpoint = "ApiEndpoint",
        .api_id = "ApiId",
        .api_key_selection_expression = "ApiKeySelectionExpression",
        .cors_configuration = "CorsConfiguration",
        .created_date = "CreatedDate",
        .description = "Description",
        .name = "Name",
        .protocol_type = "ProtocolType",
        .route_selection_expression = "RouteSelectionExpression",
        .version = "Version",
    };
};
