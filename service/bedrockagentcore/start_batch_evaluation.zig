const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceConfig = @import("data_source_config.zig").DataSourceConfig;
const EvaluationMetadata = @import("evaluation_metadata.zig").EvaluationMetadata;
const Evaluator = @import("evaluator.zig").Evaluator;
const Insight = @import("insight.zig").Insight;
const OutputConfig = @import("output_config.zig").OutputConfig;
const BatchEvaluationStatus = @import("batch_evaluation_status.zig").BatchEvaluationStatus;

pub const StartBatchEvaluationInput = struct {
    /// The name of the batch evaluation. Must be unique within your account.
    batch_evaluation_name: []const u8,

    /// A unique, case-sensitive identifier to ensure that the API request completes
    /// no more than one time. If this token matches a previous request, the service
    /// ignores the request, but does not return an error.
    client_token: ?[]const u8 = null,

    /// The data source configuration that specifies where to pull agent session
    /// traces from for evaluation.
    data_source_config: DataSourceConfig,

    /// The description of the batch evaluation.
    description: ?[]const u8 = null,

    /// Optional metadata for the evaluation, including session-specific ground
    /// truth data and test scenario identifiers.
    evaluation_metadata: ?EvaluationMetadata = null,

    /// The list of evaluators to apply during the batch evaluation. Can include
    /// both built-in evaluators and custom evaluators. Maximum of 10 evaluators.
    evaluators: ?[]const Evaluator = null,

    /// The list of insight analyses to run against sessions during the batch
    /// evaluation. Maximum of 10 insights.
    insights: ?[]const Insight = null,

    /// The ARN of the KMS key used to encrypt evaluation data. If provided,
    /// customer data is encrypted at rest with the specified key.
    kms_key_arn: ?[]const u8 = null,

    output_config: ?OutputConfig = null,

    /// A map of tag keys and values to associate with the batch evaluation.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .batch_evaluation_name = "batchEvaluationName",
        .client_token = "clientToken",
        .data_source_config = "dataSourceConfig",
        .description = "description",
        .evaluation_metadata = "evaluationMetadata",
        .evaluators = "evaluators",
        .insights = "insights",
        .kms_key_arn = "kmsKeyArn",
        .output_config = "outputConfig",
        .tags = "tags",
    };
};

pub const StartBatchEvaluationOutput = struct {
    /// The Amazon Resource Name (ARN) of the created batch evaluation.
    batch_evaluation_arn: []const u8,

    /// The unique identifier of the created batch evaluation.
    batch_evaluation_id: []const u8,

    /// The name of the batch evaluation.
    batch_evaluation_name: []const u8,

    /// The timestamp when the batch evaluation was created.
    created_at: i64,

    /// The description of the batch evaluation.
    description: ?[]const u8 = null,

    /// The list of evaluators applied during the batch evaluation.
    evaluators: ?[]const Evaluator = null,

    /// The list of insight analyses applied during the batch evaluation.
    insights: ?[]const Insight = null,

    /// The ARN of the KMS key used to encrypt evaluation data.
    kms_key_arn: ?[]const u8 = null,

    /// The output configuration specifying where evaluation results are written.
    output_config: ?OutputConfig = null,

    /// The status of the batch evaluation.
    status: BatchEvaluationStatus,

    /// The tags associated with the batch evaluation.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .batch_evaluation_arn = "batchEvaluationArn",
        .batch_evaluation_id = "batchEvaluationId",
        .batch_evaluation_name = "batchEvaluationName",
        .created_at = "createdAt",
        .description = "description",
        .evaluators = "evaluators",
        .insights = "insights",
        .kms_key_arn = "kmsKeyArn",
        .output_config = "outputConfig",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartBatchEvaluationInput, options: CallOptions) !StartBatchEvaluationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartBatchEvaluationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/evaluations/batch-evaluate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"batchEvaluationName\":");
    try aws.json.writeValue(@TypeOf(input.batch_evaluation_name), input.batch_evaluation_name, allocator, &body_buf);
    has_prev = true;
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"dataSourceConfig\":");
    try aws.json.writeValue(@TypeOf(input.data_source_config), input.data_source_config, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.evaluation_metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evaluationMetadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.evaluators) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"evaluators\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.insights) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"insights\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"kmsKeyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.output_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"outputConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartBatchEvaluationOutput {
    const result: StartBatchEvaluationOutput = try aws.json.parseJsonObject(
        StartBatchEvaluationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
