const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestInvokeAuthorizerInput, options: CallOptions) !TestInvokeAuthorizerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TestInvokeAuthorizerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/authorizers/");
    try path_buf.appendSlice(allocator, input.authorizer_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestInvokeAuthorizerOutput {
    const result: TestInvokeAuthorizerOutput = try aws.json.parseJsonObject(
        TestInvokeAuthorizerOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
