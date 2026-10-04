const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyEngineStatus = @import("policy_engine_status.zig").PolicyEngineStatus;

pub const GetPolicyEngineInput = struct {
    /// The unique identifier of the policy engine to be retrieved. This must be a
    /// valid policy engine ID that exists within the account.
    policy_engine_id: []const u8,

    pub const json_field_names = .{
        .policy_engine_id = "policyEngineId",
    };
};

pub const GetPolicyEngineOutput = struct {
    /// The timestamp when the policy engine was originally created.
    created_at: i64,

    /// The human-readable description of the policy engine's purpose and scope.
    /// This helps administrators understand the policy engine's role in governance.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the policy
    /// engine data.
    encryption_key_arn: ?[]const u8 = null,

    /// The customer-assigned name of the policy engine. This is the human-readable
    /// identifier that was specified when the policy engine was created.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the policy engine. This globally unique
    /// identifier can be used for cross-service references and IAM policy
    /// statements.
    policy_engine_arn: []const u8,

    /// The unique identifier of the retrieved policy engine. This matches the
    /// policy engine ID provided in the request and serves as the system
    /// identifier.
    policy_engine_id: []const u8,

    /// The current status of the policy engine.
    status: PolicyEngineStatus,

    /// Additional information about the policy engine status. This provides details
    /// about any failures or the current state of the policy engine.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the policy engine was last modified. This tracks the most
    /// recent changes to the policy engine configuration.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .encryption_key_arn = "encryptionKeyArn",
        .name = "name",
        .policy_engine_arn = "policyEngineArn",
        .policy_engine_id = "policyEngineId",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicyEngineInput, options: CallOptions) !GetPolicyEngineOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "bedrock-agentcore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPolicyEngineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPolicyEngineOutput {
    const result: GetPolicyEngineOutput = try aws.json.parseJsonObject(
        GetPolicyEngineOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
