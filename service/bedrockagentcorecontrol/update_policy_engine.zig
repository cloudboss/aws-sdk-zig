const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const UpdatedDescription = @import("updated_description.zig").UpdatedDescription;
const PolicyEngineStatus = @import("policy_engine_status.zig").PolicyEngineStatus;

pub const UpdatePolicyEngineInput = struct {
    /// The new description for the policy engine.
    description: ?UpdatedDescription = null,

    /// The unique identifier of the policy engine to be updated.
    policy_engine_id: []const u8,

    pub const json_field_names = .{
        .description = "description",
        .policy_engine_id = "policyEngineId",
    };
};

pub const UpdatePolicyEngineOutput = struct {
    /// The original creation timestamp of the policy engine.
    created_at: i64,

    /// The updated description of the policy engine.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the policy
    /// engine data.
    encryption_key_arn: ?[]const u8 = null,

    /// The name of the updated policy engine.
    name: []const u8,

    /// The ARN of the updated policy engine.
    policy_engine_arn: []const u8,

    /// The unique identifier of the updated policy engine.
    policy_engine_id: []const u8,

    /// The current status of the updated policy engine.
    status: PolicyEngineStatus,

    /// Additional information about the update status.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the policy engine was last updated.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePolicyEngineInput, options: CallOptions) !UpdatePolicyEngineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePolicyEngineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePolicyEngineOutput {
    const result: UpdatePolicyEngineOutput = try aws.json.parseJsonObject(
        UpdatePolicyEngineOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
