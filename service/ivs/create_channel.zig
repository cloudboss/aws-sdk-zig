const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ContainerFormat = @import("container_format.zig").ContainerFormat;
const ChannelLatencyMode = @import("channel_latency_mode.zig").ChannelLatencyMode;
const MultitrackInputConfiguration = @import("multitrack_input_configuration.zig").MultitrackInputConfiguration;
const TranscodePreset = @import("transcode_preset.zig").TranscodePreset;
const ChannelType = @import("channel_type.zig").ChannelType;
const Channel = @import("channel.zig").Channel;
const StreamKey = @import("stream_key.zig").StreamKey;

pub const CreateChannelInput = struct {
    /// ARN of the ad configuration associated with the channel.
    ad_configuration_arn: ?[]const u8 = null,

    /// Whether the channel is private (enabled for playback authorization).
    /// Default: `false`.
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
    /// Full HD. Use `LOW` for near-real-time interaction with viewers. Default:
    /// `LOW`.
    latency_mode: ?ChannelLatencyMode = null,

    /// Object specifying multitrack input configuration. Default: no multitrack
    /// input configuration is specified.
    multitrack_input_configuration: ?MultitrackInputConfiguration = null,

    /// Channel name.
    name: ?[]const u8 = null,

    /// Playback-restriction-policy ARN. A valid ARN value here both specifies the
    /// ARN and enables playback restriction. Default: "" (empty string, no playback
    /// restriction policy is applied).
    playback_restriction_policy_arn: ?[]const u8 = null,

    /// Optional transcode preset for the channel. This is selectable only for
    /// `ADVANCED_HD` and `ADVANCED_SD` channel types. For those channel types, the
    /// default `preset` is `HIGHER_BANDWIDTH_DELIVERY`. For other channel types
    /// (`BASIC` and `STANDARD`), `preset` is the empty string (`""`).
    preset: ?TranscodePreset = null,

    /// Recording-configuration ARN. A valid ARN value here both specifies the ARN
    /// and enables recording. Default: "" (empty string, recording is disabled).
    recording_configuration_arn: ?[]const u8 = null,

    /// Array of 1-50 maps, each of the form `string:string (key:value)`. See [Best
    /// practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Channel type, which determines the allowable resolution and bitrate. *If you
    /// exceed the allowable input resolution or bitrate, the stream probably will
    /// disconnect immediately.* Default: `STANDARD`. For details, see [Channel
    /// Types](https://docs.aws.amazon.com/ivs/latest/LowLatencyAPIReference/channel-types.html).
    @"type": ?ChannelType = null,

    pub const json_field_names = .{
        .ad_configuration_arn = "adConfigurationArn",
        .authorized = "authorized",
        .container_format = "containerFormat",
        .insecure_ingest = "insecureIngest",
        .latency_mode = "latencyMode",
        .multitrack_input_configuration = "multitrackInputConfiguration",
        .name = "name",
        .playback_restriction_policy_arn = "playbackRestrictionPolicyArn",
        .preset = "preset",
        .recording_configuration_arn = "recordingConfigurationArn",
        .tags = "tags",
        .@"type" = "type",
    };
};

pub const CreateChannelOutput = struct {
    channel: ?Channel = null,

    stream_key: ?StreamKey = null,

    pub const json_field_names = .{
        .channel = "channel",
        .stream_key = "streamKey",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChannelInput, options: CallOptions) !CreateChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateChannel";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.ad_configuration_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"adConfigurationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChannelOutput {
    var result: CreateChannelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateChannelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
