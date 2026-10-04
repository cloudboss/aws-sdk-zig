const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AcceptHeader = @import("accept_header.zig").AcceptHeader;
const ContentType = @import("content_type.zig").ContentType;

pub const DescribeInputDeviceThumbnailInput = struct {
    /// The HTTP Accept header. Indicates the requested type for the thumbnail.
    accept: AcceptHeader,

    /// The unique ID of this input device. For example, hd-123456789abcdef.
    input_device_id: []const u8,

    pub const json_field_names = .{
        .accept = "Accept",
        .input_device_id = "InputDeviceId",
    };
};

pub const DescribeInputDeviceThumbnailOutput = struct {
    /// The binary data for the thumbnail that the Link device has most recently
    /// sent to MediaLive.
    body: ?aws.http.StreamingBody = null,

    /// The length of the content.
    content_length: ?i64 = null,

    /// Specifies the media type of the thumbnail.
    content_type: ?ContentType = null,

    /// The unique, cacheable version of this thumbnail.
    e_tag: ?[]const u8 = null,

    /// The date and time the thumbnail was last updated at the device.
    last_modified: ?i64 = null,

    pub fn deinit(self: *DescribeInputDeviceThumbnailOutput) void {
        if (self.body) |*b| b.deinit();
    }

    pub const json_field_names = .{
        .body = "Body",
        .content_length = "ContentLength",
        .content_type = "ContentType",
        .e_tag = "ETag",
        .last_modified = "LastModified",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInputDeviceThumbnailInput, options: CallOptions) !DescribeInputDeviceThumbnailOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInputDeviceThumbnailInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/inputDevices/");
    try path_buf.appendSlice(allocator, input.input_device_id);
    try path_buf.appendSlice(allocator, "/thumbnailData");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "accept", input.accept.wireName());

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !DescribeInputDeviceThumbnailOutput {
    var result: DescribeInputDeviceThumbnailOutput = .{};
    errdefer {
        if (result.e_tag) |value| allocator.free(value);
    }
    if (stream_resp.headers.get("content-length")) |value| {
        result.content_length = std.fmt.parseInt(i64, value, 10) catch null;
    }
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = ContentType.fromWireName(value);
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
