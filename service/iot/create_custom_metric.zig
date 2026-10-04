const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomMetricType = @import("custom_metric_type.zig").CustomMetricType;
const Tag = @import("tag.zig").Tag;

pub const CreateCustomMetricInput = struct {
    /// Each custom
    /// metric must have a unique client request token. If you try to create a new
    /// custom metric that
    /// already exists with a different token,
    /// an exception
    /// occurs. If you omit this value, Amazon Web Services SDKs will automatically
    /// generate a unique client request.
    client_request_token: []const u8,

    /// The friendly name in the console for the custom metric. This name doesn't
    /// have to be
    /// unique. Don't use this name as the metric identifier in the device metric
    /// report. You can
    /// update the friendly name after you define it.
    display_name: ?[]const u8 = null,

    /// The name of the custom metric. This will be used in the metric report
    /// submitted from the
    /// device/thing. The name can't begin with `aws:`. You can't change the name
    /// after you
    /// define it.
    metric_name: []const u8,

    /// The type of the custom metric.
    ///
    /// The type `number` only takes a single metric value as an input, but when you
    /// submit the metrics value in the DeviceMetrics report, you must pass it as an
    /// array with a
    /// single value.
    metric_type: CustomMetricType,

    /// Metadata that can be used to manage the custom metric.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .display_name = "displayName",
        .metric_name = "metricName",
        .metric_type = "metricType",
        .tags = "tags",
    };
};

pub const CreateCustomMetricOutput = struct {
    /// The Amazon Resource Number (ARN) of the custom metric. For example,
    /// `arn:*aws-partition*:iot:*region*:*accountId*:custommetric/*metricName*
    /// `
    metric_arn: ?[]const u8 = null,

    /// The name of the custom metric to be used in the metric report.
    metric_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_arn = "metricArn",
        .metric_name = "metricName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCustomMetricInput, options: CallOptions) !CreateCustomMetricOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCustomMetricInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/custom-metric/");
    try path_buf.appendSlice(allocator, input.metric_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (input.display_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"displayName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"metricType\":");
    try aws.json.writeValue(@TypeOf(input.metric_type), input.metric_type, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCustomMetricOutput {
    var result: CreateCustomMetricOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateCustomMetricOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
