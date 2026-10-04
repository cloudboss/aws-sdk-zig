const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomMetricType = @import("custom_metric_type.zig").CustomMetricType;

pub const DescribeCustomMetricInput = struct {
    /// The name of the custom metric.
    metric_name: []const u8,

    pub const json_field_names = .{
        .metric_name = "metricName",
    };
};

pub const DescribeCustomMetricOutput = struct {
    /// The creation date of the custom metric in milliseconds since epoch.
    creation_date: ?i64 = null,

    /// Field represents a friendly name in the console for the custom metric;
    /// doesn't have to be unique. Don't use this name as the metric identifier in
    /// the device metric report. Can be updated.
    display_name: ?[]const u8 = null,

    /// The time the custom metric was last modified in milliseconds since epoch.
    last_modified_date: ?i64 = null,

    /// The Amazon Resource Number (ARN) of the custom metric.
    metric_arn: ?[]const u8 = null,

    /// The name of the custom metric.
    metric_name: ?[]const u8 = null,

    /// The type of the custom metric.
    ///
    /// The type `number` only takes a single metric value as an input, but while
    /// submitting the metrics value in the DeviceMetrics report, it must be passed
    /// as an array with a single value.
    metric_type: ?CustomMetricType = null,

    pub const json_field_names = .{
        .creation_date = "creationDate",
        .display_name = "displayName",
        .last_modified_date = "lastModifiedDate",
        .metric_arn = "metricArn",
        .metric_name = "metricName",
        .metric_type = "metricType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeCustomMetricInput, options: CallOptions) !DescribeCustomMetricOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iot", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeCustomMetricInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/custom-metric/");
    try path_buf.appendSlice(allocator, input.metric_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeCustomMetricOutput {
    var result: DescribeCustomMetricOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeCustomMetricOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
