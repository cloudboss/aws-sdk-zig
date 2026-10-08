const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DisconnectUserInput = struct {
    /// Reason for disconnecting the user.
    reason: ?[]const u8 = null,

    /// Identifier of the room from which the user's clients should be disconnected.
    /// Currently
    /// this must be an ARN.
    room_identifier: []const u8,

    /// ID of the user (connection) to disconnect from the room.
    user_id: []const u8,

    pub const json_field_names = .{
        .reason = "reason",
        .room_identifier = "roomIdentifier",
        .user_id = "userId",
    };
};

pub const DisconnectUserOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DisconnectUserInput, options: CallOptions) !DisconnectUserOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DisconnectUserInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ivschat", "ivschat", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/DisconnectUser";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.reason) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"reason\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"roomIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.room_identifier), input.room_identifier, allocator, &body_buf);
    has_prev = true;
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DisconnectUserOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: DisconnectUserOutput = .{};

    return result;
}
