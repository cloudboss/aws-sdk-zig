const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerType = @import("container_type.zig").ContainerType;
const CreateDashManifestConfiguration = @import("create_dash_manifest_configuration.zig").CreateDashManifestConfiguration;
const ForceEndpointErrorConfiguration = @import("force_endpoint_error_configuration.zig").ForceEndpointErrorConfiguration;
const CreateHlsManifestConfiguration = @import("create_hls_manifest_configuration.zig").CreateHlsManifestConfiguration;
const CreateLowLatencyHlsManifestConfiguration = @import("create_low_latency_hls_manifest_configuration.zig").CreateLowLatencyHlsManifestConfiguration;
const CreateMssManifestConfiguration = @import("create_mss_manifest_configuration.zig").CreateMssManifestConfiguration;
const Segment = @import("segment.zig").Segment;
const GetDashManifestConfiguration = @import("get_dash_manifest_configuration.zig").GetDashManifestConfiguration;
const GetHlsManifestConfiguration = @import("get_hls_manifest_configuration.zig").GetHlsManifestConfiguration;
const GetLowLatencyHlsManifestConfiguration = @import("get_low_latency_hls_manifest_configuration.zig").GetLowLatencyHlsManifestConfiguration;
const GetMssManifestConfiguration = @import("get_mss_manifest_configuration.zig").GetMssManifestConfiguration;

pub const UpdateOriginEndpointInput = struct {
    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group.
    channel_name: []const u8,

    /// The type of container attached to this origin endpoint. A container type is
    /// a file format that encapsulates one or more media streams, such as audio and
    /// video, into a single file.
    container_type: ContainerType,

    /// A DASH manifest configuration.
    dash_manifests: ?[]const CreateDashManifestConfiguration = null,

    /// Any descriptive information that you want to add to the origin endpoint for
    /// future identification purposes.
    description: ?[]const u8 = null,

    /// The expected current Entity Tag (ETag) for the resource. If the specified
    /// ETag does not match the resource's current entity tag, the update request
    /// will be rejected.
    e_tag: ?[]const u8 = null,

    /// The failover settings for the endpoint.
    force_endpoint_error_configuration: ?ForceEndpointErrorConfiguration = null,

    /// An HTTP live streaming (HLS) manifest configuration.
    hls_manifests: ?[]const CreateHlsManifestConfiguration = null,

    /// A low-latency HLS manifest configuration.
    low_latency_hls_manifests: ?[]const CreateLowLatencyHlsManifestConfiguration = null,

    /// A list of Microsoft Smooth Streaming (MSS) manifest configurations to update
    /// for the origin endpoint. This replaces the existing MSS manifest
    /// configurations.
    mss_manifests: ?[]const CreateMssManifestConfiguration = null,

    /// The name that describes the origin endpoint. The name is the primary
    /// identifier for the origin endpoint, and and must be unique for your account
    /// in the AWS Region and channel.
    origin_endpoint_name: []const u8,

    /// The segment configuration, including the segment name, duration, and other
    /// configuration values.
    segment: ?Segment = null,

    /// The size of the window (in seconds) to create a window of the live stream
    /// that's available for on-demand viewing. Viewers can start-over or catch-up
    /// on content that falls within the window. The maximum startover window is
    /// 1,209,600 seconds (14 days).
    startover_window_seconds: ?i32 = null,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .container_type = "ContainerType",
        .dash_manifests = "DashManifests",
        .description = "Description",
        .e_tag = "ETag",
        .force_endpoint_error_configuration = "ForceEndpointErrorConfiguration",
        .hls_manifests = "HlsManifests",
        .low_latency_hls_manifests = "LowLatencyHlsManifests",
        .mss_manifests = "MssManifests",
        .origin_endpoint_name = "OriginEndpointName",
        .segment = "Segment",
        .startover_window_seconds = "StartoverWindowSeconds",
    };
};

pub const UpdateOriginEndpointOutput = struct {
    /// The ARN associated with the resource.
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

    /// The description of the origin endpoint.
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

    /// The updated Microsoft Smooth Streaming (MSS) manifest configurations for
    /// this origin endpoint.
    mss_manifests: ?[]const GetMssManifestConfiguration = null,

    /// The name that describes the origin endpoint. The name is the primary
    /// identifier for the origin endpoint, and and must be unique for your account
    /// in the AWS Region and channel.
    origin_endpoint_name: []const u8,

    /// The segment configuration, including the segment name, duration, and other
    /// configuration values.
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
        .segment = "Segment",
        .startover_window_seconds = "StartoverWindowSeconds",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOriginEndpointInput, options: CallOptions) !UpdateOriginEndpointOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOriginEndpointInput, config: *aws.Config) !aws.http.Request {
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

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ContainerType\":");
    try aws.json.writeValue(@TypeOf(input.container_type), input.container_type, allocator, &body_buf);
    has_prev = true;
    if (input.dash_manifests) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DashManifests\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.force_endpoint_error_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ForceEndpointErrorConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.hls_manifests) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"HlsManifests\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.low_latency_hls_manifests) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LowLatencyHlsManifests\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.mss_manifests) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MssManifests\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.segment) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Segment\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.startover_window_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"StartoverWindowSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PUT;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.e_tag) |v| {
        try request.headers.put(allocator, "x-amzn-update-if-match", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOriginEndpointOutput {
    var result: UpdateOriginEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateOriginEndpointOutput, body, allocator);
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
