const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IngestEndpoint = @import("ingest_endpoint.zig").IngestEndpoint;
const InputSwitchConfiguration = @import("input_switch_configuration.zig").InputSwitchConfiguration;
const InputType = @import("input_type.zig").InputType;
const OutputHeaderConfiguration = @import("output_header_configuration.zig").OutputHeaderConfiguration;

pub const GetChannelInput = struct {
    /// The name that describes the channel group. The name is the primary
    /// identifier for the channel group, and must be unique for your account in the
    /// AWS Region.
    channel_group_name: []const u8,

    /// The name that describes the channel. The name is the primary identifier for
    /// the channel, and must be unique for your account in the AWS Region and
    /// channel group.
    channel_name: []const u8,

    pub const json_field_names = .{
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
    };
};

pub const GetChannelOutput = struct {
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

    /// The input type will be an immutable field which will be used to define
    /// whether the channel will allow CMAF ingest or HLS ingest. If unprovided, it
    /// will default to HLS to preserve current behavior.
    ///
    /// The allowed values are:
    ///
    /// * `HLS` - The HLS streaming specification (which defines M3U8 manifests and
    ///   TS segments).
    /// * `CMAF` - The DASH-IF CMAF Ingest specification (which defines CMAF
    ///   segments with optional DASH manifests).
    input_type: ?InputType = null,

    /// The date and time the channel was modified.
    modified_at: i64,

    /// The settings for what common media server data (CMSD) headers AWS Elemental
    /// MediaPackage includes in responses to the CDN. This setting is valid only
    /// when `InputType` is `CMAF`.
    output_header_configuration: ?OutputHeaderConfiguration = null,

    /// The time that the channel was last reset.
    reset_at: ?i64 = null,

    /// The comma-separated list of tag key:value pairs assigned to the channel.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_group_name = "ChannelGroupName",
        .channel_name = "ChannelName",
        .created_at = "CreatedAt",
        .description = "Description",
        .e_tag = "ETag",
        .ingest_endpoints = "IngestEndpoints",
        .input_switch_configuration = "InputSwitchConfiguration",
        .input_type = "InputType",
        .modified_at = "ModifiedAt",
        .output_header_configuration = "OutputHeaderConfiguration",
        .reset_at = "ResetAt",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetChannelInput, options: CallOptions) !GetChannelOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackagev2", "MediaPackageV2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channelGroup/");
    try path_buf.appendSlice(allocator, input.channel_group_name);
    try path_buf.appendSlice(allocator, "/channel/");
    try path_buf.appendSlice(allocator, input.channel_name);
    try path_buf.appendSlice(allocator, "/");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetChannelOutput {
    var result: GetChannelOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetChannelOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
