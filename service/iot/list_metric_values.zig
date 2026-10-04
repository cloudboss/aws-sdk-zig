const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DimensionValueOperator = @import("dimension_value_operator.zig").DimensionValueOperator;
const MetricDatum = @import("metric_datum.zig").MetricDatum;

pub const ListMetricValuesInput = struct {
    /// The dimension name.
    dimension_name: ?[]const u8 = null,

    /// The dimension value operator.
    dimension_value_operator: ?DimensionValueOperator = null,

    /// The end of the time period for which metric values are returned.
    end_time: i64,

    /// The maximum number of results to return at one time.
    max_results: ?i32 = null,

    /// The name of the security profile metric for which values are returned.
    metric_name: []const u8,

    /// The token for the next set of results.
    next_token: ?[]const u8 = null,

    /// The start of the time period for which metric values are returned.
    start_time: i64,

    /// The name of the thing for which security profile metric values are returned.
    thing_name: []const u8,

    pub const json_field_names = .{
        .dimension_name = "dimensionName",
        .dimension_value_operator = "dimensionValueOperator",
        .end_time = "endTime",
        .max_results = "maxResults",
        .metric_name = "metricName",
        .next_token = "nextToken",
        .start_time = "startTime",
        .thing_name = "thingName",
    };
};

pub const ListMetricValuesOutput = struct {
    /// The data the thing reports for the metric during the specified time period.
    metric_datum_list: ?[]const MetricDatum = null,

    /// A token that can be used to retrieve the next set of results, or `null`
    /// if there are no additional results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .metric_datum_list = "metricDatumList",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMetricValuesInput, options: CallOptions) !ListMetricValuesOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMetricValuesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/metric-values";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.dimension_name) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "dimensionName=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.dimension_value_operator) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "dimensionValueOperator=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "endTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.end_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "metricName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.metric_name);
    query_has_prev = true;
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "startTime=");
    {
        const num_str = std.fmt.allocPrint(allocator, "{d}", .{input.start_time}) catch "";
        try query_buf.appendSlice(allocator, num_str);
    }
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "thingName=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.thing_name);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMetricValuesOutput {
    const result: ListMetricValuesOutput = try aws.json.parseJsonObject(
        ListMetricValuesOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
