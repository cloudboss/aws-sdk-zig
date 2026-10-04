const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const TestInvokeMethodInput = struct {
    /// The simulated request body of an incoming invocation request.
    body: ?[]const u8 = null,

    /// A ClientCertificate identifier to use in the test invocation. API Gateway
    /// will use the certificate when making the HTTPS request to the defined
    /// back-end endpoint.
    client_certificate_id: ?[]const u8 = null,

    /// A key-value map of headers to simulate an incoming invocation request.
    headers: ?[]const aws.map.StringMapEntry = null,

    /// Specifies a test invoke method request's HTTP method.
    http_method: []const u8,

    /// The headers as a map from string to list of values to simulate an incoming
    /// invocation request.
    multi_value_headers: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The URI path, including query string, of the simulated invocation request.
    /// Use this to specify path parameters and query string parameters.
    path_with_query_string: ?[]const u8 = null,

    /// Specifies a test invoke method request's resource ID.
    resource_id: []const u8,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// A key-value map of stage variables to simulate an invocation on a deployed
    /// Stage.
    stage_variables: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .body = "body",
        .client_certificate_id = "clientCertificateId",
        .headers = "headers",
        .http_method = "httpMethod",
        .multi_value_headers = "multiValueHeaders",
        .path_with_query_string = "pathWithQueryString",
        .resource_id = "resourceId",
        .rest_api_id = "restApiId",
        .stage_variables = "stageVariables",
    };
};

pub const TestInvokeMethodOutput = struct {
    /// The body of the HTTP response.
    body: ?[]const u8 = null,

    /// The headers of the HTTP response.
    headers: ?[]const aws.map.StringMapEntry = null,

    /// The execution latency, in ms, of the test invoke request.
    latency: ?i64 = null,

    /// The API Gateway execution log for the test invoke request.
    log: ?[]const u8 = null,

    /// The headers of the HTTP response as a map from string to list of values.
    multi_value_headers: ?[]const aws.map.MapEntry([]const []const u8) = null,

    /// The HTTP status code.
    status: ?i32 = null,

    pub const json_field_names = .{
        .body = "body",
        .headers = "headers",
        .latency = "latency",
        .log = "log",
        .multi_value_headers = "multiValueHeaders",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestInvokeMethodInput, options: CallOptions) !TestInvokeMethodOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestInvokeMethodInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/resources/");
    try path_buf.appendSlice(allocator, input.resource_id);
    try path_buf.appendSlice(allocator, "/methods/");
    try path_buf.appendSlice(allocator, input.http_method);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.body) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"body\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_certificate_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientCertificateId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestInvokeMethodOutput {
    var result: TestInvokeMethodOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(TestInvokeMethodOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
