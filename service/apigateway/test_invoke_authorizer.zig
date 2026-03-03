const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

pub const TestInvokeAuthorizerInput = struct {
    /// A key-value map of additional context variables.
    additional_context: ?[]const aws.map.StringMapEntry = null,

    /// Specifies a test invoke authorizer request's Authorizer ID.
    authorizer_id: []const u8,

    /// The simulated request body of an incoming invocation request.
    body: ?[]const u8 = null,

    /// A key-value map of headers to simulate an incoming invocation request. This
    /// is where the incoming authorization token, or identity source, should be
    /// specified.
    headers: ?[]const aws.map.StringMapEntry = null,

    /// The headers as a map from string to list of values to simulate an incoming
    /// invocation request. This is where the incoming authorization token, or
    /// identity source, may be specified.
    multi_value_headers: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The URI path, including query string, of the simulated invocation request.
    /// Use this to specify path parameters and query string parameters.
    path_with_query_string: ?[]const u8 = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// A key-value map of stage variables to simulate an invocation on a deployed
    /// Stage.
    stage_variables: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .additional_context = "additionalContext",
        .authorizer_id = "authorizerId",
        .body = "body",
        .headers = "headers",
        .multi_value_headers = "multiValueHeaders",
        .path_with_query_string = "pathWithQueryString",
        .rest_api_id = "restApiId",
        .stage_variables = "stageVariables",
    };
};

pub const TestInvokeAuthorizerOutput = struct {
    /// The authorization response.
    authorization: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The open identity claims, with any supported custom attributes, returned
    /// from the Cognito Your User Pool configured for the API.
    claims: ?[]const aws.map.StringMapEntry = null,

    /// The HTTP status code that the client would have received. Value is 0 if the
    /// authorizer succeeded.
    client_status: ?i32 = null,

    /// The execution latency, in ms, of the test authorizer request.
    latency: ?i64 = null,

    /// The API Gateway execution log for the test authorizer request.
    log: ?[]const u8 = null,

    /// The JSON policy document returned by the Authorizer
    policy: ?[]const u8 = null,

    /// The principal identity returned by the Authorizer
    principal_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorization = "authorization",
        .claims = "claims",
        .client_status = "clientStatus",
        .latency = "latency",
        .log = "log",
        .policy = "policy",
        .principal_id = "principalId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestInvokeAuthorizerInput, options: Options) !TestInvokeAuthorizerOutput {
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
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: TestInvokeAuthorizerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/authorizers/");
    try path_buf.appendSlice(allocator, input.authorizer_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.additional_context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"additionalContext\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"body\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.headers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"headers\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multi_value_headers) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"multiValueHeaders\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.path_with_query_string) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"pathWithQueryString\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.stage_variables) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"stageVariables\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestInvokeAuthorizerOutput {
    var result: TestInvokeAuthorizerOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(TestInvokeAuthorizerOutput, body, allocator);
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
