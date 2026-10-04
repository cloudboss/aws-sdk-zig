const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PlaybackRestrictionPolicy = @import("playback_restriction_policy.zig").PlaybackRestrictionPolicy;

pub const CreatePlaybackRestrictionPolicyInput = struct {
    /// A list of country codes that control geoblocking restriction. Allowed values
    /// are the officially assigned [ISO 3166-1
    /// alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) codes. Default:
    /// All countries (an empty array).
    allowed_countries: ?[]const []const u8 = null,

    /// A list of origin sites that control CORS restriction. Allowed values are the
    /// same as valid values of the Origin header defined at
    /// [https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Origin](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Origin). Default: All origins (an empty array).
    allowed_origins: ?[]const []const u8 = null,

    /// Whether channel playback is constrained by origin site. Default: `false`.
    enable_strict_origin_enforcement: ?bool = null,

    /// Playback-restriction-policy name. The value does not need to be unique.
    name: ?[]const u8 = null,

    /// Array of 1-50 maps, each of the form `string:string (key:value)`. See [Best
    /// practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .allowed_countries = "allowedCountries",
        .allowed_origins = "allowedOrigins",
        .enable_strict_origin_enforcement = "enableStrictOriginEnforcement",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreatePlaybackRestrictionPolicyOutput = struct {
    playback_restriction_policy: ?PlaybackRestrictionPolicy = null,

    pub const json_field_names = .{
        .playback_restriction_policy = "playbackRestrictionPolicy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePlaybackRestrictionPolicyInput, options: CallOptions) !CreatePlaybackRestrictionPolicyOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePlaybackRestrictionPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreatePlaybackRestrictionPolicy";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.allowed_countries) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowedCountries\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.allowed_origins) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"allowedOrigins\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.enable_strict_origin_enforcement) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"enableStrictOriginEnforcement\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"name\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePlaybackRestrictionPolicyOutput {
    var result: CreatePlaybackRestrictionPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePlaybackRestrictionPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
