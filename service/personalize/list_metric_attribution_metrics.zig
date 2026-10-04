const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricAttribute = @import("metric_attribute.zig").MetricAttribute;

pub const ListMetricAttributionMetricsInput = struct {
    /// The maximum number of metrics to return in one page of results.
    max_results: ?i32 = null,

    /// The Amazon Resource Name (ARN) of the metric attribution to retrieve
    /// attributes for.
    metric_attribution_arn: ?[]const u8 = null,

    /// Specify the pagination token from a previous request to retrieve the next
    /// page of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .metric_attribution_arn = "metricAttributionArn",
        .next_token = "nextToken",
    };
};

pub const ListMetricAttributionMetricsOutput = struct {
    /// The metrics for the specified metric attribution.
    metrics: ?[]const MetricAttribute = null,

    /// Specify the pagination token from a previous
    /// `ListMetricAttributionMetricsResponse` request to retrieve the next page of
    /// results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .metrics = "metrics",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMetricAttributionMetricsInput, options: CallOptions) !ListMetricAttributionMetricsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMetricAttributionMetricsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.ListMetricAttributionMetrics");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMetricAttributionMetricsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListMetricAttributionMetricsOutput, body, allocator);
}
