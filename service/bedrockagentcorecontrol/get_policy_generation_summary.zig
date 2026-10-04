const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Resource = @import("resource.zig").Resource;
const PolicyGenerationStatus = @import("policy_generation_status.zig").PolicyGenerationStatus;

pub const GetPolicyGenerationSummaryInput = struct {
    /// The identifier of the policy engine associated with the policy generation
    /// request.
    policy_engine_id: []const u8,

    /// The unique identifier of the policy generation request to retrieve the
    /// summary for.
    policy_generation_id: []const u8,

    pub const json_field_names = .{
        .policy_engine_id = "policyEngineId",
        .policy_generation_id = "policyGenerationId",
    };
};

pub const GetPolicyGenerationSummaryOutput = struct {
    /// The timestamp when the policy generation request was created.
    created_at: i64,

    /// The findings from the policy generation process, if available.
    findings: ?[]const u8 = null,

    /// The customer-assigned name for the policy generation request.
    name: []const u8,

    /// The identifier of the policy engine associated with this policy generation.
    policy_engine_id: []const u8,

    /// The Amazon Resource Name (ARN) of the policy generation request.
    policy_generation_arn: []const u8,

    /// The unique identifier of the policy generation request.
    policy_generation_id: []const u8,

    /// The resource information associated with the policy generation.
    resource: ?Resource = null,

    /// The current status of the policy generation request.
    status: PolicyGenerationStatus,

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
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPolicyGenerationSummaryInput, options: CallOptions) !GetPolicyGenerationSummaryOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPolicyGenerationSummaryInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/policy-engines/");
    try path_buf.appendSlice(allocator, input.policy_engine_id);
    try path_buf.appendSlice(allocator, "/policy-generation-summaries/");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPolicyGenerationSummaryOutput {
    const result: GetPolicyGenerationSummaryOutput = try aws.json.parseJsonObject(
        GetPolicyGenerationSummaryOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
