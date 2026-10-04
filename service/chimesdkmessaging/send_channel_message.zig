const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MessageAttributeValue = @import("message_attribute_value.zig").MessageAttributeValue;
const ChannelMessagePersistenceType = @import("channel_message_persistence_type.zig").ChannelMessagePersistenceType;
const PushNotificationConfiguration = @import("push_notification_configuration.zig").PushNotificationConfiguration;
const Target = @import("target.zig").Target;
const ChannelMessageType = @import("channel_message_type.zig").ChannelMessageType;
const ChannelMessageStatusStructure = @import("channel_message_status_structure.zig").ChannelMessageStatusStructure;

pub const SendChannelMessageInput = struct {
    /// The ARN of the channel.
    channel_arn: []const u8,

    /// The ARN of the `AppInstanceUser` or `AppInstanceBot`
    /// that makes the API call.
    chime_bearer: []const u8,

    /// The `Idempotency` token for each client request.
    client_request_token: []const u8,

    /// The content of the channel message.
    content: []const u8,

    /// The content type of the channel message.
    content_type: ?[]const u8 = null,

    /// The attributes for the message, used for message filtering along with a
    /// `FilterRule` defined in the `PushNotificationPreferences`.
    message_attributes: ?[]const aws.map.MapEntry(MessageAttributeValue) = null,

    /// The optional metadata for each message.
    metadata: ?[]const u8 = null,

    /// Boolean that controls whether the message is persisted on the back end.
    /// Required.
    persistence: ChannelMessagePersistenceType,

    /// The push notification configuration of the message.
    push_notification: ?PushNotificationConfiguration = null,

    /// The ID of the SubChannel in the request.
    sub_channel_id: ?[]const u8 = null,

    /// The target of a message. Must be a member of the channel, such as another
    /// user, a bot, or the sender. Only the target and the sender can view targeted
    /// messages.
    /// Only users who can see targeted messages can take actions on them. However,
    /// administrators can delete targeted messages that they can’t see.
    target: ?[]const Target = null,

    /// The type of message, `STANDARD` or `CONTROL`.
    ///
    /// `STANDARD` messages can be up to 4KB in size and contain metadata. Metadata
    /// is arbitrary,
    /// and you can use it in a variety of ways, such as containing a link to an
    /// attachment.
    ///
    /// `CONTROL` messages are limited to 30 bytes and do not contain metadata.
    @"type": ChannelMessageType,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .chime_bearer = "ChimeBearer",
        .client_request_token = "ClientRequestToken",
        .content = "Content",
        .content_type = "ContentType",
        .message_attributes = "MessageAttributes",
        .metadata = "Metadata",
        .persistence = "Persistence",
        .push_notification = "PushNotification",
        .sub_channel_id = "SubChannelId",
        .target = "Target",
        .@"type" = "Type",
    };
};

pub const SendChannelMessageOutput = struct {
    /// The ARN of the channel.
    channel_arn: ?[]const u8 = null,

    /// The ID string assigned to each message.
    message_id: ?[]const u8 = null,

    /// The status of the channel message.
    status: ?ChannelMessageStatusStructure = null,

    /// The ID of the SubChannel in the response.
    sub_channel_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .message_id = "MessageId",
        .status = "Status",
        .sub_channel_id = "SubChannelId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendChannelMessageInput, options: CallOptions) !SendChannelMessageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SendChannelMessageInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("messaging-chime", "Chime SDK Messaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/channels/");
    try path_buf.appendSlice(allocator, input.channel_arn);
    try path_buf.appendSlice(allocator, "/messages");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ClientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Content\":");
    try aws.json.writeValue(@TypeOf(input.content), input.content, allocator, &body_buf);
    has_prev = true;
    if (input.content_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ContentType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.message_attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MessageAttributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Metadata\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Persistence\":");
    try aws.json.writeValue(@TypeOf(input.persistence), input.persistence, allocator, &body_buf);
    has_prev = true;
    if (input.push_notification) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PushNotification\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sub_channel_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SubChannelId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Target\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Type\":");
    try aws.json.writeValue(@TypeOf(input.@"type"), input.@"type", allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    try request.headers.put(allocator, "x-amz-chime-bearer", input.chime_bearer);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendChannelMessageOutput {
    const result: SendChannelMessageOutput = try aws.json.parseJsonObject(
        SendChannelMessageOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
