const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChannelMessageCallback = @import("channel_message_callback.zig").ChannelMessageCallback;

pub const ChannelFlowCallbackInput = struct {
    /// The identifier passed to the processor by the service when invoked. Use the
    /// identifier to call back the service.
    callback_id: []const u8,

    /// The ARN of the channel.
    channel_arn: []const u8,

    /// Stores information about the processed message.
    channel_message: ChannelMessageCallback,

    /// When a processor determines that a message needs to be `DENIED`, pass this
    /// parameter with a value of true.
    delete_resource: ?bool = null,

    pub const json_field_names = .{
        .callback_id = "CallbackId",
        .channel_arn = "ChannelArn",
        .channel_message = "ChannelMessage",
        .delete_resource = "DeleteResource",
    };
};

pub const ChannelFlowCallbackOutput = struct {
    /// The call back ID passed in the request.
    callback_id: ?[]const u8 = null,

    /// The ARN of the channel.
    channel_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .callback_id = "CallbackId",
        .channel_arn = "ChannelArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ChannelFlowCallbackInput, options: CallOptions) !ChannelFlowCallbackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "chime", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ChannelFlowCallbackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_arn);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=channel-flow-callback");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CallbackId\":");
    try aws.json.writeValue(@TypeOf(input.callback_id), input.callback_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ChannelMessage\":");
    try aws.json.writeValue(@TypeOf(input.channel_message), input.channel_message, allocator, &body_buf);
    has_prev = true;
    if (input.delete_resource) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeleteResource\":");
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
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ChannelFlowCallbackOutput {
    var result: ChannelFlowCallbackOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ChannelFlowCallbackOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
