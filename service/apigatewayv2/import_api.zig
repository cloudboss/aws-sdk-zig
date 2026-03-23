const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const Cors = @import("cors.zig").Cors;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const ProtocolType = @import("protocol_type.zig").ProtocolType;

pub const ImportApiInput = struct {
    /// Specifies how to interpret the base path of the API during import. Valid
    /// values are ignore, prepend, and split. The default value is ignore. To learn
    /// more, see [Set the OpenAPI basePath
    /// Property](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-import-api-basePath.html). Supported only for HTTP APIs.
    basepath: ?[]const u8 = null,

    /// The OpenAPI definition. Supported only for HTTP APIs.
    body: []const u8,

    /// Specifies whether to rollback the API creation when a warning is
    /// encountered. By default, API creation continues if a warning is encountered.
    fail_on_warnings: ?bool = null,

    pub const json_field_names = .{
        .basepath = "Basepath",
        .body = "Body",
        .fail_on_warnings = "FailOnWarnings",
    };
};

pub const ImportApiOutput = struct {
    /// The URI of the API, of the form {api-id}.execute-api.{region}.amazonaws.com.
    /// The stage name is typically appended to this URI to form a complete path to
    /// a deployed API stage.
    api_endpoint: ?[]const u8 = null,

    /// Specifies whether an API is managed by API Gateway. You can't update or
    /// delete a managed API by using API Gateway. A managed API can be deleted only
    /// through the tooling or service that created it.
    api_gateway_managed: ?bool = null,

    /// The API ID.
    api_id: ?[]const u8 = null,

    /// An API key selection expression. Supported only for WebSocket APIs. See [API
    /// Key Selection
    /// Expressions](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-apikey-selection-expressions).
    api_key_selection_expression: ?[]const u8 = null,

    /// A CORS configuration. Supported only for HTTP APIs.
    cors_configuration: ?Cors = null,

    /// The timestamp when the API was created.
    created_date: ?i64 = null,

    /// The description of the API.
    description: ?[]const u8 = null,

    /// Specifies whether clients can invoke your API by using the default
    /// execute-api endpoint. By default, clients can invoke your API with the
    /// default https://{api_id}.execute-api.{region}.amazonaws.com endpoint. To
    /// require that clients use a custom domain name to invoke your API, disable
    /// the default endpoint.
    disable_execute_api_endpoint: ?bool = null,

    /// Avoid validating models when creating a deployment. Supported only for
    /// WebSocket APIs.
    disable_schema_validation: ?bool = null,

    /// The validation information during API import. This may include particular
    /// properties of your OpenAPI definition which are ignored during import.
    /// Supported only for HTTP APIs.
    import_info: ?[]const []const u8 = null,

    /// The IP address types that can invoke the API.
    ip_address_type: ?IpAddressType = null,

    /// The name of the API.
    name: ?[]const u8 = null,

    /// The API protocol.
    protocol_type: ?ProtocolType = null,

    /// The route selection expression for the API. For HTTP APIs, the
    /// routeSelectionExpression must be ${request.method} ${request.path}. If not
    /// provided, this will be the default for HTTP APIs. This property is required
    /// for WebSocket APIs.
    route_selection_expression: ?[]const u8 = null,

    /// A collection of tags associated with the API.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A version identifier for the API.
    version: ?[]const u8 = null,

    /// The warning messages reported when failonwarnings is turned on during API
    /// import.
    warnings: ?[]const []const u8 = null,

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportApiInput, options: CallOptions) !ImportApiOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigateway");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ImportApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "ApiGatewayV2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v2/apis";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (input.basepath) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "basepath=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.fail_on_warnings) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "failOnWarnings=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Body\":");
    try aws.json.writeValue(@TypeOf(input.body), input.body, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportApiOutput {
    var result: ImportApiOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ImportApiOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotFoundException")) {
        return .{ .arena = arena, .kind = .{ .not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyRequestsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_requests_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
