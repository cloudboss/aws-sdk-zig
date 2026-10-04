const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LogType = @import("log_type.zig").LogType;

pub const ConfigureLogsForChannelInput = struct {
    /// The name of the channel.
    channel_name: []const u8,

    /// The types of logs to collect.
    log_types: []const LogType,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .log_types = "LogTypes",
    };
};

pub const ConfigureLogsForChannelOutput = struct {
    /// The name of the channel.
    channel_name: ?[]const u8 = null,

    /// The types of logs collected.
    log_types: ?[]const LogType = null,

    pub const json_field_names = .{
        .channel_name = "ChannelName",
        .log_types = "LogTypes",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ConfigureLogsForChannelInput, options: CallOptions) !ConfigureLogsForChannelOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediatailor", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ConfigureLogsForChannelInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.mediatailor", "MediaTailor", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/configureLogs/channel";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelName\":");
    try aws.json.writeValue(@TypeOf(input.channel_name), input.channel_name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"LogTypes\":");
    try aws.json.writeValue(@TypeOf(input.log_types), input.log_types, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ConfigureLogsForChannelOutput {
    const result: ConfigureLogsForChannelOutput = try aws.json.parseJsonObject(
        ConfigureLogsForChannelOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
