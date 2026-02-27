const aws = @import("aws");

const Cors = @import("cors.zig").Cors;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const ProtocolType = @import("protocol_type.zig").ProtocolType;

/// Represents an API.
pub const Api = struct {
    /// The URI of the API, of the form {api-id}.execute-api.{region}.amazonaws.com.
    /// The stage name is typically appended to this URI to form a complete path to
    /// a deployed API stage.
    api_endpoint: ?[]const u8,

    /// Specifies whether an API is managed by API Gateway. You can't update or
    /// delete a managed API by using API Gateway. A managed API can be deleted only
    /// through the tooling or service that created it.
    api_gateway_managed: ?bool,

    /// The API ID.
    api_id: ?[]const u8,

    /// An API key selection expression. Supported only for WebSocket APIs. See [API
    /// Key Selection
    /// Expressions](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-apikey-selection-expressions).
    api_key_selection_expression: ?[]const u8,

    /// A CORS configuration. Supported only for HTTP APIs.
    cors_configuration: ?Cors,

    /// The timestamp when the API was created.
    created_date: ?i64,

    /// The description of the API.
    description: ?[]const u8,

    /// Specifies whether clients can invoke your API by using the default
    /// execute-api endpoint. By default, clients can invoke your API with the
    /// default https://{api_id}.execute-api.{region}.amazonaws.com endpoint. To
    /// require that clients use a custom domain name to invoke your API, disable
    /// the default endpoint.
    disable_execute_api_endpoint: ?bool,

    /// Avoid validating models when creating a deployment. Supported only for
    /// WebSocket APIs.
    disable_schema_validation: ?bool,

    /// The validation information during API import. This may include particular
    /// properties of your OpenAPI definition which are ignored during import.
    /// Supported only for HTTP APIs.
    import_info: ?[]const []const u8,

    /// The IP address types that can invoke the API.
    ip_address_type: ?IpAddressType,

    /// The name of the API.
    name: []const u8,

    /// The API protocol.
    protocol_type: ProtocolType,

    /// The route selection expression for the API. For HTTP APIs, the
    /// routeSelectionExpression must be ${request.method} ${request.path}. If not
    /// provided, this will be the default for HTTP APIs. This property is required
    /// for WebSocket APIs.
    route_selection_expression: []const u8,

    /// A collection of tags associated with the API.
    tags: ?[]const aws.map.StringMapEntry,

    /// A version identifier for the API.
    version: ?[]const u8,

    /// The warning messages reported when failonwarnings is turned on during API
    /// import.
    warnings: ?[]const []const u8,

    pub const json_field_names = .{
        .api_endpoint = "ApiEndpoint",
        .api_gateway_managed = "ApiGatewayManaged",
        .api_id = "ApiId",
        .api_key_selection_expression = "ApiKeySelectionExpression",
        .cors_configuration = "CorsConfiguration",
        .created_date = "CreatedDate",
        .description = "Description",
        .disable_execute_api_endpoint = "DisableExecuteApiEndpoint",
        .disable_schema_validation = "DisableSchemaValidation",
        .import_info = "ImportInfo",
        .ip_address_type = "IpAddressType",
        .name = "Name",
        .protocol_type = "ProtocolType",
        .route_selection_expression = "RouteSelectionExpression",
        .tags = "Tags",
        .version = "Version",
        .warnings = "Warnings",
    };
};
