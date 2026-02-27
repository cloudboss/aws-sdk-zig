const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Cors = @import("cors.zig").Cors;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const ProtocolType = @import("protocol_type.zig").ProtocolType;

pub const CreateApiInput = struct {
    /// An API key selection expression. Supported only for WebSocket APIs. See [API
    /// Key Selection
    /// Expressions](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-apikey-selection-expressions).
    api_key_selection_expression: ?[]const u8 = null,

    /// A CORS configuration. Supported only for HTTP APIs. See [Configuring
    /// CORS](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-cors.html) for more information.
    cors_configuration: ?Cors = null,

    /// This property is part of quick create. It specifies the credentials required
    /// for the integration, if any. For a Lambda integration, three options are
    /// available. To specify an IAM Role for API Gateway to assume, use the role's
    /// Amazon Resource Name (ARN). To require that the caller's identity be passed
    /// through from the request, specify arn:aws:iam::*:user/*. To use
    /// resource-based permissions on supported AWS services, specify null.
    /// Currently, this property is not used for HTTP integrations. Supported only
    /// for HTTP APIs.
    credentials_arn: ?[]const u8 = null,

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

    /// The IP address types that can invoke the API.
    ip_address_type: ?IpAddressType = null,

    /// The name of the API.
    name: []const u8,

    /// The API protocol.
    protocol_type: ProtocolType,

    /// This property is part of quick create. If you don't specify a routeKey, a
    /// default route of $default is created. The $default route acts as a catch-all
    /// for any request made to your API, for a particular stage. The $default route
    /// key can't be modified. You can add routes after creating the API, and you
    /// can update the route keys of additional routes. Supported only for HTTP
    /// APIs.
    route_key: ?[]const u8 = null,

    /// The route selection expression for the API. For HTTP APIs, the
    /// routeSelectionExpression must be ${request.method} ${request.path}. If not
    /// provided, this will be the default for HTTP APIs. This property is required
    /// for WebSocket APIs.
    route_selection_expression: ?[]const u8 = null,

    /// The collection of tags. Each tag element is associated with a given
    /// resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// This property is part of quick create. Quick create produces an API with an
    /// integration, a default catch-all route, and a default stage which is
    /// configured to automatically deploy changes. For HTTP integrations, specify a
    /// fully qualified URL. For Lambda integrations, specify a function ARN. The
    /// type of the integration will be HTTP_PROXY or AWS_PROXY, respectively.
    /// Supported only for HTTP APIs.
    target: ?[]const u8 = null,

    /// A version identifier for the API.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_key_selection_expression = "ApiKeySelectionExpression",
        .cors_configuration = "CorsConfiguration",
        .credentials_arn = "CredentialsArn",
        .description = "Description",
        .disable_execute_api_endpoint = "DisableExecuteApiEndpoint",
        .disable_schema_validation = "DisableSchemaValidation",
        .ip_address_type = "IpAddressType",
        .name = "Name",
        .protocol_type = "ProtocolType",
        .route_key = "RouteKey",
        .route_selection_expression = "RouteSelectionExpression",
        .tags = "Tags",
        .target = "Target",
        .version = "Version",
    };
};

pub const CreateApiOutput = struct {
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateApiInput, options: Options) !CreateApiOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigatewayv2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: CreateApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigatewayv2", "ApiGatewayV2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/v2/apis";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.api_key_selection_expression) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ApiKeySelectionExpression\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.cors_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"CorsConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.credentials_arn) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"CredentialsArn\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.disable_execute_api_endpoint) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DisableExecuteApiEndpoint\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.disable_schema_validation) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DisableSchemaValidation\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"IpAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"ProtocolType\":");
    try aws.json.writeValue(@TypeOf(input.protocol_type), input.protocol_type, alloc, &body_buf);
    has_prev = true;
    if (input.route_key) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"RouteKey\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.route_selection_expression) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"RouteSelectionExpression\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.target) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Target\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.version) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Version\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !CreateApiOutput {
    var result: CreateApiOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateApiOutput, body, alloc);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
