const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const AgentCollaboration = @import("agent_collaboration.zig").AgentCollaboration;
const CustomOrchestration = @import("custom_orchestration.zig").CustomOrchestration;
const GuardrailConfiguration = @import("guardrail_configuration.zig").GuardrailConfiguration;
const MemoryConfiguration = @import("memory_configuration.zig").MemoryConfiguration;
const OrchestrationType = @import("orchestration_type.zig").OrchestrationType;
const PromptOverrideConfiguration = @import("prompt_override_configuration.zig").PromptOverrideConfiguration;
const Agent = @import("agent.zig").Agent;

pub const UpdateAgentInput = struct {
    /// The agent's collaboration role.
    agent_collaboration: ?AgentCollaboration = null,

    /// The unique identifier of the agent.
    agent_id: []const u8,

    /// Specifies a new name for the agent.
    agent_name: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role with permissions to invoke
    /// API operations on the agent.
    agent_resource_role_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the KMS key with which to encrypt the
    /// agent.
    customer_encryption_key_arn: ?[]const u8 = null,

    /// Contains details of the custom orchestration configured for the agent.
    custom_orchestration: ?CustomOrchestration = null,

    /// Specifies a new description of the agent.
    description: ?[]const u8 = null,

    /// The identifier for the model that you want to be used for orchestration by
    /// the agent you create.
    ///
    /// The `modelId` to provide depends on the type of model or throughput that you
    /// use:
    ///
    /// * If you use a base model, specify the model ID or its ARN. For a list of
    ///   model IDs for base models, see [Amazon Bedrock base model IDs (on-demand
    ///   throughput)](https://docs.aws.amazon.com/bedrock/latest/userguide/model-ids.html#model-ids-arns) in the Amazon Bedrock User Guide.
    /// * If you use an inference profile, specify the inference profile ID or its
    ///   ARN. For a list of inference profile IDs, see [Supported Regions and
    ///   models for cross-region
    ///   inference](https://docs.aws.amazon.com/bedrock/latest/userguide/cross-region-inference-support.html) in the Amazon Bedrock User Guide.
    /// * If you use a provisioned model, specify the ARN of the Provisioned
    ///   Throughput. For more information, see [Run inference using a Provisioned
    ///   Throughput](https://docs.aws.amazon.com/bedrock/latest/userguide/prov-thru-use.html) in the Amazon Bedrock User Guide.
    /// * If you use a custom model, first purchase Provisioned Throughput for it.
    ///   Then specify the ARN of the resulting provisioned model. For more
    ///   information, see [Use a custom model in Amazon
    ///   Bedrock](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-use.html) in the Amazon Bedrock User Guide.
    /// * If you use an [imported
    ///   model](https://docs.aws.amazon.com/bedrock/latest/userguide/model-customization-import-model.html), specify the ARN of the imported model. You can get the model ARN from a successful call to [CreateModelImportJob](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_CreateModelImportJob.html) or from the Imported models page in the Amazon Bedrock console.
    foundation_model: []const u8,

    /// The unique Guardrail configuration assigned to the agent when it is updated.
    guardrail_configuration: ?GuardrailConfiguration = null,

    /// The number of seconds for which Amazon Bedrock keeps information about a
    /// user's conversation with the agent.
    ///
    /// A user interaction remains active for the amount of time specified. If no
    /// conversation occurs during this time, the session expires and Amazon Bedrock
    /// deletes any data provided before the timeout.
    idle_session_ttl_in_seconds: ?i32 = null,

    /// Specifies new instructions that tell the agent what it should do and how it
    /// should interact with users.
    instruction: ?[]const u8 = null,

    /// Specifies the new memory configuration for the agent.
    memory_configuration: ?MemoryConfiguration = null,

    /// Specifies the type of orchestration strategy for the agent. This is set to
    /// `DEFAULT` orchestration type, by default.
    orchestration_type: ?OrchestrationType = null,

    /// Contains configurations to override prompts in different parts of an agent
    /// sequence. For more information, see [Advanced
    /// prompts](https://docs.aws.amazon.com/bedrock/latest/userguide/advanced-prompts.html).
    prompt_override_configuration: ?PromptOverrideConfiguration = null,

    pub const json_field_names = .{
        .agent_collaboration = "agentCollaboration",
        .agent_id = "agentId",
        .agent_name = "agentName",
        .agent_resource_role_arn = "agentResourceRoleArn",
        .customer_encryption_key_arn = "customerEncryptionKeyArn",
        .custom_orchestration = "customOrchestration",
        .description = "description",
        .foundation_model = "foundationModel",
        .guardrail_configuration = "guardrailConfiguration",
        .idle_session_ttl_in_seconds = "idleSessionTTLInSeconds",
        .instruction = "instruction",
        .memory_configuration = "memoryConfiguration",
        .orchestration_type = "orchestrationType",
        .prompt_override_configuration = "promptOverrideConfiguration",
    };
};

pub const UpdateAgentOutput = struct {
    /// Contains details about the agent that was updated.
    agent: ?Agent = null,

    pub const json_field_names = .{
        .agent = "agent",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAgentInput, options: Options) !UpdateAgentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "bedrockagent");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAgentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrockagent", "Bedrock Agent", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/agents/");
    try path_buf.appendSlice(allocator, input.agent_id);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.agent_collaboration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"agentCollaboration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentName\":");
    try aws.json.writeValue(@TypeOf(input.agent_name), input.agent_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"agentResourceRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.agent_resource_role_arn), input.agent_resource_role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.customer_encryption_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customerEncryptionKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.custom_orchestration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"customOrchestration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"foundationModel\":");
    try aws.json.writeValue(@TypeOf(input.foundation_model), input.foundation_model, allocator, &body_buf);
    has_prev = true;
    if (input.guardrail_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"guardrailConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.idle_session_ttl_in_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"idleSessionTTLInSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.instruction) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"instruction\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.memory_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"memoryConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.orchestration_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"orchestrationType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.prompt_override_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"promptOverrideConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAgentOutput {
    var result: UpdateAgentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateAgentOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
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
