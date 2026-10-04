const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeKeyValueStoreInput = struct {
    /// The Amazon Resource Name (ARN) of the Key Value Store.
    kvs_arn: []const u8,

    pub const json_field_names = .{
        .kvs_arn = "KvsARN",
    };
};

pub const DescribeKeyValueStoreOutput = struct {
    /// Date and time when the Key Value Store was created.
    created: i64,

    /// The version identifier for the current version of the Key Value Store.
    e_tag: []const u8,

    /// The reason for Key Value Store creation failure.
    failure_reason: ?[]const u8 = null,

    /// Number of key value pairs in the Key Value Store.
    item_count: i32,

    /// The Amazon Resource Name (ARN) of the Key Value Store.
    kvs_arn: []const u8,

    /// Date and time when the key value pairs in the Key Value Store was last
    /// modified.
    last_modified: ?i64 = null,

    /// The current status of the Key Value Store.
    status: ?[]const u8 = null,

    /// Total size of the Key Value Store in bytes.
    total_size_in_bytes: i64,

    pub const json_field_names = .{
        .created = "Created",
        .e_tag = "ETag",
        .failure_reason = "FailureReason",
        .item_count = "ItemCount",
        .kvs_arn = "KvsARN",
        .last_modified = "LastModified",
        .status = "Status",
        .total_size_in_bytes = "TotalSizeInBytes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeKeyValueStoreInput, options: CallOptions) !DescribeKeyValueStoreOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "key-value-store", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeKeyValueStoreInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront-keyvaluestore", "CloudFront KeyValueStore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/key-value-stores/");
    try path_buf.appendSlice(allocator, input.kvs_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeKeyValueStoreOutput {
    var result: DescribeKeyValueStoreOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeKeyValueStoreOutput, body, allocator);
    }
    _ = status;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
