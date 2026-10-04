const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RawMetricData = @import("raw_metric_data.zig").RawMetricData;
const BatchPutMetricsError = @import("batch_put_metrics_error.zig").BatchPutMetricsError;

pub const BatchPutMetricsInput = struct {
    /// A list of raw metric values to put.
    metric_data: []const RawMetricData,

    /// The name of the Trial Component to associate with the metrics. The Trial
    /// Component name must be entirely lowercase.
    trial_component_name: []const u8,

    pub const json_field_names = .{
        .metric_data = "MetricData",
        .trial_component_name = "TrialComponentName",
    };
};

pub const BatchPutMetricsOutput = struct {
    /// Lists any errors that occur when inserting metric data.
    errors: ?[]const BatchPutMetricsError = null,

    pub const json_field_names = .{
        .errors = "Errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchPutMetricsInput, options: CallOptions) !BatchPutMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchPutMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("metrics.sagemaker", "SageMaker Metrics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/BatchPutMetrics";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MetricData\":");
    try aws.json.writeValue(@TypeOf(input.metric_data), input.metric_data, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TrialComponentName\":");
    try aws.json.writeValue(@TypeOf(input.trial_component_name), input.trial_component_name, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchPutMetricsOutput {
    const result: BatchPutMetricsOutput = try aws.json.parseJsonObject(
        BatchPutMetricsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
