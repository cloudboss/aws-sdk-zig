const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ConnectionType = @import("connection_type.zig").ConnectionType;
const ConnectionCredentials = @import("connection_credentials.zig").ConnectionCredentials;
const WebRTCConnection = @import("web_rtc_connection.zig").WebRTCConnection;
const Websocket = @import("websocket.zig").Websocket;

pub const CreateParticipantConnectionInput = struct {
    /// Amazon Connect Participant is used to mark the participant as connected for
    /// customer
    /// participant in message streaming, as well as for agent or manager
    /// participant in
    /// non-streaming chats.
    connect_participant: ?bool = null,

    /// This is a header parameter.
    ///
    /// The ParticipantToken as obtained from
    /// [StartChatContact](https://docs.aws.amazon.com/connect/latest/APIReference/API_StartChatContact.html)
    /// API response.
    participant_token: []const u8,

    /// Type of connection information required. If you need
    /// `CONNECTION_CREDENTIALS` along with marking participant as connected,
    /// pass `CONNECTION_CREDENTIALS` in `Type`.
    type: ?[]const ConnectionType = null,

    pub const json_field_names = .{
        .connect_participant = "ConnectParticipant",
        .participant_token = "ParticipantToken",
        .type = "Type",
    };
};

pub const CreateParticipantConnectionOutput = struct {
    /// Creates the participant's connection credentials. The authentication token
    /// associated
    /// with the participant's connection.
    connection_credentials: ?ConnectionCredentials = null,

    /// Creates the participant's WebRTC connection data required for the client
    /// application
    /// (mobile application or website) to connect to the call.
    web_rtc_connection: ?WebRTCConnection = null,

    /// Creates the participant's websocket connection.
    websocket: ?Websocket = null,

    pub const json_field_names = .{
        .connection_credentials = "ConnectionCredentials",
        .web_rtc_connection = "WebRTCConnection",
        .websocket = "Websocket",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateParticipantConnectionInput, options: CallOptions) !CreateParticipantConnectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateParticipantConnectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("participant.connect", "ConnectParticipant", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/participant/connection";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.connect_participant) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ConnectParticipant\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Type\":");
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
    try request.headers.put(allocator, "X-Amz-Bearer", input.participant_token);

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateParticipantConnectionOutput {
    const result: CreateParticipantConnectionOutput = try aws.json.parseJsonObject(
        CreateParticipantConnectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
