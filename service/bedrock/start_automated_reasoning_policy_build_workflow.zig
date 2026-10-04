const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedReasoningPolicyBuildWorkflowType = @import("automated_reasoning_policy_build_workflow_type.zig").AutomatedReasoningPolicyBuildWorkflowType;
const AutomatedReasoningPolicyBuildWorkflowSource = @import("automated_reasoning_policy_build_workflow_source.zig").AutomatedReasoningPolicyBuildWorkflowSource;

pub const StartAutomatedReasoningPolicyBuildWorkflowInput = struct {
    /// The type of build workflow to start (e.g., DOCUMENT_INGESTION for processing
    /// new documents, POLICY_REPAIR for fixing existing policies).
    build_workflow_type: AutomatedReasoningPolicyBuildWorkflowType,

    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than once. If this token matches a previous request, Amazon Bedrock
    /// ignores the request but doesn't return an error.
    client_request_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy for which
    /// to start the build workflow.
    policy_arn: []const u8,

    /// The source content for the build workflow, such as documents to analyze or
    /// repair instructions for existing policies.
    source_content: AutomatedReasoningPolicyBuildWorkflowSource,

    pub const json_field_names = .{
        .build_workflow_type = "buildWorkflowType",
        .client_request_token = "clientRequestToken",
        .policy_arn = "policyArn",
        .source_content = "sourceContent",
    };
};

pub const StartAutomatedReasoningPolicyBuildWorkflowOutput = struct {
    /// The unique identifier of the newly started build workflow. Use this ID to
    /// track the workflow's progress and retrieve its results.
    build_workflow_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .build_workflow_id = "buildWorkflowId",
        .policy_arn = "policyArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartAutomatedReasoningPolicyBuildWorkflowInput, options: CallOptions) !StartAutomatedReasoningPolicyBuildWorkflowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartAutomatedReasoningPolicyBuildWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/build-workflows/");
    try path_buf.appendSlice(allocator, input.build_workflow_type);
    try path_buf.appendSlice(allocator, "/start");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = try aws.json.jsonStringify(input.source_content, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.client_request_token) |v| {
        try request.headers.put(allocator, "x-amz-client-token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartAutomatedReasoningPolicyBuildWorkflowOutput {
    const result: StartAutomatedReasoningPolicyBuildWorkflowOutput = try aws.json.parseJsonObject(
        StartAutomatedReasoningPolicyBuildWorkflowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
