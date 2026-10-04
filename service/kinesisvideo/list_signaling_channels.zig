const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelNameCondition = @import("channel_name_condition.zig").ChannelNameCondition;
const ChannelInfo = @import("channel_info.zig").ChannelInfo;

pub const ListSignalingChannelsInput = struct {
    /// Optional: Returns only the channels that satisfy a specific condition.
    channel_name_condition: ?ChannelNameCondition = null,

    /// The maximum number of channels to return in the response. The default is
    /// 500.
    max_results: ?i32 = null,

    /// If you specify this parameter, when the result of a `ListSignalingChannels`
    /// operation is truncated, the call returns the `NextToken` in the response. To
    /// get another batch of channels, provide this token in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_name_condition = "ChannelNameCondition",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListSignalingChannelsOutput = struct {
    /// An array of `ChannelInfo` objects.
    channel_info_list: ?[]const ChannelInfo = null,

    /// If the response is truncated, the call returns this element with a token. To
    /// get the
    /// next batch of streams, use this token in your next request.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_info_list = "ChannelInfoList",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSignalingChannelsInput, options: CallOptions) !ListSignalingChannelsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "kinesisvideo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSignalingChannelsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("kinesisvideo", "Kinesis Video", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listSignalingChannels";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.channel_name_condition) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ChannelNameCondition\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSignalingChannelsOutput {
    var result: ListSignalingChannelsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListSignalingChannelsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
