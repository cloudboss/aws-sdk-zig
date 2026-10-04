const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TableBucketType = @import("table_bucket_type.zig").TableBucketType;
const TableBucketSummary = @import("table_bucket_summary.zig").TableBucketSummary;

pub const ListTableBucketsInput = struct {
    /// `ContinuationToken` indicates to Amazon S3 that the list is being continued
    /// on this bucket with a token. `ContinuationToken` is obfuscated and is not a
    /// real key. You can use this `ContinuationToken` for pagination of the list
    /// results.
    continuation_token: ?[]const u8 = null,

    /// The maximum number of table buckets to return in the list.
    max_buckets: ?i32 = null,

    /// The prefix of the table buckets.
    prefix: ?[]const u8 = null,

    /// The type of table buckets to filter by in the list.
    @"type": ?TableBucketType = null,

    pub const json_field_names = .{
        .continuation_token = "continuationToken",
        .max_buckets = "maxBuckets",
        .prefix = "prefix",
        .@"type" = "type",
    };
};

pub const ListTableBucketsOutput = struct {
    /// You can use this `ContinuationToken` for pagination of the list results.
    continuation_token: ?[]const u8 = null,

    /// A list of table buckets.
    table_buckets: ?[]const TableBucketSummary = null,

    pub const json_field_names = .{
        .continuation_token = "continuationToken",
        .table_buckets = "tableBuckets",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTableBucketsInput, options: CallOptions) !ListTableBucketsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3tables", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTableBucketsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3tables", "S3Tables", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/buckets";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.continuation_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "continuationToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.max_buckets) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxBuckets=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.prefix) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "prefix=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.@"type") |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "type=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTableBucketsOutput {
    const result: ListTableBucketsOutput = try aws.json.parseJsonObject(
        ListTableBucketsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
