const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChatEvent = @import("chat_event.zig").ChatEvent;
const NewSessionDetails = @import("new_session_details.zig").NewSessionDetails;

pub const SendChatIntegrationEventInput = struct {
    /// Chat system identifier, used in part to uniquely identify chat. This is
    /// associated with the Amazon Connect
    /// instance and flow to be used to start chats. For Server Migration Service,
    /// this is the phone number destination of inbound
    /// Server Migration Service messages represented by an Amazon Web Services End
    /// User Messaging phone number ARN.
    destination_id: []const u8,

    /// Chat integration event payload
    event: ChatEvent,

    /// Contact properties to apply when starting a new chat. If the integration
    /// event is handled with an existing chat,
    /// this is ignored.
    new_session_details: ?NewSessionDetails = null,

    /// External identifier of chat customer participant, used in part to uniquely
    /// identify a chat. For SMS, this is the
    /// E164 phone number of the chat customer participant.
    source_id: []const u8,

    /// Classification of a channel. This is used in part to uniquely identify chat.
    ///
    /// Valid value: `["connect:sms", connect:"WhatsApp"]`
    subtype: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_id = "DestinationId",
        .event = "Event",
        .new_session_details = "NewSessionDetails",
        .source_id = "SourceId",
        .subtype = "Subtype",
    };
};

pub const SendChatIntegrationEventOutput = struct {
    /// Identifier of chat contact used to handle integration event. This may be
    /// null if the integration event is not
    /// valid without an already existing chat contact.
    initial_contact_id: ?[]const u8 = null,

    /// Whether handling the integration event resulted in creating a new chat or
    /// acting on existing chat.
    new_chat_created: ?bool = null,

    pub const json_field_names = .{
        .initial_contact_id = "InitialContactId",
        .new_chat_created = "NewChatCreated",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SendChatIntegrationEventInput, options: CallOptions) !SendChatIntegrationEventOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: SendChatIntegrationEventInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/chat-integration-event";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationId\":");
    try aws.json.writeValue(@TypeOf(input.destination_id), input.destination_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Event\":");
    try aws.json.writeValue(@TypeOf(input.event), input.event, allocator, &body_buf);
    has_prev = true;
    if (input.new_session_details) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NewSessionDetails\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"SourceId\":");
    try aws.json.writeValue(@TypeOf(input.source_id), input.source_id, allocator, &body_buf);
    has_prev = true;
    if (input.subtype) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Subtype\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SendChatIntegrationEventOutput {
    var result: SendChatIntegrationEventOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(SendChatIntegrationEventOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
