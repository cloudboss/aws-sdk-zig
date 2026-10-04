const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteKeyInput = struct {
    /// The current version (ETag) of the Key Value Store that you are deleting keys
    /// from, which you can get using DescribeKeyValueStore.
    if_match: []const u8,

    /// The key to delete.
    key: []const u8,

    /// The Amazon Resource Name (ARN) of the Key Value Store.
    kvs_arn: []const u8,

    pub const json_field_names = .{
        .if_match = "IfMatch",
        .key = "Key",
        .kvs_arn = "KvsARN",
    };
};

pub const DeleteKeyOutput = struct {
    /// The current version identifier of the Key Value Store after the successful
    /// delete.
    e_tag: []const u8,

    /// Number of key value pairs in the Key Value Store after the successful
    /// delete.
    item_count: i32,

    /// Total size of the Key Value Store after the successful delete, in bytes.
    total_size_in_bytes: i64,

    pub const json_field_names = .{
        .e_tag = "ETag",
        .item_count = "ItemCount",
        .total_size_in_bytes = "TotalSizeInBytes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteKeyInput, options: CallOptions) !DeleteKeyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteKeyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront-keyvaluestore", "CloudFront KeyValueStore", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/key-value-stores/");
    try path_buf.appendSlice(allocator, input.kvs_arn);
    try path_buf.appendSlice(allocator, "/keys/");
    try path_buf.appendSlice(allocator, input.key);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .DELETE;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "If-Match", input.if_match);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteKeyOutput {
    var result: DeleteKeyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DeleteKeyOutput, body, allocator);
    }
    _ = status;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }

    return result;
}
