const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetPolicyVersionInput = struct {
    /// The name of the policy.
    policy_name: []const u8,

    /// The policy version ID.
    policy_version_id: []const u8,

    pub const json_field_names = .{
        .policy_name = "policyName",
        .policy_version_id = "policyVersionId",
    };
};

pub const GetPolicyVersionOutput = struct {
    /// The date the policy was created.
    creation_date: ?i64 = null,

    /// The generation ID of the policy version.
    generation_id: ?[]const u8 = null,

    /// Specifies whether the policy version is the default.
    is_default_version: ?bool = null,

    /// The date the policy was last modified.
    last_modified_date: ?i64 = null,

    /// The policy ARN.
    policy_arn: ?[]const u8 = null,

    /// The JSON document that describes the policy.
    policy_document: ?[]const u8 = null,

    /// The policy name.
    policy_name: ?[]const u8 = null,

    /// The policy version ID.
    policy_version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .generation_id = "generationId",
        .is_default_version = "isDefaultVersion",
        .last_modified_date = "lastModifiedDate",
        .policy_arn = "policyArn",
        .policy_document = "policyDocument",
        .policy_name = "policyName",
        .policy_version_id = "policyVersionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicyVersionInput, options: CallOptions) !GetPolicyVersionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPolicyVersionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policies/");
    try path_buf.appendSlice(allocator, input.policy_name);
    try path_buf.appendSlice(allocator, "/version/");
    try path_buf.appendSlice(allocator, input.policy_version_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPolicyVersionOutput {
    const result: GetPolicyVersionOutput = try aws.json.parseJsonObject(
        GetPolicyVersionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
