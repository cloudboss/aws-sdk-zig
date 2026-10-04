const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Condition = @import("condition.zig").Condition;
const Field = @import("field.zig").Field;
const Sort = @import("sort.zig").Sort;

pub const ListMetricsInput = struct {
    /// Indicates the list of all the conditions that were applied on the metrics.
    conditions: ?[]const Condition = null,

    /// Indicates the data source of the metrics.
    data_source: ?[]const u8 = null,

    /// Indicates the list of fields in the data source.
    fields: ?[]const Field = null,

    /// Maximum number of results to include in the response. If more results exist
    /// than the specified
    /// `MaxResults` value, a token is included in the response so that the
    /// remaining results can be retrieved.
    max_results: ?i32 = null,

    /// Null, or the token from a previous call to get the next set of results.
    next_token: ?[]const u8 = null,

    /// (Optional) Indicates the order in which you want to sort the fields in the
    /// metrics. By default, the fields are sorted in the ascending order.
    sorts: ?[]const Sort = null,

    pub const json_field_names = .{
        .conditions = "conditions",
        .data_source = "dataSource",
        .fields = "fields",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sorts = "sorts",
    };
};

pub const ListMetricsOutput = struct {
    /// Token for the next set of results, or null if there are no more results.
    next_token: ?[]const u8 = null,

    /// Specifies all the list of metric values for each row of metrics.
    rows: ?[]const []const []const u8 = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .rows = "rows",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMetricsInput, options: CallOptions) !ListMetricsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resiliencehub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMetricsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resiliencehub", "resiliencehub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/list-metrics";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.conditions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"conditions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"dataSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.fields) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"fields\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sorts) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sorts\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMetricsOutput {
    const result: ListMetricsOutput = try aws.json.parseJsonObject(
        ListMetricsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
