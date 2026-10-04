const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChatTokenCapability = @import("chat_token_capability.zig").ChatTokenCapability;

pub const CreateChatTokenInput = struct {
    /// Application-provided attributes to encode into the token and attach to a
    /// chat session.
    /// Map keys and values can contain UTF-8 encoded text. The maximum length of
    /// this field is 1
    /// KB total.
    attributes: ?[]const aws.map.StringMapEntry = null,

    /// Set of capabilities that the user is allowed to perform in the room.
    /// Default: None (the
    /// capability to view messages is implicitly included in all requests).
    capabilities: ?[]const ChatTokenCapability = null,

    /// Identifier of the room that the client is trying to access. Currently this
    /// must be an
    /// ARN.
    room_identifier: []const u8,

    /// Session duration (in minutes), after which the session expires. Default: 60
    /// (1
    /// hour).
    session_duration_in_minutes: ?i32 = null,

    /// Application-provided ID that uniquely identifies the user associated with
    /// this token.
    /// This can be any UTF-8 encoded text.
    user_id: []const u8,

    pub const json_field_names = .{
        .attributes = "attributes",
        .capabilities = "capabilities",
        .room_identifier = "roomIdentifier",
        .session_duration_in_minutes = "sessionDurationInMinutes",
        .user_id = "userId",
    };
};

pub const CreateChatTokenOutput = struct {
    /// Time after which an end user's session is no longer valid. This is an ISO
    /// 8601
    /// timestamp; *note that this is returned as a string*.
    session_expiration_time: ?i64 = null,

    /// The issued client token, encrypted.
    token: ?[]const u8 = null,

    /// Time after which the token is no longer valid and cannot be used to connect
    /// to a room.
    /// This is an ISO 8601 timestamp; *note that this is returned as a
    /// string*.
    token_expiration_time: ?i64 = null,

    pub const json_field_names = .{
        .session_expiration_time = "sessionExpirationTime",
        .token = "token",
        .token_expiration_time = "tokenExpirationTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateChatTokenInput, options: CallOptions) !CreateChatTokenOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ivschat", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateChatTokenInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivschat", "ivschat", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateChatToken";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.attributes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"attributes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.capabilities) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"capabilities\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roomIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.room_identifier), input.room_identifier, allocator, &body_buf);
    has_prev = true;
    if (input.session_duration_in_minutes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"sessionDurationInMinutes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"userId\":");
    try aws.json.writeValue(@TypeOf(input.user_id), input.user_id, allocator, &body_buf);
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

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateChatTokenOutput {
    var result: CreateChatTokenOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateChatTokenOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
