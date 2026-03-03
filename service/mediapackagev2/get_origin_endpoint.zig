const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerType = @import("container_type.zig").ContainerType;
const GetDashManifestConfiguration = @import("get_dash_manifest_configuration.zig").GetDashManifestConfiguration;
const ForceEndpointErrorConfiguration = @import("force_endpoint_error_configuration.zig").ForceEndpointErrorConfiguration;
const GetHlsManifestConfiguration = @import("get_hls_manifest_configuration.zig").GetHlsManifestConfiguration;
const GetLowLatencyHlsManifestConfiguration = @import("get_low_latency_hls_manifest_configuration.zig").GetLowLatencyHlsManifestConfiguration;
const GetMssManifestConfiguration = @import("get_mss_manifest_configuration.zig").GetMssManifestConfiguration;
const Segment = @import("segment.zig").Segment;

pub const GetOriginEndpointInput = struct {
    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group.
    channel_name: []const u8,

    /// The name that describes the origin endpoint. The name is the primary
    /// identifier for the origin endpoint, and and must be unique for your account
    /// in the AWS Region and channel.
    origin_endpoint_name: []const u8,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .origin_endpoint_name = "OriginEndpointName",
    };
};

pub const GetOriginEndpointOutput = struct {
    /// The Amazon Resource Name (ARN) associated with the resource.
    arn: []const u8,

    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group.
    channel_name: []const u8,

    /// The type of container attached to this origin endpoint.
    container_type: ContainerType,

    /// The date and time the origin endpoint was created.
    created_at: i64,

    /// A DASH manifest configuration.
    dash_manifests: ?[]const GetDashManifestConfiguration = null,

    /// The description for your origin endpoint.
    description: ?[]const u8 = null,

    /// The current Entity Tag (ETag) associated with this resource. The entity tag
    /// can be used to safely make concurrent updates to the resource.
    e_tag: ?[]const u8 = null,

    /// The failover settings for the endpoint.
    force_endpoint_error_configuration: ?ForceEndpointErrorConfiguration = null,

    /// An HTTP live streaming (HLS) manifest configuration.
    hls_manifests: ?[]const GetHlsManifestConfiguration = null,

    /// A low-latency HLS manifest configuration.
    low_latency_hls_manifests: ?[]const GetLowLatencyHlsManifestConfiguration = null,

    /// The date and time the origin endpoint was modified.
    modified_at: i64,

    /// The Microsoft Smooth Streaming (MSS) manifest configurations associated with
    /// this origin endpoint.
    mss_manifests: ?[]const GetMssManifestConfiguration = null,

    /// The name that describes the origin endpoint. The name is the primary
    /// identifier for the origin endpoint, and and must be unique for your account
    /// in the AWS Region and channel.
    origin_endpoint_name: []const u8,

    /// The time that the origin endpoint was last reset.
    reset_at: ?i64 = null,

    segment: ?Segment = null,

    /// The size of the window (in seconds) to create a window of the live stream
    /// that's available for on-demand viewing. Viewers can start-over or catch-up
    /// on content that falls within the window.
    startover_window_seconds: ?i32 = null,

    /// The comma-separated list of tag key:value pairs assigned to the origin
    /// endpoint.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .container_type = "ContainerType",
        .created_at = "CreatedAt",
        .dash_manifests = "DashManifests",
        .description = "Description",
        .e_tag = "ETag",
        .force_endpoint_error_configuration = "ForceEndpointErrorConfiguration",
        .hls_manifests = "HlsManifests",
        .low_latency_hls_manifests = "LowLatencyHlsManifests",
        .modified_at = "ModifiedAt",
        .mss_manifests = "MssManifests",
        .origin_endpoint_name = "OriginEndpointName",
        .reset_at = "ResetAt",
        .segment = "Segment",
        .startover_window_seconds = "StartoverWindowSeconds",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetOriginEndpointInput, options: CallOptions) !GetOriginEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "mediapackagev2");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetOriginEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/channelGroup/");
    try path_buf.appendSlice(allocator, input.channel_group_name);
    try path_buf.appendSlice(allocator, "/channel/");
    try path_buf.appendSlice(allocator, input.channel_name);
    try path_buf.appendSlice(allocator, "/originEndpoint/");
    try path_buf.appendSlice(allocator, input.origin_endpoint_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetOriginEndpointOutput {
    var result: GetOriginEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetOriginEndpointOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
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
