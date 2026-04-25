const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ImageFrameInformation = @import("image_frame_information.zig").ImageFrameInformation;

pub const GetImageFrameInput = struct {
    /// The data store identifier.
    datastore_id: []const u8,

    /// Information about the image frame (pixel data) identifier.
    image_frame_information: ImageFrameInformation,

    /// The image set identifier.
    image_set_id: []const u8,

    pub const json_field_names = .{
        .datastore_id = "datastoreId",
        .image_frame_information = "imageFrameInformation",
        .image_set_id = "imageSetId",
    };
};

pub const GetImageFrameOutput = struct {
    /// The format in which the image frame information is returned to the customer.
    /// Default is `application/octet-stream`.
    ///
    /// * If the stored transfer syntax is `1.2.840.10008.1.2.1`, the returned
    ///   `contentType` is `application/octet-stream`.
    ///
    /// * If the stored transfer syntax is `1.2.840.10008.1.2.4.50`, the returned
    ///   `contentType` is `image/jpeg`.
    ///
    /// * If the stored transfer syntax is `1.2.840.10008.1.2.4.91`, the returned
    ///   `contentType` is `image/j2c`.
    ///
    /// * If the stored transfer syntax is MPEG2, `1.2.840.10008.1.2.4.100`,
    ///   `1.2.840.10008.1.2.4.100.1`, `1.2.840.10008.1.2.4.101`, or
    ///   `1.2.840.10008.1.2.4.101.1`, the returned `contentType` is `video/mpeg`.
    ///
    /// * If the stored transfer syntax is MPEG-4 AVC/H.264, UID
    ///   `1.2.840.10008.1.2.4.102`, `1.2.840.10008.1.2.4.102.1`,
    ///   `1.2.840.10008.1.2.4.103`, `1.2.840.10008.1.2.4.103.1`,
    ///   `1.2.840.10008.1.2.4.104`, `1.2.840.10008.1.2.4.104.1`,
    ///   `1.2.840.10008.1.2.4.105`, `1.2.840.10008.1.2.4.105.1`,
    ///   `1.2.840.10008.1.2.4.106`, or `1.2.840.10008.1.2.4.106.1`, the returned
    ///   `contentType` is `video/mp4`.
    ///
    /// * If the stored transfer syntax is HEVC/H.265, UID `1.2.840.10008.1.2.4.107`
    ///   or `1.2.840.10008.1.2.4.108`, the returned `contentType` is `video/H256`.
    ///
    /// * If the stored transfer syntax is `1.2.840.10008.1.2.4.202` or if the
    ///   stored transfer syntax is *missing*, the returned `contentType` is
    ///   `image/jph`.
    ///
    /// * If the stored transfer syntax is `1.2.840.10008.1.2.4.203`, the returned
    ///   contentType is `image/jphc`.
    /// * If the stored transfer syntax is `1.2.840.10008.1.2.4.112` the returned
    ///   `contentType` is `image/jxl`.
    content_type: ?[]const u8 = null,

    /// The blob containing the aggregated image frame information.
    image_frame_blob: aws.http.StreamingBody = undefined,

    pub fn deinit(self: *GetImageFrameOutput) void {
        self.image_frame_blob.deinit();
    }

    pub const json_field_names = .{
        .content_type = "contentType",
        .image_frame_blob = "imageFrameBlob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImageFrameInput, options: CallOptions) !GetImageFrameOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "medical-imaging");

    var stream_resp = try client.http_client.sendStreamingRequest(&request);

    arena.deinit();

    if (!stream_resp.isSuccess()) {
        defer stream_resp.deinit();
        const error_body = stream_resp.body.readAll(client.allocator, 10 * 1024 * 1024) catch return error.RequestFailed;
        defer client.allocator.free(error_body);
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, error_body, stream_resp.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(stream_resp.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeStreamingResponse(allocator, &stream_resp);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: GetImageFrameInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medical-imaging", "Medical Imaging", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/datastore/");
    try path_buf.appendSlice(allocator, input.datastore_id);
    try path_buf.appendSlice(allocator, "/imageSet/");
    try path_buf.appendSlice(allocator, input.image_set_id);
    try path_buf.appendSlice(allocator, "/getImageFrame");
    const path = try path_buf.toOwnedSlice(allocator);

    const body = try aws.json.jsonStringify(input.image_frame_information, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeStreamingResponse(allocator: std.mem.Allocator, stream_resp: *aws.http.StreamingResponse) !GetImageFrameOutput {
    var result: GetImageFrameOutput = .{};
    result.image_frame_blob = stream_resp.body;
    if (stream_resp.headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }
    stream_resp.deinitHeaders();

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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAcceptableException")) {
        return .{ .arena = arena, .kind = .{ .not_acceptable_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
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
