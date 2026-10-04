const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaTailorPlaybackConfiguration = @import("media_tailor_playback_configuration.zig").MediaTailorPlaybackConfiguration;
const PostRollConfiguration = @import("post_roll_configuration.zig").PostRollConfiguration;
const AdConfiguration = @import("ad_configuration.zig").AdConfiguration;

pub const UpdateAdConfigurationInput = struct {
    /// ARN of the ad configuration to be updated.
    arn: []const u8,

    /// List of integration configurations with MediaTailor resources. The first
    /// item in the list is the default playback configuration used for the ad
    /// configuration. To select a different configuration per viewing session, see
    /// [Generate and Sign IVS Playback
    /// Tokens](https://docs.aws.amazon.com/ivs/latest/LowLatencyUserGuide/private-channels-generate-tokens.html).
    media_tailor_playback_configurations: ?[]const MediaTailorPlaybackConfiguration = null,

    /// Ad configuration name. The value does not need to be unique.
    name: ?[]const u8 = null,

    /// Configuration for the post-roll ad break to use for this ad configuration.
    post_roll_configuration: ?PostRollConfiguration = null,

    pub const json_field_names = .{
        .arn = "arn",
        .media_tailor_playback_configurations = "mediaTailorPlaybackConfigurations",
        .name = "name",
        .post_roll_configuration = "postRollConfiguration",
    };
};

pub const UpdateAdConfigurationOutput = struct {
    /// Object specifying the updated ad configuration.
    ad_configuration: ?AdConfiguration = null,

    pub const json_field_names = .{
        .ad_configuration = "adConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAdConfigurationInput, options: CallOptions) !UpdateAdConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAdConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateAdConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"arn\":");
    try aws.json.writeValue(@TypeOf(input.arn), input.arn, allocator, &body_buf);
    has_prev = true;
    if (input.media_tailor_playback_configurations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"mediaTailorPlaybackConfigurations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.post_roll_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"postRollConfiguration\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAdConfigurationOutput {
    const result: UpdateAdConfigurationOutput = try aws.json.parseJsonObject(
        UpdateAdConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
