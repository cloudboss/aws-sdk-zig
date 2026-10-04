const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedReasoningPolicyBuildWorkflowType = @import("automated_reasoning_policy_build_workflow_type.zig").AutomatedReasoningPolicyBuildWorkflowType;
const AutomatedReasoningPolicyBuildDocumentContentType = @import("automated_reasoning_policy_build_document_content_type.zig").AutomatedReasoningPolicyBuildDocumentContentType;
const AutomatedReasoningPolicyBuildWorkflowStatus = @import("automated_reasoning_policy_build_workflow_status.zig").AutomatedReasoningPolicyBuildWorkflowStatus;

pub const GetAutomatedReasoningPolicyBuildWorkflowInput = struct {
    /// The unique identifier of the build workflow to retrieve.
    build_workflow_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy whose build
    /// workflow you want to retrieve.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .build_workflow_id = "buildWorkflowId",
        .policy_arn = "policyArn",
    };
};

pub const GetAutomatedReasoningPolicyBuildWorkflowOutput = struct {
    /// The unique identifier of the build workflow.
    build_workflow_id: []const u8,

    /// The type of build workflow being executed (e.g., DOCUMENT_INGESTION,
    /// POLICY_REPAIR).
    build_workflow_type: AutomatedReasoningPolicyBuildWorkflowType,

    /// The timestamp when the build workflow was created.
    created_at: i64,

    /// The content type of the source document (e.g., text/plain, application/pdf).
    document_content_type: ?AutomatedReasoningPolicyBuildDocumentContentType = null,

    /// A detailed description of the document's content and how it should be used
    /// in the policy generation process.
    document_description: ?[]const u8 = null,

    /// The name of the source document used in the build workflow.
    document_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy.
    policy_arn: []const u8,

    /// The current status of the build workflow (e.g., RUNNING, COMPLETED, FAILED,
    /// CANCELLED).
    status: AutomatedReasoningPolicyBuildWorkflowStatus,

    /// The timestamp when the build workflow was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .build_workflow_id = "buildWorkflowId",
        .build_workflow_type = "buildWorkflowType",
        .created_at = "createdAt",
        .document_content_type = "documentContentType",
        .document_description = "documentDescription",
        .document_name = "documentName",
        .policy_arn = "policyArn",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAutomatedReasoningPolicyBuildWorkflowInput, options: CallOptions) !GetAutomatedReasoningPolicyBuildWorkflowOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAutomatedReasoningPolicyBuildWorkflowInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/build-workflows/");
    try path_buf.appendSlice(allocator, input.build_workflow_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAutomatedReasoningPolicyBuildWorkflowOutput {
    const result: GetAutomatedReasoningPolicyBuildWorkflowOutput = try aws.json.parseJsonObject(
        GetAutomatedReasoningPolicyBuildWorkflowOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
