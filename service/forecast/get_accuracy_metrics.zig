const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AutoMLOverrideStrategy = @import("auto_ml_override_strategy.zig").AutoMLOverrideStrategy;
const OptimizationMetric = @import("optimization_metric.zig").OptimizationMetric;
const EvaluationResult = @import("evaluation_result.zig").EvaluationResult;

pub const GetAccuracyMetricsInput = struct {
    /// The Amazon Resource Name (ARN) of the predictor to get metrics for.
    predictor_arn: []const u8,

    pub const json_field_names = .{
        .predictor_arn = "PredictorArn",
    };
};

pub const GetAccuracyMetricsOutput = struct {
    /// The `LatencyOptimized` AutoML override strategy is only available in private
    /// beta.
    /// Contact Amazon Web Services Support or your account manager to learn more
    /// about access privileges.
    ///
    /// The AutoML strategy used to train the predictor. Unless `LatencyOptimized`
    /// is specified, the AutoML strategy optimizes predictor accuracy.
    ///
    /// This parameter is only valid for predictors trained using AutoML.
    auto_ml_override_strategy: ?AutoMLOverrideStrategy = null,

    /// Whether the predictor was created with CreateAutoPredictor.
    is_auto_predictor: ?bool = null,

    /// The accuracy metric used to optimize the predictor.
    optimization_metric: ?OptimizationMetric = null,

    /// An array of results from evaluating the predictor.
    predictor_evaluation_results: ?[]const EvaluationResult = null,

    pub const json_field_names = .{
        .auto_ml_override_strategy = "AutoMLOverrideStrategy",
        .is_auto_predictor = "IsAutoPredictor",
        .optimization_metric = "OptimizationMetric",
        .predictor_evaluation_results = "PredictorEvaluationResults",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAccuracyMetricsInput, options: CallOptions) !GetAccuracyMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "forecast", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAccuracyMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("forecast", "forecast", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonForecast.GetAccuracyMetrics");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAccuracyMetricsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetAccuracyMetricsOutput, body, allocator);
}
