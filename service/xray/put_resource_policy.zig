const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourcePolicy = @import("resource_policy.zig").ResourcePolicy;

pub const PutResourcePolicyInput = struct {
    /// A flag to indicate whether to bypass the resource policy lockout safety
    /// check.
    ///
    /// Setting this value to true increases the risk that the policy becomes
    /// unmanageable. Do not set this value to true indiscriminately.
    ///
    /// Use this parameter only when you include a policy in the request and you
    /// intend to prevent the principal that is making the request from making a
    /// subsequent `PutResourcePolicy` request.
    ///
    /// The default value is false.
    bypass_policy_lockout_check: ?bool = null,

    /// The resource policy document, which can be up to 5kb in size.
    policy_document: []const u8,

    /// The name of the resource policy. Must be unique within a specific Amazon Web
    /// Services account.
    policy_name: []const u8,

    /// Specifies a specific policy revision, to ensure an atomic create operation.
    /// By default the resource policy is created if it does not exist, or updated
    /// with an incremented revision id.
    /// The revision id is unique to each policy in the account.
    ///
    /// If the policy revision id does not match the latest revision id, the
    /// operation will fail with an `InvalidPolicyRevisionIdException` exception.
    /// You can also provide a
    /// `PolicyRevisionId` of 0. In this case, the operation will fail with an
    /// `InvalidPolicyRevisionIdException` exception if a resource policy with the
    /// same name already exists.
    policy_revision_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .bypass_policy_lockout_check = "BypassPolicyLockoutCheck",
        .policy_document = "PolicyDocument",
        .policy_name = "PolicyName",
        .policy_revision_id = "PolicyRevisionId",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// The resource policy document, as provided in the `PutResourcePolicyRequest`.
    resource_policy: ?ResourcePolicy = null,

    pub const json_field_names = .{
        .resource_policy = "ResourcePolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "xray", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourcePolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("xray", "XRay", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/PutResourcePolicy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.bypass_policy_lockout_check) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"BypassPolicyLockoutCheck\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PolicyDocument\":");
    try aws.json.writeValue(@TypeOf(input.policy_document), input.policy_document, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PolicyName\":");
    try aws.json.writeValue(@TypeOf(input.policy_name), input.policy_name, allocator, &body_buf);
    has_prev = true;
    if (input.policy_revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PolicyRevisionId\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourcePolicyOutput {
    var result: PutResourcePolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutResourcePolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
