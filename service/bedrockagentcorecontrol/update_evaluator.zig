const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EvaluatorConfig = @import("evaluator_config.zig").EvaluatorConfig;
const EvaluatorLevel = @import("evaluator_level.zig").EvaluatorLevel;
const EvaluatorStatus = @import("evaluator_status.zig").EvaluatorStatus;

pub const UpdateEvaluatorInput = struct {
    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If you don't specify this field, a value is randomly
    /// generated for you. If this token matches a previous request, the service
    /// ignores the request, but doesn't return an error. For more information, see
    /// [Ensuring
    /// idempotency](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Run_Instance_Idempotency.html).
    client_token: ?[]const u8 = null,

    /// The updated description of the evaluator.
    description: ?[]const u8 = null,

    /// The updated configuration for the evaluator. Specify either LLM-as-a-Judge
    /// settings with instructions, rating scale, and model configuration, or
    /// code-based settings with a customer-managed Lambda function.
    evaluator_config: ?EvaluatorConfig = null,

    /// The unique identifier of the evaluator to update.
    evaluator_id: []const u8,

    /// The Amazon Resource Name (ARN) of a customer managed KMS key to use for
    /// encrypting sensitive evaluator data. Specify a new key ARN to rotate the
    /// encryption key, or specify a key ARN to add encryption to an evaluator that
    /// was previously created without one. When you rotate to a new key, the
    /// service decrypts the existing data with the old key and re-encrypts it with
    /// the new key. Only symmetric encryption KMS keys are supported. For more
    /// information, see [Encryption at rest for AgentCore
    /// Evaluations](https://docs.aws.amazon.com/bedrock-agentcore/latest/devguide/evaluations-encryption.html).
    kms_key_arn: ?[]const u8 = null,

    /// The updated evaluation level (`TOOL_CALL`, `TRACE`, or `SESSION`) that
    /// determines the scope of evaluation.
    level: ?EvaluatorLevel = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .evaluator_config = "evaluatorConfig",
        .evaluator_id = "evaluatorId",
        .kms_key_arn = "kmsKeyArn",
        .level = "level",
    };
};

pub const UpdateEvaluatorOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated evaluator.
    evaluator_arn: []const u8,

    /// The unique identifier of the updated evaluator.
    evaluator_id: []const u8,

    /// The status of the evaluator update operation.
    status: EvaluatorStatus,

    /// The timestamp when the evaluator was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .evaluator_arn = "evaluatorArn",
        .evaluator_id = "evaluatorId",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEvaluatorInput, options: CallOptions) !UpdateEvaluatorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEvaluatorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/evaluators/");
    try path_buf.appendSlice(allocator, input.evaluator_id);
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
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.evaluator_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evaluatorConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.level) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"level\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEvaluatorOutput {
    const result: UpdateEvaluatorOutput = try aws.json.parseJsonObject(
        UpdateEvaluatorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
