const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelSummary = @import("channel_summary.zig").ChannelSummary;

pub const ListChannelsInput = struct {
    /// Filters the channel list to match the specified ad configuration ARN.
    filter_by_ad_configuration_arn: ?[]const u8 = null,

    /// Filters the channel list to match the specified name.
    filter_by_name: ?[]const u8 = null,

    /// Filters the channel list to match the specified policy.
    filter_by_playback_restriction_policy_arn: ?[]const u8 = null,

    /// Filters the channel list to match the specified recording-configuration ARN.
    filter_by_recording_configuration_arn: ?[]const u8 = null,

    /// Maximum number of channels to return. Default: 100.
    max_results: ?i32 = null,

    /// The first channel to retrieve. This is used for pagination; see the
    /// `nextToken` response field.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter_by_ad_configuration_arn = "filterByAdConfigurationArn",
        .filter_by_name = "filterByName",
        .filter_by_playback_restriction_policy_arn = "filterByPlaybackRestrictionPolicyArn",
        .filter_by_recording_configuration_arn = "filterByRecordingConfigurationArn",
        .max_results = "maxResults",
        .next_token = "nextToken",
    };
};

pub const ListChannelsOutput = struct {
    /// List of the matching channels.
    channels: ?[]const ChannelSummary = null,

    /// If there are more channels than `maxResults`, use `nextToken` in the request
    /// to get the next set.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channels = "channels",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListChannelsInput, options: CallOptions) !ListChannelsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListChannelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivs", "ivs", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListChannels";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filter_by_ad_configuration_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterByAdConfigurationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_by_name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterByName\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_by_playback_restriction_policy_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterByPlaybackRestrictionPolicyArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.filter_by_recording_configuration_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"filterByRecordingConfigurationArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"maxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"nextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListChannelsOutput {
    var result: ListChannelsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListChannelsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
