const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const ContentHandlingStrategy = @import("content_handling_strategy.zig").ContentHandlingStrategy;

pub const PutIntegrationResponseInput = struct {
    /// Specifies how to handle response payload content type conversions. Supported
    /// values are `CONVERT_TO_BINARY` and `CONVERT_TO_TEXT`, with the following
    /// behaviors:
    ///
    /// If this property is not defined, the response payload will be passed through
    /// from the integration response to the method response without modification.
    content_handling: ?ContentHandlingStrategy = null,

    /// Specifies a put integration response request's HTTP method.
    http_method: []const u8,

    /// Specifies a put integration response request's resource identifier.
    resource_id: []const u8,

    /// A key-value map specifying response parameters that are passed to the method
    /// response from the back end.
    /// The key is a method response header parameter name and the mapped value is
    /// an integration response header value, a static value enclosed within a pair
    /// of single quotes, or a JSON expression from the integration response body.
    /// The mapping key must match the pattern of `method.response.header.{name}`,
    /// where `name` is a valid and unique header name. The mapped non-static value
    /// must match the pattern of `integration.response.header.{name}` or
    /// `integration.response.body.{JSON-expression}`, where `name` must be a valid
    /// and unique response header name and `JSON-expression` a valid JSON
    /// expression without the `$` prefix.
    response_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Specifies a put integration response's templates.
    response_templates: ?[]const aws.map.StringMapEntry = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// Specifies the selection pattern of a put integration response.
    selection_pattern: ?[]const u8 = null,

    /// Specifies the status code that is used to map the integration response to an
    /// existing MethodResponse.
    status_code: []const u8,

    pub const json_field_names = .{
        .content_handling = "contentHandling",
        .http_method = "httpMethod",
        .resource_id = "resourceId",
        .response_parameters = "responseParameters",
        .response_templates = "responseTemplates",
        .rest_api_id = "restApiId",
        .selection_pattern = "selectionPattern",
        .status_code = "statusCode",
    };
};

const PutIntegrationResponseOutput = @import("integration_response.zig").IntegrationResponse;

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutIntegrationResponseInput, options: Options) !PutIntegrationResponseOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "apigateway");

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

fn serializeRequest(alloc: std.mem.Allocator, input: PutIntegrationResponseInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/restapis/");
    try path_buf.appendSlice(alloc, input.rest_api_id);
    try path_buf.appendSlice(alloc, "/resources/");
    try path_buf.appendSlice(alloc, input.resource_id);
    try path_buf.appendSlice(alloc, "/methods/");
    try path_buf.appendSlice(alloc, input.http_method);
    try path_buf.appendSlice(alloc, "/integration/responses/");
    try path_buf.appendSlice(alloc, input.status_code);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.content_handling) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"contentHandling\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.response_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"responseParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.response_templates) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"responseTemplates\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.selection_pattern) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"selectionPattern\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !PutIntegrationResponseOutput {
    var result: PutIntegrationResponseOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutIntegrationResponseOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
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
    if (std.mem.eql(u8, error_code, "UnauthorizedException")) {
        return .{ .arena = arena, .kind = .{ .unauthorized_exception = .{
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
