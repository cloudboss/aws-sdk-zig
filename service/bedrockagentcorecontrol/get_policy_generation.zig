const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Resource = @import("resource.zig").Resource;
const PolicyGenerationStatus = @import("policy_generation_status.zig").PolicyGenerationStatus;

pub const GetPolicyGenerationInput = struct {
    /// The identifier of the policy engine associated with the policy generation
    /// request. This provides the context for the generation operation and schema
    /// validation.
    policy_engine_id: []const u8,

    /// The unique identifier of the policy generation request to be retrieved. This
    /// must be a valid generation ID from a previous
    /// [StartPolicyGeneration](https://docs.aws.amazon.com/bedrock-agentcore-control/latest/APIReference/API_StartPolicyGeneration.html) call.
    policy_generation_id: []const u8,

    pub const json_field_names = .{
        .policy_engine_id = "policyEngineId",
        .policy_generation_id = "policyGenerationId",
    };
};

pub const GetPolicyGenerationOutput = struct {
    /// The timestamp when the policy generation request was created. This is used
    /// for tracking and auditing generation operations and their lifecycle.
    created_at: i64,

    /// The findings and results from the policy generation process. This includes
    /// any issues, recommendations, validation results, or insights from the
    /// generated policies.
    findings: ?[]const u8 = null,

    /// The customer-assigned name for the policy generation request. This helps
    /// identify and track generation operations across multiple requests.
    name: []const u8,

    /// The identifier of the policy engine associated with this policy generation.
    /// This confirms the policy engine context for the generation operation.
    policy_engine_id: []const u8,

    /// The Amazon Resource Name (ARN) of the policy generation. This globally
    /// unique identifier can be used for tracking, auditing, and cross-service
    /// references.
    policy_generation_arn: []const u8,

    /// The unique identifier of the policy generation request. This matches the
    /// generation ID provided in the request and serves as the tracking identifier.
    policy_generation_id: []const u8,

    /// The resource information associated with the policy generation. This
    /// provides context about the target resources for which the policies are being
    /// generated.
    resource: ?Resource = null,

    /// The current status of the policy generation. This indicates whether the
    /// generation is in progress, completed successfully, or failed during
    /// processing.
    status: PolicyGenerationStatus,

    /// Additional information about the generation status. This provides details
    /// about any failures, warnings, or the current state of the generation
    /// process.
    status_reasons: ?[]const []const u8 = null,

    /// The timestamp when the policy generation was last updated. This tracks the
    /// progress of the generation process and any status changes.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicyGenerationInput, options: CallOptions) !GetPolicyGenerationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPolicyGenerationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    try path_buf.appendSlice(allocator, "/policy-generations/");
    try path_buf.appendSlice(allocator, input.policy_generation_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPolicyGenerationOutput {
    const result: GetPolicyGenerationOutput = try aws.json.parseJsonObject(
        GetPolicyGenerationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
