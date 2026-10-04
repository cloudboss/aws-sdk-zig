const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EvaluatorConfig = @import("evaluator_config.zig").EvaluatorConfig;
const EvaluatorLevel = @import("evaluator_level.zig").EvaluatorLevel;
const EvaluatorStatus = @import("evaluator_status.zig").EvaluatorStatus;

pub const CreateEvaluatorInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The description of the evaluator that explains its purpose and evaluation
    /// criteria.
    description: ?[]const u8 = null,

    /// The configuration for the evaluator. Specify either LLM-as-a-Judge settings
    /// with instructions, rating scale, and model configuration, or code-based
    /// settings with a customer-managed Lambda function.
    evaluator_config: EvaluatorConfig,

    /// The name of the evaluator. Must be unique within your account.
    evaluator_name: []const u8,

    /// The Amazon Resource Name (ARN) of a customer managed KMS key to use for
    /// encrypting sensitive evaluator data, including instructions and rating
    /// scale. If you don't specify a KMS key, the evaluator data is encrypted with
    /// an Amazon Web Services owned key. Only symmetric encryption KMS keys are
    /// supported. For more information, see [Encryption at rest for AgentCore
    /// Evaluations](https://docs.aws.amazon.com/bedrock-agentcore/latest/devguide/evaluations-encryption.html).
    kms_key_arn: ?[]const u8 = null,

    /// The evaluation level that determines the scope of evaluation. Valid values
    /// are `TOOL_CALL` for individual tool invocations, `TRACE` for single
    /// request-response interactions, or `SESSION` for entire conversation
    /// sessions.
    level: EvaluatorLevel,

    /// A map of tag keys and values to assign to an AgentCore Evaluator. Tags
    /// enable you to categorize your resources in different ways, for example, by
    /// purpose, owner, or environment.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .evaluator_config = "evaluatorConfig",
        .evaluator_name = "evaluatorName",
        .kms_key_arn = "kmsKeyArn",
        .level = "level",
        .tags = "tags",
    };
};

pub const CreateEvaluatorOutput = struct {
    /// The timestamp when the evaluator was created.
    created_at: i64,

    /// The Amazon Resource Name (ARN) of the created evaluator.
    evaluator_arn: []const u8,

    /// The unique identifier of the created evaluator.
    evaluator_id: []const u8,

    /// The status of the evaluator creation operation.
    status: EvaluatorStatus,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .evaluator_arn = "evaluatorArn",
        .evaluator_id = "evaluatorId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateEvaluatorInput, options: CallOptions) !CreateEvaluatorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateEvaluatorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/evaluators/create";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"evaluatorConfig\":");
    try aws.json.writeValue(@TypeOf(input.evaluator_config), input.evaluator_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"evaluatorName\":");
    try aws.json.writeValue(@TypeOf(input.evaluator_name), input.evaluator_name, allocator, &body_buf);
    has_prev = true;
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"level\":");
    try aws.json.writeValue(@TypeOf(input.level), input.level, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateEvaluatorOutput {
    const result: CreateEvaluatorOutput = try aws.json.parseJsonObject(
        CreateEvaluatorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
