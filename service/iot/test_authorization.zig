const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AuthInfo = @import("auth_info.zig").AuthInfo;
const AuthResult = @import("auth_result.zig").AuthResult;

pub const TestAuthorizationInput = struct {
    /// A list of authorization info objects. Simulating authorization will create a
    /// response
    /// for each `authInfo` object in the list.
    auth_infos: []const AuthInfo,

    /// The MQTT client ID.
    client_id: ?[]const u8 = null,

    /// The Cognito identity pool ID.
    cognito_identity_pool_id: ?[]const u8 = null,

    /// When testing custom authorization, the policies specified here are treated
    /// as if they
    /// are attached to the principal being authorized.
    policy_names_to_add: ?[]const []const u8 = null,

    /// When testing custom authorization, the policies specified here are treated
    /// as if they
    /// are not attached to the principal being authorized.
    policy_names_to_skip: ?[]const []const u8 = null,

    /// The principal. Valid principals are CertificateArn
    /// (arn:aws:iot:*region*:*accountId*:cert/*certificateId*) and CognitoId
    /// (*region*:*id*).
    principal: ?[]const u8 = null,

    pub const json_field_names = .{
        .auth_infos = "authInfos",
        .client_id = "clientId",
        .cognito_identity_pool_id = "cognitoIdentityPoolId",
        .policy_names_to_add = "policyNamesToAdd",
        .policy_names_to_skip = "policyNamesToSkip",
        .principal = "principal",
    };
};

pub const TestAuthorizationOutput = struct {
    /// The authentication results.
    auth_results: ?[]const AuthResult = null,

    pub const json_field_names = .{
        .auth_results = "authResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TestAuthorizationInput, options: CallOptions) !TestAuthorizationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: TestAuthorizationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/test-authorization";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.client_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "clientId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"authInfos\":");
    try aws.json.writeValue(@TypeOf(input.auth_infos), input.auth_infos, allocator, &body_buf);
    has_prev = true;
    if (input.cognito_identity_pool_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cognitoIdentityPoolId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy_names_to_add) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyNamesToAdd\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.policy_names_to_skip) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"policyNamesToSkip\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.principal) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"principal\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TestAuthorizationOutput {
    var result: TestAuthorizationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(TestAuthorizationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
