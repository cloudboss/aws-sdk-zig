const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Statistics = @import("statistics.zig").Statistics;

pub const GetStatisticsInput = struct {
    /// The aggregation field name.
    aggregation_field: ?[]const u8 = null,

    /// The name of the index to search. The default value is `AWS_Things`.
    index_name: ?[]const u8 = null,

    /// The query used to search. You can specify "*" for the query string to get
    /// the count of all
    /// indexed things in your Amazon Web Services account.
    query_string: []const u8,

    /// The version of the query used to search.
    query_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregation_field = "aggregationField",
        .index_name = "indexName",
        .query_string = "queryString",
        .query_version = "queryVersion",
    };
};

pub const GetStatisticsOutput = struct {
    /// The statistics returned by the Fleet Indexing service based on the query and
    /// aggregation
    /// field.
    statistics: ?Statistics = null,

    pub const json_field_names = .{
        .statistics = "statistics",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStatisticsInput, options: CallOptions) !GetStatisticsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStatisticsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/indices/statistics";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.aggregation_field) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"aggregationField\":");
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
    try body_buf.appendSlice(allocator, "\"queryString\":");
    try aws.json.writeValue(@TypeOf(input.query_string), input.query_string, allocator, &body_buf);
    has_prev = true;
    if (input.query_version) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"queryVersion\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStatisticsOutput {
    var result: GetStatisticsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetStatisticsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
