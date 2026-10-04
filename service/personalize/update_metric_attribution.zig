const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricAttribute = @import("metric_attribute.zig").MetricAttribute;
const MetricAttributionOutput = @import("metric_attribution_output.zig").MetricAttributionOutput;

pub const UpdateMetricAttributionInput = struct {
    /// Add new metric attributes to the metric attribution.
    add_metrics: ?[]const MetricAttribute = null,

    /// The Amazon Resource Name (ARN) for the metric attribution to update.
    metric_attribution_arn: ?[]const u8 = null,

    /// An output config for the metric attribution.
    metrics_output_config: ?MetricAttributionOutput = null,

    /// Remove metric attributes from the metric attribution.
    remove_metrics: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .add_metrics = "addMetrics",
        .metric_attribution_arn = "metricAttributionArn",
        .metrics_output_config = "metricsOutputConfig",
        .remove_metrics = "removeMetrics",
    };
};

pub const UpdateMetricAttributionOutput = struct {
    /// The Amazon Resource Name (ARN) for the metric attribution that you updated.
    metric_attribution_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_attribution_arn = "metricAttributionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMetricAttributionInput, options: CallOptions) !UpdateMetricAttributionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "personalize", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMetricAttributionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.UpdateMetricAttribution");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMetricAttributionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateMetricAttributionOutput, body, allocator);
}
