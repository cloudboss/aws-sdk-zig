const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetAutomatedReasoningPolicyInput = struct {
    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy to
    /// retrieve. Can be either the unversioned ARN for the draft policy or an ARN
    /// for a specific policy version.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .policy_arn = "policyArn",
    };
};

pub const GetAutomatedReasoningPolicyOutput = struct {
    /// The timestamp when the policy was created.
    created_at: ?i64 = null,

    /// The hash of the policy definition used as a concurrency token.
    definition_hash: []const u8,

    /// The description of the policy.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the automated
    /// reasoning policy and its associated artifacts. If a KMS key is not provided
    /// during the initial CreateAutomatedReasoningPolicyRequest, the kmsKeyArn
    /// won't be included in the GetAutomatedReasoningPolicyResponse.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the policy.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the policy.
    policy_arn: []const u8,

    /// The unique identifier of the policy.
    policy_id: []const u8,

    /// The timestamp when the policy was last updated.
    updated_at: i64,

    /// The version of the policy.
    version: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .definition_hash = "definitionHash",
        .description = "description",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .policy_arn = "policyArn",
        .policy_id = "policyId",
        .updated_at = "updatedAt",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutomatedReasoningPolicyInput, options: CallOptions) !GetAutomatedReasoningPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutomatedReasoningPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutomatedReasoningPolicyOutput {
    const result: GetAutomatedReasoningPolicyOutput = try aws.json.parseJsonObject(
        GetAutomatedReasoningPolicyOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
