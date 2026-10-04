const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationPreferences = @import("recommendation_preferences.zig").RecommendationPreferences;
const MetricStatistic = @import("metric_statistic.zig").MetricStatistic;
const RDSDatabaseRecommendedOptionProjectedMetric = @import("rds_database_recommended_option_projected_metric.zig").RDSDatabaseRecommendedOptionProjectedMetric;

pub const GetRDSDatabaseRecommendationProjectedMetricsInput = struct {
    /// The timestamp of the last projected metrics data point to return.
    end_time: i64,

    /// The granularity, in seconds, of the projected metrics data points.
    period: ?i32 = null,

    recommendation_preferences: ?RecommendationPreferences = null,

    /// The ARN that identifies the Amazon Aurora or RDS database.
    ///
    /// The following is the format of the ARN:
    ///
    /// `arn:aws:rds:{region}:{accountId}:db:{resourceName}`
    resource_arn: []const u8,

    /// The timestamp of the first projected metrics data point to return.
    start_time: i64,

    /// The statistic of the projected metrics.
    stat: MetricStatistic,

    pub const json_field_names = .{
        .end_time = "endTime",
        .period = "period",
        .recommendation_preferences = "recommendationPreferences",
        .resource_arn = "resourceArn",
        .start_time = "startTime",
        .stat = "stat",
    };
};

pub const GetRDSDatabaseRecommendationProjectedMetricsOutput = struct {
    /// An array of objects that describes the projected metrics.
    recommended_option_projected_metrics: ?[]const RDSDatabaseRecommendedOptionProjectedMetric = null,

    pub const json_field_names = .{
        .recommended_option_projected_metrics = "recommendedOptionProjectedMetrics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRDSDatabaseRecommendationProjectedMetricsInput, options: CallOptions) !GetRDSDatabaseRecommendationProjectedMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "compute-optimizer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRDSDatabaseRecommendationProjectedMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("compute-optimizer", "Compute Optimizer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.GetRDSDatabaseRecommendationProjectedMetrics");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRDSDatabaseRecommendationProjectedMetricsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetRDSDatabaseRecommendationProjectedMetricsOutput, body, allocator);
}
