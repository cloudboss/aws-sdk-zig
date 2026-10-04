const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkspacePolicyStatusCode = @import("workspace_policy_status_code.zig").WorkspacePolicyStatusCode;

pub const PutResourcePolicyInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the request
    /// is safe to retry (idempotent).
    client_token: ?[]const u8 = null,

    /// The JSON policy document to use as the resource-based policy. This policy
    /// defines the permissions that other AWS accounts or services have to access
    /// your workspace.
    policy_document: []const u8,

    /// The revision ID of the policy to update. Use this parameter to ensure that
    /// you are updating the correct version of the policy. If you don't specify a
    /// revision ID, the policy is updated regardless of its current revision.
    ///
    /// For the first **PUT** request on a workspace that doesn't have an existing
    /// resource policy, you can specify `NO_POLICY` as the revision ID.
    revision_id: ?[]const u8 = null,

    /// The ID of the workspace to attach the resource-based policy to.
    workspace_id: []const u8,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .policy_document = "policyDocument",
        .revision_id = "revisionId",
        .workspace_id = "workspaceId",
    };
};

pub const PutResourcePolicyOutput = struct {
    /// The current status of the resource-based policy.
    policy_status: WorkspacePolicyStatusCode,

    /// The revision ID of the newly created or updated resource-based policy.
    revision_id: []const u8,

    pub const json_field_names = .{
        .policy_status = "policyStatus",
        .revision_id = "revisionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourcePolicyInput, options: CallOptions) !PutResourcePolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aps", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workspaces/");
    try path_buf.appendSlice(allocator, input.workspace_id);
    try path_buf.appendSlice(allocator, "/policy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"policyDocument\":");
    try aws.json.writeValue(@TypeOf(input.policy_document), input.policy_document, allocator, &body_buf);
    has_prev = true;
    if (input.revision_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"revisionId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
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
