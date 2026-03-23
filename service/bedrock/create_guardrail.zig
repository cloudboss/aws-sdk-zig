const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const GuardrailAutomatedReasoningPolicyConfig = @import("guardrail_automated_reasoning_policy_config.zig").GuardrailAutomatedReasoningPolicyConfig;
const GuardrailContentPolicyConfig = @import("guardrail_content_policy_config.zig").GuardrailContentPolicyConfig;
const GuardrailContextualGroundingPolicyConfig = @import("guardrail_contextual_grounding_policy_config.zig").GuardrailContextualGroundingPolicyConfig;
const GuardrailCrossRegionConfig = @import("guardrail_cross_region_config.zig").GuardrailCrossRegionConfig;
const GuardrailSensitiveInformationPolicyConfig = @import("guardrail_sensitive_information_policy_config.zig").GuardrailSensitiveInformationPolicyConfig;
const Tag = @import("tag.zig").Tag;
const GuardrailTopicPolicyConfig = @import("guardrail_topic_policy_config.zig").GuardrailTopicPolicyConfig;
const GuardrailWordPolicyConfig = @import("guardrail_word_policy_config.zig").GuardrailWordPolicyConfig;

pub const CreateGuardrailInput = struct {
    /// Optional configuration for integrating Automated Reasoning policies with the
    /// new guardrail.
    automated_reasoning_policy_config: ?GuardrailAutomatedReasoningPolicyConfig = null,

    /// The message to return when the guardrail blocks a prompt.
    blocked_input_messaging: []const u8,

    /// The message to return when the guardrail blocks a model response.
    blocked_outputs_messaging: []const u8,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than once. If this token matches a previous request, Amazon Bedrock
    /// ignores the request, but does not return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html) in the *Amazon S3 User Guide*.
    client_request_token: ?[]const u8 = null,

    /// The content filter policies to configure for the guardrail.
    content_policy_config: ?GuardrailContentPolicyConfig = null,

    /// The contextual grounding policy configuration used to create a guardrail.
    contextual_grounding_policy_config: ?GuardrailContextualGroundingPolicyConfig = null,

    /// The system-defined guardrail profile that you're using with your guardrail.
    /// Guardrail profiles define the destination Amazon Web Services Regions where
    /// guardrail inference requests can be automatically routed.
    ///
    /// For more information, see the [Amazon Bedrock User
    /// Guide](https://docs.aws.amazon.com/bedrock/latest/userguide/guardrails-cross-region.html).
    cross_region_config: ?GuardrailCrossRegionConfig = null,

    /// A description of the guardrail.
    description: ?[]const u8 = null,

    /// The ARN of the KMS key that you use to encrypt the guardrail.
    kms_key_id: ?[]const u8 = null,

    /// The name to give the guardrail.
    name: []const u8,

    /// The sensitive information policy to configure for the guardrail.
    sensitive_information_policy_config: ?GuardrailSensitiveInformationPolicyConfig = null,

    /// The tags that you want to attach to the guardrail.
    tags: ?[]const Tag = null,

    /// The topic policies to configure for the guardrail.
    topic_policy_config: ?GuardrailTopicPolicyConfig = null,

    /// The word policy you configure for the guardrail.
    word_policy_config: ?GuardrailWordPolicyConfig = null,

    pub const json_field_names = .{
        .automated_reasoning_policy_config = "automatedReasoningPolicyConfig",
        .blocked_input_messaging = "blockedInputMessaging",
        .blocked_outputs_messaging = "blockedOutputsMessaging",
        .client_request_token = "clientRequestToken",
        .content_policy_config = "contentPolicyConfig",
        .contextual_grounding_policy_config = "contextualGroundingPolicyConfig",
        .cross_region_config = "crossRegionConfig",
        .description = "description",
        .kms_key_id = "kmsKeyId",
        .name = "name",
        .sensitive_information_policy_config = "sensitiveInformationPolicyConfig",
        .tags = "tags",
        .topic_policy_config = "topicPolicyConfig",
        .word_policy_config = "wordPolicyConfig",
    };
};

pub const CreateGuardrailOutput = struct {
    /// The time at which the guardrail was created.
    created_at: i64,

    /// The ARN of the guardrail.
    guardrail_arn: []const u8,

    /// The unique identifier of the guardrail that was created.
    guardrail_id: []const u8,

    /// The version of the guardrail that was created. This value will always be
    /// `DRAFT`.
    version: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .guardrail_arn = "guardrailArn",
        .guardrail_id = "guardrailId",
        .version = "version",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGuardrailInput, options: CallOptions) !CreateGuardrailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "amazonbedrockcontrolplaneservice");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGuardrailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock", "Bedrock", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/guardrails";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.automated_reasoning_policy_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"automatedReasoningPolicyConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"blockedInputMessaging\":");
    try aws.json.writeValue(@TypeOf(input.blocked_input_messaging), input.blocked_input_messaging, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"blockedOutputsMessaging\":");
    try aws.json.writeValue(@TypeOf(input.blocked_outputs_messaging), input.blocked_outputs_messaging, allocator, &body_buf);
    has_prev = true;
    if (input.client_request_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.content_policy_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contentPolicyConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.contextual_grounding_policy_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contextualGroundingPolicyConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.cross_region_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"crossRegionConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.sensitive_information_policy_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sensitiveInformationPolicyConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.topic_policy_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"topicPolicyConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.word_policy_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"wordPolicyConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGuardrailOutput {
    var result: CreateGuardrailOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateGuardrailOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceUnavailableException")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
