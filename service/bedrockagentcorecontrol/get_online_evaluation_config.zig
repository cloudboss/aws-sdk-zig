const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ClusteringConfig = @import("clustering_config.zig").ClusteringConfig;
const DataSourceConfig = @import("data_source_config.zig").DataSourceConfig;
const EvaluatorReference = @import("evaluator_reference.zig").EvaluatorReference;
const OnlineEvaluationExecutionStatus = @import("online_evaluation_execution_status.zig").OnlineEvaluationExecutionStatus;
const Insight = @import("insight.zig").Insight;
const OutputConfig = @import("output_config.zig").OutputConfig;
const Rule = @import("rule.zig").Rule;
const OnlineEvaluationConfigStatus = @import("online_evaluation_config_status.zig").OnlineEvaluationConfigStatus;

pub const GetOnlineEvaluationConfigInput = struct {
    /// The unique identifier of the online evaluation configuration to retrieve.
    online_evaluation_config_id: []const u8,

    pub const json_field_names = .{
        .online_evaluation_config_id = "onlineEvaluationConfigId",
    };
};

pub const GetOnlineEvaluationConfigOutput = struct {
    /// The clustering configuration for periodic batch evaluation.
    clustering_config: ?ClusteringConfig = null,

    /// The timestamp when the online evaluation configuration was created.
    created_at: i64,

    /// The data source configuration specifying CloudWatch log groups and service
    /// names to monitor.
    data_source_config: ?DataSourceConfig = null,

    /// The description of the online evaluation configuration.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role used for evaluation
    /// execution.
    evaluation_execution_role_arn: ?[]const u8 = null,

    /// The list of evaluators applied during online evaluation.
    evaluators: ?[]const EvaluatorReference = null,

    /// The execution status indicating whether the online evaluation is currently
    /// running.
    execution_status: OnlineEvaluationExecutionStatus,

    /// The reason for failure if the online evaluation configuration execution
    /// failed.
    failure_reason: ?[]const u8 = null,

    /// The list of insight types configured for this evaluation.
    insights: ?[]const Insight = null,

    /// The Amazon Resource Name (ARN) of the online evaluation configuration.
    online_evaluation_config_arn: []const u8,

    /// The unique identifier of the online evaluation configuration.
    online_evaluation_config_id: []const u8,

    /// The name of the online evaluation configuration.
    online_evaluation_config_name: []const u8,

    /// The output configuration specifying where evaluation results are written.
    output_config: ?OutputConfig = null,

    /// The evaluation rule containing sampling configuration, filters, and session
    /// settings.
    rule: ?Rule = null,

    /// The status of the online evaluation configuration.
    status: OnlineEvaluationConfigStatus,

    /// The timestamp when the online evaluation configuration was last updated.
    updated_at: i64,

    pub const json_field_names = .{
        .clustering_config = "clusteringConfig",
        .created_at = "createdAt",
        .data_source_config = "dataSourceConfig",
        .description = "description",
        .evaluation_execution_role_arn = "evaluationExecutionRoleArn",
        .evaluators = "evaluators",
        .execution_status = "executionStatus",
        .failure_reason = "failureReason",
        .insights = "insights",
        .online_evaluation_config_arn = "onlineEvaluationConfigArn",
        .online_evaluation_config_id = "onlineEvaluationConfigId",
        .online_evaluation_config_name = "onlineEvaluationConfigName",
        .output_config = "outputConfig",
        .rule = "rule",
        .status = "status",
        .updated_at = "updatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOnlineEvaluationConfigInput, options: CallOptions) !GetOnlineEvaluationConfigOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOnlineEvaluationConfigInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("bedrock-agentcore-control", "Bedrock AgentCore Control", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/online-evaluation-configs/");
    try path_buf.appendSlice(allocator, input.online_evaluation_config_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOnlineEvaluationConfigOutput {
    const result: GetOnlineEvaluationConfigOutput = try aws.json.parseJsonObject(
        GetOnlineEvaluationConfigOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
