const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ContainerFormat = @import("container_format.zig").ContainerFormat;
const ChannelLatencyMode = @import("channel_latency_mode.zig").ChannelLatencyMode;
const MultitrackInputConfiguration = @import("multitrack_input_configuration.zig").MultitrackInputConfiguration;
const TranscodePreset = @import("transcode_preset.zig").TranscodePreset;
const ChannelType = @import("channel_type.zig").ChannelType;
const Channel = @import("channel.zig").Channel;

pub const UpdateChannelInput = struct {
    /// ARN of the ad configuration associated with the channel.
    ad_configuration_arn: ?[]const u8 = null,

    /// ARN of the channel to be updated.
    arn: []const u8,

    /// Whether the channel is private (enabled for playback authorization).
    authorized: ?bool = null,

    /// Indicates which content-packaging format is used (MPEG-TS or fMP4). If
    /// `multitrackInputConfiguration` is specified and `enabled` is `true`, then
    /// `containerFormat` is required and must be set to `FRAGMENTED_MP4`.
    /// Otherwise, `containerFormat` may be set to `TS` or `FRAGMENTED_MP4`.
    /// Default: `TS`.
    container_format: ?ContainerFormat = null,

    /// Whether the channel allows insecure RTMP and SRT ingest. Default: `false`.
    insecure_ingest: ?bool = null,

    /// Channel latency mode. Use `NORMAL` to broadcast and deliver live video up to
    /// Full HD. Use `LOW` for near-real-time interaction with viewers.
    latency_mode: ?ChannelLatencyMode = null,

    /// Object specifying multitrack input configuration. Default: no multitrack
    /// input configuration is specified.
    multitrack_input_configuration: ?MultitrackInputConfiguration = null,

    /// Channel name.
    name: ?[]const u8 = null,

    /// Playback-restriction-policy ARN. A valid ARN value here both specifies the
    /// ARN and enables playback restriction. If this is set to an empty string,
    /// playback restriction policy is disabled.
    playback_restriction_policy_arn: ?[]const u8 = null,

    /// Optional transcode preset for the channel. This is selectable only for
    /// `ADVANCED_HD` and `ADVANCED_SD` channel types. For those channel types, the
    /// default `preset` is `HIGHER_BANDWIDTH_DELIVERY`. For other channel types
    /// (`BASIC` and `STANDARD`), `preset` is the empty string (`""`).
    preset: ?TranscodePreset = null,

    /// Recording-configuration ARN. A valid ARN value here both specifies the ARN
    /// and enables recording. If this is set to an empty string, recording is
    /// disabled.
    recording_configuration_arn: ?[]const u8 = null,

    /// Channel type, which determines the allowable resolution and bitrate. *If you
    /// exceed the allowable input resolution or bitrate, the stream probably will
    /// disconnect immediately.* Default: `STANDARD`. For details, see [Channel
    /// Types](https://docs.aws.amazon.com/ivs/latest/LowLatencyAPIReference/channel-types.html).
    @"type": ?ChannelType = null,

    pub const json_field_names = .{
        .ad_configuration_arn = "adConfigurationArn",
        .arn = "arn",
        .authorized = "authorized",
        .container_format = "containerFormat",
        .insecure_ingest = "insecureIngest",
        .latency_mode = "latencyMode",
        .multitrack_input_configuration = "multitrackInputConfiguration",
        .name = "name",
        .playback_restriction_policy_arn = "playbackRestrictionPolicyArn",
        .preset = "preset",
        .recording_configuration_arn = "recordingConfigurationArn",
        .@"type" = "type",
    };
};

pub const UpdateChannelOutput = struct {
    /// Object specifying the updated channel.
    channel: ?Channel = null,

    pub const json_field_names = .{
        .channel = "channel",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateChannelInput, options: CallOptions) !UpdateChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ivs");

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/UpdateChannel";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.ad_configuration_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"adConfigurationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.authorized) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"authorized\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.container_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"containerFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.insecure_ingest) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"insecureIngest\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.latency_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"latencyMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multitrack_input_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"multitrackInputConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.playback_restriction_policy_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"playbackRestrictionPolicyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.preset) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"preset\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.recording_configuration_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"recordingConfigurationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.@"type") |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"type\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateChannelOutput {
    var result: UpdateChannelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateChannelOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "ChannelNotBroadcasting")) {
        return .{ .arena = arena, .kind = .{ .channel_not_broadcasting = .{
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
    if (std.mem.eql(u8, error_code, "PendingVerification")) {
        return .{ .arena = arena, .kind = .{ .pending_verification = .{
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
    if (std.mem.eql(u8, error_code, "ServiceUnavailable")) {
        return .{ .arena = arena, .kind = .{ .service_unavailable = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "StreamUnavailable")) {
        return .{ .arena = arena, .kind = .{ .stream_unavailable = .{
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
