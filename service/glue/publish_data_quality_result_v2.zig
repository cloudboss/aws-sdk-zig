const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataQualityAggregatedMetrics = @import("data_quality_aggregated_metrics.zig").DataQualityAggregatedMetrics;
const DataQualityAnalyzerResult = @import("data_quality_analyzer_result.zig").DataQualityAnalyzerResult;
const DataQualityObservation = @import("data_quality_observation.zig").DataQualityObservation;
const DataQualityRuleResult = @import("data_quality_rule_result.zig").DataQualityRuleResult;
const DataQualityConfigurationV2 = @import("data_quality_configuration_v2.zig").DataQualityConfigurationV2;
const StatisticSummary = @import("statistic_summary.zig").StatisticSummary;
const DataQualityTelemetry = @import("data_quality_telemetry.zig").DataQualityTelemetry;

pub const PublishDataQualityResultV2Input = struct {
    /// The aggregated metrics for the result.
    aggregated_metrics: ?DataQualityAggregatedMetrics = null,

    /// The analyzer level results.
    analyzer_results: ?[]const DataQualityAnalyzerResult = null,

    /// The client token for the request.
    client_token: ?[]const u8 = null,

    /// The security configuration for the result.
    data_quality_security_configuration: ?[]const u8 = null,

    /// The descriptors for the result.
    descriptors: ?[]const aws.map.StringMapEntry = null,

    /// The dimensions for the result.
    dimensions: []const aws.map.StringMapEntry,

    /// The evaluation context for the result.
    evaluation_context: []const u8,

    /// The time execution completed for the result.
    execution_completed_on: ?i64 = null,

    /// The time execution started for the result.
    execution_started_on: ?i64 = null,

    /// The observations for the result.
    observations: ?[]const DataQualityObservation = null,

    /// The rule level results.
    rule_results: []const DataQualityRuleResult,

    /// The ruleset name for the result.
    ruleset_name: ?[]const u8 = null,

    /// The run configuration for the result.
    run_configuration: ?DataQualityConfigurationV2 = null,

    /// The score for the result.
    score: f64,

    /// The statistics for the result.
    statistics: ?[]const StatisticSummary = null,

    /// The tags for the result.
    tags: ?[]const aws.map.StringMapEntry = null,

    telemetry: ?DataQualityTelemetry = null,

    pub const json_field_names = .{
        .aggregated_metrics = "AggregatedMetrics",
        .analyzer_results = "AnalyzerResults",
        .client_token = "ClientToken",
        .data_quality_security_configuration = "DataQualitySecurityConfiguration",
        .descriptors = "Descriptors",
        .dimensions = "Dimensions",
        .evaluation_context = "EvaluationContext",
        .execution_completed_on = "ExecutionCompletedOn",
        .execution_started_on = "ExecutionStartedOn",
        .observations = "Observations",
        .rule_results = "RuleResults",
        .ruleset_name = "RulesetName",
        .run_configuration = "RunConfiguration",
        .score = "Score",
        .statistics = "Statistics",
        .tags = "Tags",
        .telemetry = "Telemetry",
    };
};

pub const PublishDataQualityResultV2Output = struct {
    /// The ID of the result.
    result_id: []const u8,

    pub const json_field_names = .{
        .result_id = "ResultId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishDataQualityResultV2Input, options: CallOptions) !PublishDataQualityResultV2Output {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishDataQualityResultV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.PublishDataQualityResultV2");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishDataQualityResultV2Output {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(PublishDataQualityResultV2Output, body, allocator);
}
