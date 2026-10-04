const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MediaTailorPlaybackConfiguration = @import("media_tailor_playback_configuration.zig").MediaTailorPlaybackConfiguration;
const PostRollConfiguration = @import("post_roll_configuration.zig").PostRollConfiguration;
const AdConfiguration = @import("ad_configuration.zig").AdConfiguration;

pub const CreateAdConfigurationInput = struct {
    /// List of integration configurations with MediaTailor resources. The first
    /// item in the list is the default playback configuration used for the ad
    /// configuration. To select a different configuration per viewing session, see
    /// [Generate and Sign IVS Playback
    /// Tokens](https://docs.aws.amazon.com/ivs/latest/LowLatencyUserGuide/private-channels-generate-tokens.html).
    media_tailor_playback_configurations: []const MediaTailorPlaybackConfiguration,

    /// Ad configuration name. Defaults to “”.
    name: ?[]const u8 = null,

    /// Configuration for the post-roll ad break to use for this ad configuration.
    /// Default: disabled (`enabled` set to false, `durationSeconds` set to 15).
    post_roll_configuration: ?PostRollConfiguration = null,

    /// Array of 1-50 maps, each of the form `string:string (key:value)`. See [Best
    /// practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .media_tailor_playback_configurations = "mediaTailorPlaybackConfigurations",
        .name = "name",
        .post_roll_configuration = "postRollConfiguration",
        .tags = "tags",
    };
};

pub const CreateAdConfigurationOutput = struct {
    ad_configuration: ?AdConfiguration = null,

    pub const json_field_names = .{
        .ad_configuration = "adConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAdConfigurationInput, options: CallOptions) !CreateAdConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAdConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateAdConfiguration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"mediaTailorPlaybackConfigurations\":");
    try aws.json.writeValue(@TypeOf(input.media_tailor_playback_configurations), input.media_tailor_playback_configurations, allocator, &body_buf);
    has_prev = true;
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
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAdConfigurationOutput {
    const result: CreateAdConfigurationOutput = try aws.json.parseJsonObject(
        CreateAdConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
