const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AggregationType = @import("aggregation_type.zig").AggregationType;
const Tag = @import("tag.zig").Tag;
const FleetMetricUnit = @import("fleet_metric_unit.zig").FleetMetricUnit;

pub const CreateFleetMetricInput = struct {
    /// The field to aggregate.
    aggregation_field: []const u8,

    /// The type of the aggregation query.
    aggregation_type: AggregationType,

    /// The fleet metric description.
    description: ?[]const u8 = null,

    /// The name of the index to search.
    index_name: ?[]const u8 = null,

    /// The name of the fleet metric to create.
    metric_name: []const u8,

    /// The time in seconds between fleet metric emissions. Range [60(1 min),
    /// 86400(1 day)] and must be multiple of 60.
    period: i32,

    /// The search query string.
    query_string: []const u8,

    /// The query version.
    query_version: ?[]const u8 = null,

    /// Metadata, which can be used to manage the fleet metric.
    tags: ?[]const Tag = null,

    /// Used to support unit transformation such as milliseconds to seconds. The
    /// unit must be
    /// supported by [CW
    /// metric](https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_MetricDatum.html). Default to null.
    unit: ?FleetMetricUnit = null,

    pub const json_field_names = .{
        .aggregation_field = "aggregationField",
        .aggregation_type = "aggregationType",
        .description = "description",
        .index_name = "indexName",
        .metric_name = "metricName",
        .period = "period",
        .query_string = "queryString",
        .query_version = "queryVersion",
        .tags = "tags",
        .unit = "unit",
    };
};

pub const CreateFleetMetricOutput = struct {
    /// The Amazon Resource Name (ARN) of the new fleet metric.
    metric_arn: ?[]const u8 = null,

    /// The name of the fleet metric to create.
    metric_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_arn = "metricArn",
        .metric_name = "metricName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFleetMetricInput, options: CallOptions) !CreateFleetMetricOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFleetMetricInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/fleet-metric/");
    try path_buf.appendSlice(allocator, input.metric_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"aggregationField\":");
    try aws.json.writeValue(@TypeOf(input.aggregation_field), input.aggregation_field, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"aggregationType\":");
    try aws.json.writeValue(@TypeOf(input.aggregation_type), input.aggregation_type, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.index_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"indexName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"period\":");
    try aws.json.writeValue(@TypeOf(input.period), input.period, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"queryString\":");
    try aws.json.writeValue(@TypeOf(input.query_string), input.query_string, allocator, &body_buf);
    has_prev = true;
    if (input.query_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryVersion\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.unit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"unit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFleetMetricOutput {
    var result: CreateFleetMetricOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFleetMetricOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
