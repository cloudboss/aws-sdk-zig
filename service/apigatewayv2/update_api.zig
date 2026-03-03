const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Cors = @import("cors.zig").Cors;
const IpAddressType = @import("ip_address_type.zig").IpAddressType;
const ProtocolType = @import("protocol_type.zig").ProtocolType;

pub const UpdateApiInput = struct {
    /// The API identifier.
    api_id: []const u8,

    /// An API key selection expression. Supported only for WebSocket APIs. See [API
    /// Key Selection
    /// Expressions](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html#apigateway-websocket-api-apikey-selection-expressions).
    api_key_selection_expression: ?[]const u8 = null,

    /// A CORS configuration. Supported only for HTTP APIs.
    cors_configuration: ?Cors = null,

    /// This property is part of quick create. It specifies the credentials required
    /// for the integration, if any. For a Lambda integration, three options are
    /// available. To specify an IAM Role for API Gateway to assume, use the role's
    /// Amazon Resource Name (ARN). To require that the caller's identity be passed
    /// through from the request, specify arn:aws:iam::*:user/*. To use
    /// resource-based permissions on supported AWS services, don't specify this
    /// parameter. Currently, this property is not used for HTTP integrations. If
    /// provided, this value replaces the credentials associated with the quick
    /// create integration. Supported only for HTTP APIs.
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

    /// The IP address types that can invoke your API or domain name.
    ip_address_type: ?IpAddressType = null,

    /// The name of the API.
    name: ?[]const u8 = null,

    /// This property is part of quick create. If not specified, the route created
    /// using quick create is kept. Otherwise, this value replaces the route key of
    /// the quick create route. Additional routes may still be added after the API
    /// is updated. Supported only for HTTP APIs.
    route_key: ?[]const u8 = null,

    /// The route selection expression for the API. For HTTP APIs, the
    /// routeSelectionExpression must be ${request.method} ${request.path}. If not
    /// provided, this will be the default for HTTP APIs. This property is required
    /// for WebSocket APIs.
    route_selection_expression: ?[]const u8 = null,

    /// This property is part of quick create. For HTTP integrations, specify a
    /// fully qualified URL. For Lambda integrations, specify a function ARN. The
    /// type of the integration will be HTTP_PROXY or AWS_PROXY, respectively. The
    /// value provided updates the integration URI and integration type. You can
    /// update a quick-created target, but you can't remove it from an API.
    /// Supported only for HTTP APIs.
    target: ?[]const u8 = null,

    /// A version identifier for the API.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .api_id = "ApiId",
        .api_key_selection_expression = "ApiKeySelectionExpression",
        .cors_configuration = "CorsConfiguration",
        .credentials_arn = "CredentialsArn",
        .description = "Description",
        .disable_execute_api_endpoint = "DisableExecuteApiEndpoint",
        .disable_schema_validation = "DisableSchemaValidation",
        .ip_address_type = "IpAddressType",
        .name = "Name",
        .route_key = "RouteKey",
        .route_selection_expression = "RouteSelectionExpression",
        .target = "Target",
        .version = "Version",
    };
};

pub const UpdateApiOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateApiInput, options: Options) !UpdateApiOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateApiInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigatewayv2", "ApiGatewayV2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/v2/apis/");
    try path_buf.appendSlice(allocator, input.api_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.api_key_selection_expression) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ApiKeySelectionExpression\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cors_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CorsConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.credentials_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CredentialsArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.disable_execute_api_endpoint) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisableExecuteApiEndpoint\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.disable_schema_validation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DisableSchemaValidation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.ip_address_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"IpAddressType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.route_key) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RouteKey\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.route_selection_expression) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"RouteSelectionExpression\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Target\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Version\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateApiOutput {
    var result: UpdateApiOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateApiOutput, body, allocator);
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
