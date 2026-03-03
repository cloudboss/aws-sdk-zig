const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const StorageClass = @import("storage_class.zig").StorageClass;
const UploadAvailability = @import("upload_availability.zig").UploadAvailability;

pub const PutObjectInput = struct {
    /// The bytes to be stored.
    body: []const u8,

    /// An optional `CacheControl` header that allows the caller to control the
    /// object's cache behavior. Headers can be passed in as specified in the HTTP
    /// at
    /// [https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9](https://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.9).
    ///
    /// Headers with a custom user-defined value are also accepted.
    cache_control: ?[]const u8 = null,

    /// The content type of the object.
    content_type: ?[]const u8 = null,

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

    /// Indicates the storage class of a `Put` request. Defaults to
    /// high-performance temporal storage class, and objects are persisted into
    /// durable storage
    /// shortly after being received.
    storage_class: ?StorageClass = null,

    /// Indicates the availability of an object while it is still uploading. If the
    /// value is set to `streaming`, the object is available for
    /// downloading after some initial buffering but before the object is uploaded
    /// completely. If the value is set to `standard`, the object is
    /// available for downloading only when it is uploaded completely. The default
    /// value for this header is `standard`.
    ///
    /// To use this header, you must also set the HTTP `Transfer-Encoding` header to
    /// `chunked`.
    upload_availability: ?UploadAvailability = null,

    pub const json_field_names = .{
        .body = "Body",
        .cache_control = "CacheControl",
        .content_type = "ContentType",
        .path = "Path",
        .storage_class = "StorageClass",
        .upload_availability = "UploadAvailability",
    };
};

pub const PutObjectOutput = struct {
    /// The SHA256 digest of the object that is persisted.
    content_sha256: ?[]const u8 = null,

    /// Unique identifier of the object in the container.
    e_tag: ?[]const u8 = null,

    /// The storage class where the object was persisted. The class should be
    /// “Temporal”.
    storage_class: ?StorageClass = null,

    pub const json_field_names = .{
        .content_sha256 = "ContentSHA256",
        .e_tag = "ETag",
        .storage_class = "StorageClass",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutObjectInput, options: Options) !PutObjectOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediastoredata");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: PutObjectInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediastoredata", "MediaStore Data", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.path);
    const path = try path_buf.toOwnedSlice(allocator);

    const body = input.body;

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.cache_control) |v| {
        try request.headers.put(allocator, "Cache-Control", v);
    }
    if (input.content_type) |v| {
        try request.headers.put(allocator, "Content-Type", v);
    }
    if (input.storage_class) |v| {
        try request.headers.put(allocator, "x-amz-storage-class", @tagName(v));
    }
    if (input.upload_availability) |v| {
        try request.headers.put(allocator, "x-amz-upload-availability", @tagName(v));
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutObjectOutput {
    var result: PutObjectOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(PutObjectOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
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
