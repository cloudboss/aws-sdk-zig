const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreatePolicyVersionInput = struct {
    /// The JSON document that describes the policy. Minimum length of 1. Maximum
    /// length of
    /// 2048, excluding whitespace.
    policy_document: []const u8,

    /// The policy name.
    policy_name: []const u8,

    /// Specifies whether the policy version is set as the default. When this
    /// parameter is
    /// true, the new policy version becomes the operative version (that is, the
    /// version that is in
    /// effect for the certificates to which the policy is attached).
    set_as_default: ?bool = null,

    pub const json_field_names = .{
        .policy_document = "policyDocument",
        .policy_name = "policyName",
        .set_as_default = "setAsDefault",
    };
};

pub const CreatePolicyVersionOutput = struct {
    /// Specifies whether the policy version is the default.
    is_default_version: ?bool = null,

    /// The policy ARN.
    policy_arn: ?[]const u8 = null,

    /// The JSON document that describes the policy.
    policy_document: ?[]const u8 = null,

    /// The policy version ID.
    policy_version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .is_default_version = "isDefaultVersion",
        .policy_arn = "policyArn",
        .policy_document = "policyDocument",
        .policy_version_id = "policyVersionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePolicyVersionInput, options: CallOptions) !CreatePolicyVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePolicyVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policies/");
    try path_buf.appendSlice(allocator, input.policy_name);
    try path_buf.appendSlice(allocator, "/version");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.set_as_default) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "setAsDefault=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyDocument\":");
    try aws.json.writeValue(@TypeOf(input.policy_document), input.policy_document, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePolicyVersionOutput {
    const result: CreatePolicyVersionOutput = try aws.json.parseJsonObject(
        CreatePolicyVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
