const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricCalculation = @import("metric_calculation.zig").MetricCalculation;
const TrendIndicator = @import("trend_indicator.zig").TrendIndicator;
const MetricUnit = @import("metric_unit.zig").MetricUnit;

pub const UpdateMetricContentInput = struct {
    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The updated calculation definition for the metric.
    metric_calculation: ?MetricCalculation = null,

    /// The identifier of the metric to update. Adding the `$SAVED` qualifier will
    /// update the saved version of the metric. Adding `$LATEST` or omitting a
    /// qualifier will update the published version.
    metric_id: []const u8,

    /// How an increase in the metric value should be interpreted. Valid values:
    /// `POSITIVE`, `NEUTRAL`, `NEGATIVE`.
    positive_trend_indicator: ?TrendIndicator = null,

    /// The updated display unit for the metric.
    unit: ?MetricUnit = null,

    pub const json_field_names = .{
        .instance_id = "InstanceId",
        .metric_calculation = "MetricCalculation",
        .metric_id = "MetricId",
        .positive_trend_indicator = "PositiveTrendIndicator",
        .unit = "Unit",
    };
};

pub const UpdateMetricContentOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMetricContentInput, options: CallOptions) !UpdateMetricContentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMetricContentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/metrics/definitions/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.metric_id);
    try path_buf.appendSlice(allocator, "/content");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.metric_calculation) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MetricCalculation\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.positive_trend_indicator) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PositiveTrendIndicator\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.unit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Unit\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMetricContentOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateMetricContentOutput = .{};

    return result;
}
