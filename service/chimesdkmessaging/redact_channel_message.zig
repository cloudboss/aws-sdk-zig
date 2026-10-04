const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RedactChannelMessageInput = struct {
    /// The ARN of the channel containing the messages that you want to redact.
    channel_arn: []const u8,

    /// The ARN of the `AppInstanceUser` or `AppInstanceBot`
    /// that makes the API call.
    chime_bearer: []const u8,

    /// The ID of the message being redacted.
    message_id: []const u8,

    /// The ID of the SubChannel in the request.
    sub_channel_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .chime_bearer = "ChimeBearer",
        .message_id = "MessageId",
        .sub_channel_id = "SubChannelId",
    };
};

pub const RedactChannelMessageOutput = struct {
    /// The ARN of the channel containing the messages that you want to redact.
    channel_arn: ?[]const u8 = null,

    /// The ID of the message being redacted.
    message_id: ?[]const u8 = null,

    /// The ID of the SubChannel in the response.
    ///
    /// Only required when redacting messages in a SubChannel that the user belongs
    /// to.
    sub_channel_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .message_id = "MessageId",
        .sub_channel_id = "SubChannelId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RedactChannelMessageInput, options: CallOptions) !RedactChannelMessageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: RedactChannelMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_arn);
    try path_buf.appendSlice(allocator, "/messages/");
    try path_buf.appendSlice(allocator, input.message_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "operation=redact");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.sub_channel_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SubChannelId\":");
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
    try request.headers.put(allocator, "x-amz-chime-bearer", input.chime_bearer);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RedactChannelMessageOutput {
    var result: RedactChannelMessageOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(RedactChannelMessageOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
