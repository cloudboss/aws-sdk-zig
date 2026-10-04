const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const HttpContext = @import("http_context.zig").HttpContext;
const MqttContext = @import("mqtt_context.zig").MqttContext;
const TlsContext = @import("tls_context.zig").TlsContext;

pub const TestInvokeAuthorizerInput = struct {
    /// The custom authorizer name.
    authorizer_name: []const u8,

    /// Specifies a test HTTP authorization request.
    http_context: ?HttpContext = null,

    /// Specifies a test MQTT authorization request.
    mqtt_context: ?MqttContext = null,

    /// Specifies a test TLS authorization request.
    tls_context: ?TlsContext = null,

    /// The token returned by your custom authentication service.
    token: ?[]const u8 = null,

    /// The signature made with the token and your custom authentication service's
    /// private
    /// key. This value must be Base-64-encoded.
    token_signature: ?[]const u8 = null,

    pub const json_field_names = .{
        .authorizer_name = "authorizerName",
        .http_context = "httpContext",
        .mqtt_context = "mqttContext",
        .tls_context = "tlsContext",
        .token = "token",
        .token_signature = "tokenSignature",
    };
};

pub const TestInvokeAuthorizerOutput = struct {
    /// The number of seconds after which the connection is terminated.
    disconnect_after_in_seconds: ?i32 = null,

    /// True if the token is authenticated, otherwise false.
    is_authenticated: ?bool = null,

    /// IAM policy documents.
    policy_documents: ?[]const []const u8 = null,

    /// The principal ID.
    principal_id: ?[]const u8 = null,

    /// The number of seconds after which the temporary credentials are refreshed.
    refresh_after_in_seconds: ?i32 = null,

    pub const json_field_names = .{
        .disconnect_after_in_seconds = "disconnectAfterInSeconds",
        .is_authenticated = "isAuthenticated",
        .policy_documents = "policyDocuments",
        .principal_id = "principalId",
        .refresh_after_in_seconds = "refreshAfterInSeconds",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestInvokeAuthorizerInput, options: CallOptions) !TestInvokeAuthorizerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/authorizer/");
    try path_buf.appendSlice(allocator, input.authorizer_name);
    try path_buf.appendSlice(allocator, "/test");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.http_context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"httpContext\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.mqtt_context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mqttContext\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tls_context) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tlsContext\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"token\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.token_signature) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tokenSignature\":");
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
