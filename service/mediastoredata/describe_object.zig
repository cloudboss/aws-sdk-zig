const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DescribeObjectInput = struct {
    /// The path (including the file name) where the object is stored in the
    /// container.
    /// Format: //
    path: []const u8,

    pub const json_field_names = .{
        .path = "Path",
    };
};

pub const DescribeObjectOutput = struct {
    /// An optional `CacheControl` header that allows the caller to control the
    /// object's cache behavior. Headers can be passed in as specified in the HTTP
    /// at
    /// [https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9).
    ///
    /// Headers with a custom user-defined value are also accepted.
    cache_control: ?[]const u8 = null,

    /// The length of the object in bytes.
    content_length: ?i64 = null,

    /// The content type of the object.
    content_type: ?[]const u8 = null,

    /// The ETag that represents a unique instance of the object.
    e_tag: ?[]const u8 = null,

    /// The date and time that the object was last modified.
    last_modified: ?i64 = null,

    pub const json_field_names = .{
        .cache_control = "CacheControl",
        .content_length = "ContentLength",
        .content_type = "ContentType",
        .e_tag = "ETag",
        .last_modified = "LastModified",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeObjectInput, options: CallOptions) !DescribeObjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediastore", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.mediastore", "MediaStore Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.path);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .HEAD;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeObjectOutput {
    var result: DescribeObjectOutput = .{};
    _ = body;
    _ = status;
    if (headers.get("cache-control")) |value| {
        result.cache_control = try allocator.dupe(u8, value);
    }
    if (headers.get("content-length")) |value| {
        result.content_length = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (headers.get("last-modified")) |value| {
        result.last_modified = std.fmt.parseInt(i64, value, 10) catch null;
    }

    return result;
}
