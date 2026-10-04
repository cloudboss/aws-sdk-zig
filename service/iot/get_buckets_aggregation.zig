const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BucketsAggregationType = @import("buckets_aggregation_type.zig").BucketsAggregationType;
const Bucket = @import("bucket.zig").Bucket;

pub const GetBucketsAggregationInput = struct {
    /// The aggregation field.
    aggregation_field: []const u8,

    /// The basic control of the response shape and the bucket aggregation type to
    /// perform.
    buckets_aggregation_type: BucketsAggregationType,

    /// The name of the index to search.
    index_name: ?[]const u8 = null,

    /// The search query string.
    query_string: []const u8,

    /// The version of the query.
    query_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .aggregation_field = "aggregationField",
        .buckets_aggregation_type = "bucketsAggregationType",
        .index_name = "indexName",
        .query_string = "queryString",
        .query_version = "queryVersion",
    };
};

pub const GetBucketsAggregationOutput = struct {
    /// The main part of the response with a list of buckets. Each bucket contains a
    /// `keyValue` and a `count`.
    ///
    /// `keyValue`: The aggregation field value counted for the particular bucket.
    ///
    /// `count`: The number of documents that have that value.
    buckets: ?[]const Bucket = null,

    /// The total number of things that fit the query string criteria.
    total_count: ?i32 = null,

    pub const json_field_names = .{
        .buckets = "buckets",
        .total_count = "totalCount",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBucketsAggregationInput, options: CallOptions) !GetBucketsAggregationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBucketsAggregationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iot", "IoT", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/indices/buckets";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"aggregationField\":");
    try aws.json.writeValue(@TypeOf(input.aggregation_field), input.aggregation_field, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"bucketsAggregationType\":");
    try aws.json.writeValue(@TypeOf(input.buckets_aggregation_type), input.buckets_aggregation_type, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBucketsAggregationOutput {
    const result: GetBucketsAggregationOutput = try aws.json.parseJsonObject(
        GetBucketsAggregationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
