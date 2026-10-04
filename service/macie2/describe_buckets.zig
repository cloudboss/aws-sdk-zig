const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const BucketCriteriaAdditionalProperties = @import("bucket_criteria_additional_properties.zig").BucketCriteriaAdditionalProperties;
const BucketSortCriteria = @import("bucket_sort_criteria.zig").BucketSortCriteria;
const BucketMetadata = @import("bucket_metadata.zig").BucketMetadata;

pub const DescribeBucketsInput = struct {
    /// The criteria to use to filter the query results.
    criteria: ?[]const aws.map.MapEntry(BucketCriteriaAdditionalProperties) = null,

    /// The maximum number of items to include in each page of the response. The
    /// default value is 50.
    max_results: ?i32 = null,

    /// The nextToken string that specifies which page of results to return in a
    /// paginated response.
    next_token: ?[]const u8 = null,

    /// The criteria to use to sort the query results.
    sort_criteria: ?BucketSortCriteria = null,

    pub const json_field_names = .{
        .criteria = "criteria",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .sort_criteria = "sortCriteria",
    };
};

pub const DescribeBucketsOutput = struct {
    /// An array of objects, one for each bucket that matches the filter criteria
    /// specified in the request.
    buckets: ?[]const BucketMetadata = null,

    /// The string to use in a subsequent request to get the next page of results in
    /// a paginated response. This value is null if there are no additional pages.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .buckets = "buckets",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeBucketsInput, options: CallOptions) !DescribeBucketsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeBucketsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/datasources/s3";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"criteria\":");
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
    if (input.sort_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sortCriteria\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeBucketsOutput {
    const result: DescribeBucketsOutput = try aws.json.parseJsonObject(
        DescribeBucketsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
