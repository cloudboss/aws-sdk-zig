const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutomatedReasoningPolicyAnnotation = @import("automated_reasoning_policy_annotation.zig").AutomatedReasoningPolicyAnnotation;

pub const UpdateAutomatedReasoningPolicyAnnotationsInput = struct {
    /// The updated annotations containing modified rules, variables, and types for
    /// the policy.
    annotations: []const AutomatedReasoningPolicyAnnotation,

    /// The unique identifier of the build workflow whose annotations you want to
    /// update.
    build_workflow_id: []const u8,

    /// The hash value of the annotation set that you're updating. This is used for
    /// optimistic concurrency control to prevent conflicting updates.
    last_updated_annotation_set_hash: []const u8,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy whose
    /// annotations you want to update.
    policy_arn: []const u8,

    pub const json_field_names = .{
        .annotations = "annotations",
        .build_workflow_id = "buildWorkflowId",
        .last_updated_annotation_set_hash = "lastUpdatedAnnotationSetHash",
        .policy_arn = "policyArn",
    };
};

pub const UpdateAutomatedReasoningPolicyAnnotationsOutput = struct {
    /// The new hash value representing the updated state of the annotations.
    annotation_set_hash: []const u8,

    /// The unique identifier of the build workflow.
    build_workflow_id: []const u8,

    /// The Amazon Resource Name (ARN) of the Automated Reasoning policy.
    policy_arn: []const u8,

    /// The timestamp when the annotations were updated.
    updated_at: i64,

    pub const json_field_names = .{
        .annotation_set_hash = "annotationSetHash",
        .build_workflow_id = "buildWorkflowId",
        .policy_arn = "policyArn",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAutomatedReasoningPolicyAnnotationsInput, options: CallOptions) !UpdateAutomatedReasoningPolicyAnnotationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAutomatedReasoningPolicyAnnotationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/automated-reasoning-policies/");
    try path_buf.appendSlice(allocator, input.policy_arn);
    try path_buf.appendSlice(allocator, "/build-workflows/");
    try path_buf.appendSlice(allocator, input.build_workflow_id);
    try path_buf.appendSlice(allocator, "/annotations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"annotations\":");
    try aws.json.writeValue(@TypeOf(input.annotations), input.annotations, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"lastUpdatedAnnotationSetHash\":");
    try aws.json.writeValue(@TypeOf(input.last_updated_annotation_set_hash), input.last_updated_annotation_set_hash, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAutomatedReasoningPolicyAnnotationsOutput {
    var result: UpdateAutomatedReasoningPolicyAnnotationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAutomatedReasoningPolicyAnnotationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
