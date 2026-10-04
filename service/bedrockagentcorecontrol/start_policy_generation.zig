const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Content = @import("content.zig").Content;
const Resource = @import("resource.zig").Resource;
const PolicyGenerationStatus = @import("policy_generation_status.zig").PolicyGenerationStatus;

pub const StartPolicyGenerationInput = struct {
    /// A unique, case-sensitive identifier to ensure the idempotency of the
    /// request. The AWS SDK automatically generates this token, so you don't need
    /// to provide it in most cases. If you retry a request with the same client
    /// token, the service returns the same response without starting a duplicate
    /// generation.
    client_token: ?[]const u8 = null,

    /// The natural language description of the desired policy behavior. This
    /// content is processed by AI to generate corresponding Dogwood policy
    /// statements that match the described intent.
    content: Content,

    /// A customer-assigned name for the policy generation request. This helps track
    /// and identify generation operations, especially when running multiple
    /// generations simultaneously.
    name: []const u8,

    /// The identifier of the policy engine that provides the context for policy
    /// generation. This engine's schema and tool context are used to ensure
    /// generated policies are valid and applicable.
    policy_engine_id: []const u8,

    /// The resource information that provides context for policy generation. This
    /// helps the AI understand the target resources and generate appropriate access
    /// control rules.
    resource: Resource,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .content = "content",
        .name = "name",
        .policy_engine_id = "policyEngineId",
        .resource = "resource",
    };
};

pub const StartPolicyGenerationOutput = struct {
    /// The timestamp when the policy generation request was created.
    created_at: i64,

    /// Initial findings from the policy generation process.
    findings: ?[]const u8 = null,

    /// The customer-assigned name for the policy generation request.
    name: []const u8,

    /// The identifier of the policy engine associated with the started policy
    /// generation.
    policy_engine_id: []const u8,

    /// The ARN of the created policy generation request.
    policy_generation_arn: []const u8,

    /// The unique identifier assigned to the policy generation request for tracking
    /// progress.
    policy_generation_id: []const u8,

    /// The resource information associated with the policy generation request.
    resource: ?Resource = null,

    /// The initial status of the policy generation request.
    status: PolicyGenerationStatus,

    /// Additional information about the generation status.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the policy generation was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .findings = "findings",
        .name = "name",
        .policy_engine_id = "policyEngineId",
        .policy_generation_arn = "policyGenerationArn",
        .policy_generation_id = "policyGenerationId",
        .resource = "resource",
        .status = "status",
        .status_reasons = "statusReasons",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartPolicyGenerationInput, options: CallOptions) !StartPolicyGenerationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartPolicyGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    try path_buf.appendSlice(allocator, "/policy-generations");
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
    try body_buf.appendSlice(allocator, "\"content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"resource\":");
    try aws.json.writeValue(@TypeOf(input.resource), input.resource, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartPolicyGenerationOutput {
    const result: StartPolicyGenerationOutput = try aws.json.parseJsonObject(
        StartPolicyGenerationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
