const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InputSwitchConfiguration = @import("input_switch_configuration.zig").InputSwitchConfiguration;
const InputType = @import("input_type.zig").InputType;
const MultiviewConfiguration = @import("multiview_configuration.zig").MultiviewConfiguration;
const OutputHeaderConfiguration = @import("output_header_configuration.zig").OutputHeaderConfiguration;
const OutputLockingMode = @import("output_locking_mode.zig").OutputLockingMode;
const IngestEndpoint = @import("ingest_endpoint.zig").IngestEndpoint;

pub const CreateChannelInput = struct {
    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group. You can't change the name after you create the channel.
    channel_name: []const u8,

    /// A unique, case-sensitive token that you provide to ensure the idempotency of
    /// the request.
    client_token: ?[]const u8 = null,

    /// Enter any descriptive text that helps you to identify the channel.
    description: ?[]const u8 = null,

    /// The configuration for input switching based on the media quality confidence
    /// score (MQCS) as provided from AWS Elemental MediaLive. This setting is valid
    /// only when `InputType` is `CMAF`.
    input_switch_configuration: ?InputSwitchConfiguration = null,

    /// The input type is an immutable field. It defines whether the channel allows
    /// CMAF ingest, HLS ingest, or server-side multiview output. Multiview channels
    /// receive no ingest of their own. If unprovided, the value defaults to HLS.
    ///
    /// The allowed values are:
    ///
    /// * `HLS` - The HLS streaming specification (which defines M3U8 manifests and
    ///   TS segments).
    /// * `CMAF` - The DASH-IF CMAF Ingest specification (which defines CMAF
    ///   segments with optional DASH manifests).
    /// * `MULTIVIEW` – Server-side multiview. The channel receives no ingest of its
    ///   own. Instead, it composites video from the source channels in its
    ///   `MultiviewConfiguration` into a single tiled output stream.
    input_type: ?InputType = null,

    /// The multiview configuration for the channel. This setting is required when
    /// `InputType` is `MULTIVIEW`, and can't be set for any other input type.
    multiview_configuration: ?MultiviewConfiguration = null,

    /// The settings for what common media server data (CMSD) headers AWS Elemental
    /// MediaPackage includes in responses to the CDN. This setting is valid only
    /// when `InputType` is `CMAF`.
    output_header_configuration: ?OutputHeaderConfiguration = null,

    /// The output locking mode for the channel. This setting is only valid when
    /// `InputType` is `CMAF`. This value is immutable after channel creation. If
    /// you don't specify a value, the default is `EPOCH_LOCKED`.
    ///
    /// The allowed values are:
    ///
    /// * `EPOCH_LOCKED` - The channel uses epoch-locked behavior with deterministic
    ///   sequence numbering and fixed segment boundaries aligned to epoch time.
    ///   This mode supports cross-region synchronization and failover.
    /// * `NON_EPOCH_LOCKED` - The channel uses non-epoch-locked behavior with
    ///   duration-based segment combining and monotonically increasing sequence
    ///   numbers starting from 0. This mode does not support cross-region
    ///   synchronization or failover.
    output_locking_mode: ?OutputLockingMode = null,

    /// A comma-separated list of tag key:value pairs that you define. For example:
    ///
    /// `"Key1": "Value1",`
    ///
    /// `"Key2": "Value2"`
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .client_token = "ClientToken",
        .description = "Description",
        .input_switch_configuration = "InputSwitchConfiguration",
        .input_type = "InputType",
        .multiview_configuration = "MultiviewConfiguration",
        .output_header_configuration = "OutputHeaderConfiguration",
        .output_locking_mode = "OutputLockingMode",
        .tags = "Tags",
    };
};

pub const CreateChannelOutput = struct {
    /// The Amazon Resource Name (ARN) associated with the resource.
    arn: []const u8,

    /// The multiview channels, in the same channel group, that list this channel as
    /// an available source. This is a read-only field. You can't delete a channel
    /// while any multiview channel still lists it as a source. Use this field to
    /// find the multiview channels that you need to update first.
    attached_multiview_channels: ?[]const []const u8 = null,

    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group.
    channel_name: []const u8,

    /// The date and time the channel was created.
    created_at: i64,

    /// The description for your channel.
    description: ?[]const u8 = null,

    /// The current Entity Tag (ETag) associated with this resource. The entity tag
    /// can be used to safely make concurrent updates to the resource.
    e_tag: ?[]const u8 = null,

    ingest_endpoints: ?[]const IngestEndpoint = null,

    /// The configuration for input switching based on the media quality confidence
    /// score (MQCS) as provided from AWS Elemental MediaLive. This setting is valid
    /// only when `InputType` is `CMAF`.
    input_switch_configuration: ?InputSwitchConfiguration = null,

    /// The input type is an immutable field. It defines whether the channel allows
    /// CMAF ingest, HLS ingest, or server-side multiview output. Multiview channels
    /// receive no ingest of their own. If unprovided, the value defaults to HLS.
    ///
    /// The allowed values are:
    ///
    /// * `HLS` - The HLS streaming specification (which defines M3U8 manifests and
    ///   TS segments).
    /// * `CMAF` - The DASH-IF CMAF Ingest specification (which defines CMAF
    ///   segments with optional DASH manifests).
    /// * `MULTIVIEW` – Server-side multiview. The channel receives no ingest of its
    ///   own. Instead, it composites video from the source channels in its
    ///   `MultiviewConfiguration` into a single tiled output stream.
    input_type: ?InputType = null,

    /// The date and time the channel was modified.
    modified_at: i64,

    /// The multiview configuration for the channel. This is present only when
    /// `InputType` is `MULTIVIEW`.
    multiview_configuration: ?MultiviewConfiguration = null,

    /// The settings for what common media server data (CMSD) headers AWS Elemental
    /// MediaPackage includes in responses to the CDN. This setting is valid only
    /// when `InputType` is `CMAF`.
    output_header_configuration: ?OutputHeaderConfiguration = null,

    /// The output locking mode configured for the channel.
    ///
    /// The allowed values are:
    ///
    /// * `EPOCH_LOCKED` - The channel uses epoch-locked behavior with deterministic
    ///   sequence numbering and fixed segment boundaries aligned to epoch time.
    /// * `NON_EPOCH_LOCKED` - The channel uses non-epoch-locked behavior with
    ///   duration-based segment combining and monotonically increasing sequence
    ///   numbers starting from 0.
    output_locking_mode: ?OutputLockingMode = null,

    /// The comma-separated list of tag key:value pairs assigned to the channel.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .attached_multiview_channels = "AttachedMultiviewChannels",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .created_at = "CreatedAt",
        .description = "Description",
        .e_tag = "ETag",
        .ingest_endpoints = "IngestEndpoints",
        .input_switch_configuration = "InputSwitchConfiguration",
        .input_type = "InputType",
        .modified_at = "ModifiedAt",
        .multiview_configuration = "MultiviewConfiguration",
        .output_header_configuration = "OutputHeaderConfiguration",
        .output_locking_mode = "OutputLockingMode",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChannelInput, options: CallOptions) !CreateChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediapackagev2", client.config.http_client.clock_skew_offset);

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
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channelGroup/");
    try path_buf.appendSlice(allocator, input.channel_group_name);
    try path_buf.appendSlice(allocator, "/channel");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelName\":");
    try aws.json.writeValue(@TypeOf(input.channel_name), input.channel_name, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.input_switch_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InputSwitchConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.input_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"InputType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.multiview_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MultiviewConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.output_header_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OutputHeaderConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.output_locking_mode) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"OutputLockingMode\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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
    if (input.client_token) |v| {
        try request.headers.put(allocator, "x-amzn-client-token", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChannelOutput {
    const result: CreateChannelOutput = try aws.json.parseJsonObject(
        CreateChannelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
