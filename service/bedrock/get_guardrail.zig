const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GuardrailAutomatedReasoningPolicy = @import("guardrail_automated_reasoning_policy.zig").GuardrailAutomatedReasoningPolicy;
const GuardrailContentPolicy = @import("guardrail_content_policy.zig").GuardrailContentPolicy;
const GuardrailContextualGroundingPolicy = @import("guardrail_contextual_grounding_policy.zig").GuardrailContextualGroundingPolicy;
const GuardrailCrossRegionDetails = @import("guardrail_cross_region_details.zig").GuardrailCrossRegionDetails;
const GuardrailSensitiveInformationPolicy = @import("guardrail_sensitive_information_policy.zig").GuardrailSensitiveInformationPolicy;
const GuardrailStatus = @import("guardrail_status.zig").GuardrailStatus;
const GuardrailTopicPolicy = @import("guardrail_topic_policy.zig").GuardrailTopicPolicy;
const GuardrailWordPolicy = @import("guardrail_word_policy.zig").GuardrailWordPolicy;

pub const GetGuardrailInput = struct {
    /// The unique identifier of the guardrail for which to get details. This can be
    /// an ID or the ARN.
    guardrail_identifier: []const u8,

    /// The version of the guardrail for which to get details. If you don't specify
    /// a version, the response returns details for the `DRAFT` version.
    guardrail_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .guardrail_identifier = "guardrailIdentifier",
        .guardrail_version = "guardrailVersion",
    };
};

pub const GetGuardrailOutput = struct {
    /// The current Automated Reasoning policy configuration for the guardrail, if
    /// any is configured.
    automated_reasoning_policy: ?GuardrailAutomatedReasoningPolicy = null,

    /// The message that the guardrail returns when it blocks a prompt.
    blocked_input_messaging: []const u8,

    /// The message that the guardrail returns when it blocks a model response.
    blocked_outputs_messaging: []const u8,

    /// The content policy that was configured for the guardrail.
    content_policy: ?GuardrailContentPolicy = null,

    /// The contextual grounding policy used in the guardrail.
    contextual_grounding_policy: ?GuardrailContextualGroundingPolicy = null,

    /// The date and time at which the guardrail was created.
    created_at: i64,

    /// Details about the system-defined guardrail profile that you're using with
    /// your guardrail, including the guardrail profile ID and Amazon Resource Name
    /// (ARN).
    cross_region_details: ?GuardrailCrossRegionDetails = null,

    /// The description of the guardrail.
    description: ?[]const u8 = null,

    /// Appears if the `status` of the guardrail is `FAILED`. A list of
    /// recommendations to carry out before retrying the request.
    failure_recommendations: ?[]const []const u8 = null,

    /// The ARN of the guardrail.
    guardrail_arn: []const u8,

    /// The unique identifier of the guardrail.
    guardrail_id: []const u8,

    /// The ARN of the KMS key that encrypts the guardrail.
    kms_key_arn: ?[]const u8 = null,

    /// The name of the guardrail.
    name: []const u8,

    /// The sensitive information policy that was configured for the guardrail.
    sensitive_information_policy: ?GuardrailSensitiveInformationPolicy = null,

    /// The status of the guardrail.
    status: GuardrailStatus,

    /// Appears if the `status` is `FAILED`. A list of reasons for why the guardrail
    /// failed to be created, updated, versioned, or deleted.
    status_reasons: ?[]const []const u8 = null,

    /// The topic policy that was configured for the guardrail.
    topic_policy: ?GuardrailTopicPolicy = null,

    /// The date and time at which the guardrail was updated.
    updated_at: i64,

    /// The version of the guardrail.
    version: []const u8,

    /// The word policy that was configured for the guardrail.
    word_policy: ?GuardrailWordPolicy = null,

    pub const json_field_names = .{
        .automated_reasoning_policy = "automatedReasoningPolicy",
        .blocked_input_messaging = "blockedInputMessaging",
        .blocked_outputs_messaging = "blockedOutputsMessaging",
        .content_policy = "contentPolicy",
        .contextual_grounding_policy = "contextualGroundingPolicy",
        .created_at = "createdAt",
        .cross_region_details = "crossRegionDetails",
        .description = "description",
        .failure_recommendations = "failureRecommendations",
        .guardrail_arn = "guardrailArn",
        .guardrail_id = "guardrailId",
        .kms_key_arn = "kmsKeyArn",
        .name = "name",
        .sensitive_information_policy = "sensitiveInformationPolicy",
        .status = "status",
        .status_reasons = "statusReasons",
        .topic_policy = "topicPolicy",
        .updated_at = "updatedAt",
        .version = "version",
        .word_policy = "wordPolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGuardrailInput, options: CallOptions) !GetGuardrailOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGuardrailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/guardrails/");
    try path_buf.appendSlice(allocator, input.guardrail_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.guardrail_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "guardrailVersion=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGuardrailOutput {
    const result: GetGuardrailOutput = try aws.json.parseJsonObject(
        GetGuardrailOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
