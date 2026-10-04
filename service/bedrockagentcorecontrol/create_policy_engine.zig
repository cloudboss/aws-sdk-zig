const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PolicyEngineStatus = @import("policy_engine_status.zig").PolicyEngineStatus;

pub const CreatePolicyEngineInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you retry a request with the same client
    /// token, the service returns the same response without creating a duplicate
    /// policy engine.
    client_token: ?[]const u8 = null,

    /// A human-readable description of the policy engine's purpose and scope
    /// (1-4,096 characters). This helps administrators understand the policy
    /// engine's role in the overall governance strategy. Document which Gateway
    /// this engine will be associated with, what types of tools or workflows it
    /// governs, and the team or service responsible for maintaining it. Clear
    /// descriptions are essential when managing multiple policy engines across
    /// different services or environments.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the policy
    /// engine data.
    encryption_key_arn: ?[]const u8 = null,

    /// The customer-assigned immutable name for the policy engine. This name
    /// identifies the policy engine and cannot be changed after creation.
    name: []const u8,

    /// A map of tag keys and values to assign to an AgentCore Policy. Tags enable
    /// you to categorize your resources in different ways, for example, by purpose,
    /// owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .encryption_key_arn = "encryptionKeyArn",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreatePolicyEngineOutput = struct {
    /// The timestamp when the policy engine was created. This is automatically set
    /// by the service and used for auditing and lifecycle management.
    created_at: i64,

    /// A human-readable description of the policy engine's purpose.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt the policy
    /// engine data.
    encryption_key_arn: ?[]const u8 = null,

    /// The customer-assigned name of the created policy engine. This matches the
    /// name provided in the request and serves as the human-readable identifier.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the created policy engine. This globally
    /// unique identifier can be used for cross-service references and IAM policy
    /// statements.
    policy_engine_arn: []const u8,

    /// The unique identifier for the created policy engine. This system-generated
    /// identifier consists of the user name plus a 10-character generated suffix
    /// and is used for all subsequent policy engine operations.
    policy_engine_id: []const u8,

    /// The current status of the policy engine. A status of `ACTIVE` indicates the
    /// policy engine is ready for use.
    status: PolicyEngineStatus,

    /// Additional information about the policy engine status. This provides details
    /// about any failures or the current state of the policy engine creation
    /// process.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the policy engine was last updated. For newly created
    /// policy engines, this matches the `createdAt` timestamp.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePolicyEngineInput, options: CallOptions) !CreatePolicyEngineOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePolicyEngineInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/policy-engines";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"encryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePolicyEngineOutput {
    var result: CreatePolicyEngineOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePolicyEngineOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
