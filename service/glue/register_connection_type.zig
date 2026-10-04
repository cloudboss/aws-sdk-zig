const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionPropertiesConfiguration = @import("connection_properties_configuration.zig").ConnectionPropertiesConfiguration;
const ConnectorAuthenticationConfiguration = @import("connector_authentication_configuration.zig").ConnectorAuthenticationConfiguration;
const IntegrationType = @import("integration_type.zig").IntegrationType;
const RestConfiguration = @import("rest_configuration.zig").RestConfiguration;

pub const RegisterConnectionTypeInput = struct {
    /// Defines the base URL and additional request parameters needed during
    /// connection creation for this connection type.
    connection_properties: ConnectionPropertiesConfiguration,

    /// The name of the connection type. Must be between 1 and 255 characters and
    /// must be prefixed with "REST-" to indicate it is a REST-based connector.
    connection_type: []const u8,

    /// Defines the supported authentication types and required properties for this
    /// connection type, including Basic, OAuth2, and Custom authentication methods.
    connector_authentication_configuration: ConnectorAuthenticationConfiguration,

    /// A description of the connection type. Can be up to 2048 characters and
    /// provides details about the purpose and functionality of the connection type.
    description: ?[]const u8 = null,

    /// The integration type for the connection. Currently only "REST" protocol is
    /// supported.
    integration_type: IntegrationType,

    /// Defines the HTTP request and response configuration, validation endpoint,
    /// and entity configurations for REST API interactions.
    rest_configuration: RestConfiguration,

    /// The tags you assign to the connection type.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .connection_properties = "ConnectionProperties",
        .connection_type = "ConnectionType",
        .connector_authentication_configuration = "ConnectorAuthenticationConfiguration",
        .description = "Description",
        .integration_type = "IntegrationType",
        .rest_configuration = "RestConfiguration",
        .tags = "Tags",
    };
};

pub const RegisterConnectionTypeOutput = struct {
    /// The Amazon Resource Name (ARN) of the registered connection type. This
    /// unique identifier can be used to reference the connection type in other Glue
    /// operations.
    connection_type_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .connection_type_arn = "ConnectionTypeArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterConnectionTypeInput, options: CallOptions) !RegisterConnectionTypeOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterConnectionTypeInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.RegisterConnectionType");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterConnectionTypeOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterConnectionTypeOutput, body, allocator);
}
