const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetObjectInput = struct {
    /// The path (including the file name) where the object is stored in the
    /// container.
    /// Format: //
    ///
    /// For example, to upload the file `mlaw.avi` to the folder path
    /// `premium\canada` in the container `movies`, enter the path
    /// `premium/canada/mlaw.avi`.
    ///
    /// Do not include the container name in this path.
    ///
    /// If the path includes any folders that don't exist yet, the service creates
    /// them. For
    /// example, suppose you have an existing `premium/usa` subfolder. If you
    /// specify
    /// `premium/canada`, the service creates a `canada` subfolder in the
    /// `premium` folder. You then have two subfolders, `usa` and
    /// `canada`, in the `premium` folder.
    ///
    /// There is no correlation between the path to the source and the path
    /// (folders) in the
    /// container in AWS Elemental MediaStore.
    ///
    /// For more information about folders and how they exist in a container, see
    /// the [AWS Elemental MediaStore User
    /// Guide](http://docs.aws.amazon.com/mediastore/latest/ug/).
    ///
    /// The file name is the name that is assigned to the file that you upload. The
    /// file can
    /// have the same name inside and outside of AWS Elemental MediaStore, or it can
    /// have the same
    /// name. The file name can include or omit an extension.
    path: []const u8,

    /// The range bytes of an object to retrieve. For more information about the
    /// `Range` header, see
    /// [http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35](http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.35). AWS Elemental MediaStore ignores this header for partially uploaded objects that have streaming upload availability.
    range: ?[]const u8 = null,

    pub const json_field_names = .{
        .path = "Path",
        .range = "Range",
    };
};

pub const GetObjectOutput = struct {
    /// The bytes of the object.
    body: ?aws.http.StreamingBody = null,

    /// An optional `CacheControl` header that allows the caller to control the
    /// object's cache behavior. Headers can be passed in as specified in the HTTP
    /// spec at
    /// [https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9).
    ///
    /// Headers with a custom user-defined value are also accepted.
    cache_control: ?[]const u8 = null,

    /// The length of the object in bytes.
    content_length: ?i64 = null,

    /// The range of bytes to retrieve.
    content_range: ?[]const u8 = null,

    /// The content type of the object.
    content_type: ?[]const u8 = null,

    /// The ETag that represents a unique instance of the object.
    e_tag: ?[]const u8 = null,

    /// The date and time that the object was last modified.
    last_modified: ?i64 = null,

    /// The HTML status code of the request. Status codes ranging from 200 to 299
    /// indicate
    /// success. All other status codes indicate the type of error that occurred.
    status_code: ?i32 = null,

    pub fn deinit(self: *GetObjectOutput) void {
        if (self.body) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .body = "Body",
        .cache_control = "CacheControl",
        .content_length = "ContentLength",
        .content_range = "ContentRange",
        .content_type = "ContentType",
        .e_tag = "ETag",
        .last_modified = "LastModified",
        .status_code = "StatusCode",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetObjectInput, options: CallOptions) !GetObjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediastore", client.config.http_client.clock_skew_offset);

    var stream_resp = try client.config.http_client.sendStreamingRequestWithOptions(&request, client.options);

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, error_body, stream_resp.status);
        }
        return error.ServiceError;
    }

    errdefer stream_resp.deinit();
    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("data.mediastore", "MediaStore Data", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.path);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.range) |v| {
        try request.headers.put(allocator, "Range", v);
    }

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetObjectOutput {
    var result: GetObjectOutput = .{};
    errdefer {
        if (result.cache_control) |value| allocator.free(value);
        if (result.content_range) |value| allocator.free(value);
        if (result.content_type) |value| allocator.free(value);
        if (result.e_tag) |value| allocator.free(value);
    }
    result.status_code = @intCast(stream_resp.status);
    if (stream_resp.headers.get("cache-control")) |value| {
        result.cache_control = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-length")) |value| {
        result.content_length = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (stream_resp.headers.get("content-range")) |value| {
        result.content_range = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (stream_resp.headers.get("last-modified")) |value| {
        result.last_modified = std.fmt.parseInt(i64, value, 10) catch null;
    }
    result.body = stream_resp.body;
    stream_resp.deinitHeaders();

    return result;
}
