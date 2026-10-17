const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataQualityAggregatedMetrics = @import("data_quality_aggregated_metrics.zig").DataQualityAggregatedMetrics;
const DataQualityAnalyzerResult = @import("data_quality_analyzer_result.zig").DataQualityAnalyzerResult;
const DataSource = @import("data_source.zig").DataSource;
const DataQualityObservation = @import("data_quality_observation.zig").DataQualityObservation;
const DataQualityRuleResult = @import("data_quality_rule_result.zig").DataQualityRuleResult;

pub const GetDataQualityResultV2Input = struct {
    /// A unique result ID for the data quality result.
    result_id: []const u8,

    pub const json_field_names = .{
        .result_id = "ResultId",
    };
};

pub const GetDataQualityResultV2Output = struct {
    /// A summary of `DataQualityAggregatedMetrics` objects showing the total counts
    /// of processed rows and rules, including their pass/fail statistics based on
    /// row-level results.
    aggregated_metrics: ?DataQualityAggregatedMetrics = null,

    /// A list of `DataQualityAnalyzerResult` objects representing the results for
    /// each analyzer.
    analyzer_results: ?[]const DataQualityAnalyzerResult = null,

    /// The table associated with the data quality result, if any.
    data_source: ?DataSource = null,

    /// A map of user-provided descriptors that add contextual metadata and
    /// configuration to the data quality result, such as database name, table name,
    /// team, or environment.
    descriptors: ?[]const aws.map.StringMapEntry = null,

    /// A map of platform-specific identifiers, such as cluster, application,
    /// workgroup, or project IDs, that identify where the data quality evaluation
    /// ran.
    dimensions: ?[]const aws.map.StringMapEntry = null,

    /// The evaluation context for the data quality result. This value identifies a
    /// specific data quality result, or a series of related results, within a run.
    evaluation_context: ?[]const u8 = null,

    /// The date and time when this data quality run completed.
    execution_completed_on: ?i64 = null,

    /// The date and time when this data quality run started.
    execution_started_on: ?i64 = null,

    /// A list of `DataQualityObservation` objects representing the anomaly
    /// detection observations generated after evaluating the rules and analyzers.
    observations: ?[]const DataQualityObservation = null,

    /// The Profile ID for the data quality result.
    profile_id: ?[]const u8 = null,

    /// A unique result ID for the data quality result.
    result_id: ?[]const u8 = null,

    /// The date and time when this data quality result was published.
    result_published_on: ?i64 = null,

    /// A list of `DataQualityRuleResult` objects representing the results for each
    /// rule.
    rule_results: ?[]const DataQualityRuleResult = null,

    /// The name of the ruleset associated with the data quality result.
    ruleset_name: ?[]const u8 = null,

    /// An aggregate data quality score. Represents the ratio of rules that passed
    /// to the total number of rules.
    score: ?f64 = null,

    /// A map of tags associated with the data quality result.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .aggregated_metrics = "AggregatedMetrics",
        .analyzer_results = "AnalyzerResults",
        .data_source = "DataSource",
        .descriptors = "Descriptors",
        .dimensions = "Dimensions",
        .evaluation_context = "EvaluationContext",
        .execution_completed_on = "ExecutionCompletedOn",
        .execution_started_on = "ExecutionStartedOn",
        .observations = "Observations",
        .profile_id = "ProfileId",
        .result_id = "ResultId",
        .result_published_on = "ResultPublishedOn",
        .rule_results = "RuleResults",
        .ruleset_name = "RulesetName",
        .score = "Score",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataQualityResultV2Input, options: CallOptions) !GetDataQualityResultV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataQualityResultV2Input, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.GetDataQualityResultV2");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataQualityResultV2Output {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDataQualityResultV2Output, body, allocator);
}
