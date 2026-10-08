const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetricDatum = @import("metric_datum.zig").MetricDatum;

pub const PublishMetricsInput = struct {
    /// **Internal only**. The name of the environment.
    environment_name: []const u8,

    /// **Internal only**. Publishes metrics to Amazon CloudWatch. To learn more
    /// about the metrics published to Amazon CloudWatch, see [Amazon MWAA
    /// performance metrics in Amazon
    /// CloudWatch](https://docs.aws.amazon.com/mwaa/latest/userguide/cw-metrics.html).
    metric_data: []const MetricDatum,

    pub const json_field_names = .{
        .environment_name = "EnvironmentName",
        .metric_data = "MetricData",
    };
};

pub const PublishMetricsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PublishMetricsInput, options: CallOptions) !PublishMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "airflow", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PublishMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("airflow", "MWAA", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/metrics/environments/");
    try path_buf.appendSlice(allocator, input.environment_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"MetricData\":");
    try aws.json.writeValue(@TypeOf(input.metric_data), input.metric_data, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PublishMetricsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: PublishMetricsOutput = .{};

    return result;
}
