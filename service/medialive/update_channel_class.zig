const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelClass = @import("channel_class.zig").ChannelClass;
const OutputDestination = @import("output_destination.zig").OutputDestination;
const Channel = @import("channel.zig").Channel;

pub const UpdateChannelClassInput = struct {
    /// The channel class that you wish to update this channel to use.
    channel_class: ChannelClass,

    /// Channel Id of the channel whose class should be updated.
    channel_id: []const u8,

    /// A list of output destinations for this channel.
    destinations: ?[]const OutputDestination = null,

    pub const json_field_names = .{
        .channel_class = "ChannelClass",
        .channel_id = "ChannelId",
        .destinations = "Destinations",
    };
};

pub const UpdateChannelClassOutput = struct {
    channel: ?Channel = null,

    pub const json_field_names = .{
        .channel = "Channel",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateChannelClassInput, options: CallOptions) !UpdateChannelClassOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medialive", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateChannelClassInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medialive", "MediaLive", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/prod/channels/");
    try path_buf.appendSlice(allocator, input.channel_id);
    try path_buf.appendSlice(allocator, "/channelClass");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelClass\":");
    try aws.json.writeValue(@TypeOf(input.channel_class), input.channel_class, allocator, &body_buf);
    has_prev = true;
    if (input.destinations) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Destinations\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateChannelClassOutput {
    const result: UpdateChannelClassOutput = try aws.json.parseJsonObject(
        UpdateChannelClassOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
