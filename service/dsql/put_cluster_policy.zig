const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const PutClusterPolicyInput = struct {
    /// A flag that allows you to bypass the policy lockout safety check. When set
    /// to true, this parameter allows you to apply a policy that might lock you out
    /// of the cluster. Use with caution.
    bypass_policy_lockout_safety_check: ?bool = null,

    client_token: ?[]const u8 = null,

    /// The expected version of the current policy. This parameter ensures that
    /// you're updating the correct version of the policy and helps prevent
    /// concurrent modification conflicts.
    expected_policy_version: ?[]const u8 = null,

    identifier: []const u8,

    /// The resource-based policy document to attach to the cluster. This should be
    /// a valid JSON policy document that defines permissions and conditions.
    policy: []const u8,

    pub const json_field_names = .{
        .bypass_policy_lockout_safety_check = "bypassPolicyLockoutSafetyCheck",
        .client_token = "clientToken",
        .expected_policy_version = "expectedPolicyVersion",
        .identifier = "identifier",
        .policy = "policy",
    };
};

pub const PutClusterPolicyOutput = struct {
    /// The version of the policy after it has been updated or created.
    policy_version: []const u8,

    pub const json_field_names = .{
        .policy_version = "policyVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutClusterPolicyInput, options: CallOptions) !PutClusterPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dsql", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutClusterPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dsql", "DSQL", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/cluster/");
    try path_buf.appendSlice(allocator, input.identifier);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bypass_policy_lockout_safety_check) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"bypassPolicyLockoutSafetyCheck\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.expected_policy_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"expectedPolicyVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policy\":");
    try aws.json.writeValue(@TypeOf(input.policy), input.policy, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutClusterPolicyOutput {
    const result: PutClusterPolicyOutput = try aws.json.parseJsonObject(
        PutClusterPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
