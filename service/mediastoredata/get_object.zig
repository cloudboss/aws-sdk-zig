const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;

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
        self.body.deinit();
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

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetObjectInput, options: Options) !GetObjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediastoredata");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(error_body, stream_resp.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(&stream_resp, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediastoredata", "MediaStore Data", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/");
    try path_buf.appendSlice(alloc, input.path);
    const path = try path_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");
    if (input.range) |v| {
        try request.headers.put(alloc, "Range", v);
    }

    return request;
}

fn deserializeStreamingResponse(stream_resp: *aws.http.StreamingResponse, alloc: std.mem.Allocator) !GetObjectOutput {
    var result: GetObjectOutput = .{};
    result.body = stream_resp.body;
    result.status_code = @intCast(stream_resp.status);
    if (stream_resp.headers.get("cache-control")) |value| {
        result.cache_control = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-length")) |value| {
        result.content_length = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (stream_resp.headers.get("content-range")) |value| {
        result.content_range = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("etag")) |value| {
        result.e_tag = try alloc.dupe(u8, value);
    }
    if (stream_resp.headers.get("last-modified")) |value| {
        result.last_modified = std.fmt.parseInt(i64, value, 10) catch null;
    }
    stream_resp.deinitHeaders();

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "ContainerNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .container_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerError")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ObjectNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .object_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "RequestedRangeNotSatisfiableException")) {
        return .{ .arena = arena, .kind = .{ .requested_range_not_satisfiable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
