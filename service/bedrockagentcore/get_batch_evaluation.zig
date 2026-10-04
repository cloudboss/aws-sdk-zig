const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceConfig = @import("data_source_config.zig").DataSourceConfig;
const EvaluationJobResults = @import("evaluation_job_results.zig").EvaluationJobResults;
const Evaluator = @import("evaluator.zig").Evaluator;
const ExecutionSummaryClusteringResultContent = @import("execution_summary_clustering_result_content.zig").ExecutionSummaryClusteringResultContent;
const FailureAnalysisResultContent = @import("failure_analysis_result_content.zig").FailureAnalysisResultContent;
const Insight = @import("insight.zig").Insight;
const OutputConfig = @import("output_config.zig").OutputConfig;
const BatchEvaluationStatus = @import("batch_evaluation_status.zig").BatchEvaluationStatus;
const UserIntentClusteringResultContent = @import("user_intent_clustering_result_content.zig").UserIntentClusteringResultContent;

pub const GetBatchEvaluationInput = struct {
    /// The unique identifier of the batch evaluation to retrieve.
    batch_evaluation_id: []const u8,

    pub const json_field_names = .{
        .batch_evaluation_id = "batchEvaluationId",
    };
};

pub const GetBatchEvaluationOutput = struct {
    /// The Amazon Resource Name (ARN) of the batch evaluation.
    batch_evaluation_arn: []const u8,

    /// The unique identifier of the batch evaluation.
    batch_evaluation_id: []const u8,

    /// The name of the batch evaluation.
    batch_evaluation_name: []const u8,

    /// The timestamp when the batch evaluation was created.
    created_at: i64,

    /// The data source configuration specifying where agent traces are pulled from.
    data_source_config: ?DataSourceConfig = null,

    /// The description of the batch evaluation.
    description: ?[]const u8 = null,

    /// The error details if the batch evaluation encountered failures.
    error_details: ?[]const []const u8 = null,

    /// The aggregated evaluation results, including session completion counts and
    /// evaluator score summaries.
    evaluation_results: ?EvaluationJobResults = null,

    /// The list of evaluators applied during the batch evaluation.
    evaluators: ?[]const Evaluator = null,

    /// The execution summary clustering results from insights, containing grouped
    /// execution patterns across evaluated sessions.
    execution_summary_result: ?ExecutionSummaryClusteringResultContent = null,

    /// The failure analysis results from insights, containing categorized failure
    /// clusters with root causes and recommendations.
    failure_analysis_result: ?FailureAnalysisResultContent = null,

    /// The list of insight analyses applied during the batch evaluation.
    insights: ?[]const Insight = null,

    /// The ARN of the KMS key used to encrypt evaluation data.
    kms_key_arn: ?[]const u8 = null,

    /// The output configuration specifying where evaluation results are written.
    output_config: ?OutputConfig = null,

    /// The current status of the batch evaluation.
    status: BatchEvaluationStatus,

    /// The timestamp when the batch evaluation was last updated.
    updated_at: ?i64 = null,

    /// The user intent clustering results from insights, containing grouped user
    /// intents across evaluated sessions.
    user_intent_result: ?UserIntentClusteringResultContent = null,

    pub const json_field_names = .{
        .batch_evaluation_arn = "batchEvaluationArn",
        .batch_evaluation_id = "batchEvaluationId",
        .batch_evaluation_name = "batchEvaluationName",
        .created_at = "createdAt",
        .data_source_config = "dataSourceConfig",
        .description = "description",
        .error_details = "errorDetails",
        .evaluation_results = "evaluationResults",
        .evaluators = "evaluators",
        .execution_summary_result = "executionSummaryResult",
        .failure_analysis_result = "failureAnalysisResult",
        .insights = "insights",
        .kms_key_arn = "kmsKeyArn",
        .output_config = "outputConfig",
        .status = "status",
        .updated_at = "updatedAt",
        .user_intent_result = "userIntentResult",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBatchEvaluationInput, options: CallOptions) !GetBatchEvaluationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBatchEvaluationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore", "Bedrock AgentCore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/evaluations/batch-evaluate/");
    try path_buf.appendSlice(allocator, input.batch_evaluation_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBatchEvaluationOutput {
    const result: GetBatchEvaluationOutput = try aws.json.parseJsonObject(
        GetBatchEvaluationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
