const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricFilter = @import("metric_filter.zig").MetricFilter;

pub const DescribeMetricFiltersInput = struct {
    /// The prefix to match. CloudWatch Logs uses the value that you set here only
    /// if you also
    /// include the `logGroupName` parameter in your request.
    filter_name_prefix: ?[]const u8 = null,

    /// The maximum number of items returned. If you don't specify a value, the
    /// default is up
    /// to 50 items.
    limit: ?i32 = null,

    /// The name of the log group.
    log_group_name: ?[]const u8 = null,

    /// Filters results to include only those with the specified metric name. If you
    /// include
    /// this parameter in your request, you must also include the `metricNamespace`
    /// parameter.
    metric_name: ?[]const u8 = null,

    /// Filters results to include only those in the specified namespace. If you
    /// include this
    /// parameter in your request, you must also include the `metricName`
    /// parameter.
    metric_namespace: ?[]const u8 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter_name_prefix = "filterNamePrefix",
        .limit = "limit",
        .log_group_name = "logGroupName",
        .metric_name = "metricName",
        .metric_namespace = "metricNamespace",
        .next_token = "nextToken",
    };
};

pub const DescribeMetricFiltersOutput = struct {
    /// The metric filters.
    metric_filters: ?[]const MetricFilter = null,

    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_filters = "metricFilters",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMetricFiltersInput, options: CallOptions) !DescribeMetricFiltersOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "logs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMetricFiltersInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("logs", "CloudWatch Logs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Logs_20140328.DescribeMetricFilters");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMetricFiltersOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeMetricFiltersOutput, body, allocator);
}
