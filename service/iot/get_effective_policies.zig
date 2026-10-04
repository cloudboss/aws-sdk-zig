const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EffectivePolicy = @import("effective_policy.zig").EffectivePolicy;

pub const GetEffectivePoliciesInput = struct {
    /// The Cognito identity pool ID.
    cognito_identity_pool_id: ?[]const u8 = null,

    /// The principal. Valid principals are CertificateArn
    /// (arn:aws:iot:*region*:*accountId*:cert/*certificateId*), thingGroupArn
    /// (arn:aws:iot:*region*:*accountId*:thinggroup/*groupName*) and CognitoId
    /// (*region*:*id*).
    principal: ?[]const u8 = null,

    /// The thing name.
    thing_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .cognito_identity_pool_id = "cognitoIdentityPoolId",
        .principal = "principal",
        .thing_name = "thingName",
    };
};

pub const GetEffectivePoliciesOutput = struct {
    /// The effective policies.
    effective_policies: ?[]const EffectivePolicy = null,

    pub const json_field_names = .{
        .effective_policies = "effectivePolicies",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEffectivePoliciesInput, options: CallOptions) !GetEffectivePoliciesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEffectivePoliciesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/effective-policies";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.thing_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "thingName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.cognito_identity_pool_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"cognitoIdentityPoolId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEffectivePoliciesOutput {
    const result: GetEffectivePoliciesOutput = try aws.json.parseJsonObject(
        GetEffectivePoliciesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
